#!/usr/bin/env python
"""
This module implements a rights calculation for clusters.  It basically just 
utilizes the 'access' column of the htitem and assigns either '2' or '1' 
('in-copyright cost' and public-domain cost', respectively) based on the 
'allow' or 'deny' indicaters for a cluster.  All items must have the
same access indication, otherwise it'll be marked as '0' ('undetermined').    
"""

import sys
#import phdb_utils
import MySQLdb
#import datetime

VERBOSE = 0

def get_connection():
    # open DB connection
    try:
        conn = MySQLdb.connect (host = "mysql-htdev",
                            port=3306,
                            user = "pulintz",
                            passwd = "100YOS*",
                            db = "pulintz_mdp")
    except MySQLdb.Error, e:
        print "Couldn't get connection."
        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit()
    return conn


def run_list_query(cursor, query):
    """ Generic query runner, appropriate for queries that return
    simple lists. """
    if VERBOSE:
        print query
    try:
        cursor.execute(query)
    except MySQLdb.Error, e:
        print "[run_list_query] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit(1)
    items = []
    if (cursor.rowcount > 0):
        while(1):
            row = cursor.fetchone()
            if row == None:
                break
            items.append(row[0])
    return items



def cluster_rights_main():
    """ main routine to calculate cluster rights. """
    
    conn = get_connection()
    cursor = conn.cursor()
    
    ### outer loop over all clusters ###
    print "Grabbing clusters..."
    query1 = "SELECT cluster_id FROM cluster"
    all_clusters = run_list_query(cursor, query1)
    
    citer = 0
    print "iterating..."
    for cid in all_clusters:
        citer += 1
        
        # get the access designation of all volumes in a cluster #
        query2 = """SELECT access FROM htitem, cluster_htitem_jn 
                    WHERE cluster_htitem_jn.volume_id = htitem.volume_id 
                    AND cluster_id = %s""" % cid
        accesses = run_list_query(cursor, query2)
        
        # calculate access right designation from results #
        accs = set([])
        for a in accesses:
            accs.add(a)
        
        # get appropriate update query
        rid = -1
        if (len(accs) == 0):
            # shouldn't happen
            print "problem: %s, cost rights len = 0" % cid
            continue
        elif (len(accs) > 1):
            # rights discrepancy, assign 0
            rid = 0
        elif (len(accs) == 1):
            # consistent rights designations
            rstring = accs.pop()
            if (rstring == 'deny'):
                rid = 2
            elif (rstring == 'allow'):
                rid = 1
            else:
                print "problem rights string = %s (%s)" % (rstring, cid)

        if (rid < 0):
            print "'-1' rights id, shouldn't happen"
            sys.exit()
        
        query3 = """UPDATE cluster SET cost_rights_id = %i WHERE cluster_id = %s""" % (rid, cid) 
        try:
            if VERBOSE:
                print query3
            cursor.execute(query3)
        except MySQLdb.Error, e:
            print "Error %d: %s" % (e.args[0], e.args[1])
            print "Exiting..."
            sys.exit()  
            
        # commit every 100k
        if ((citer % 100000)==0):
            print citer
            conn.commit()
                   
    conn.commit()
    conn.close()         
    print "finished updating cluster rights."
    


if __name__ == '__main__':
    #from sys import argv
    
    cluster_rights_main()
    
    print "done."
