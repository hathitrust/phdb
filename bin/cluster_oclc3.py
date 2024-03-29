#!/usr/bin/env python
"""
This module implements a clustering approach for OCLC numbers based on 
HathiTrust data and data acquired via the OCLC Translation Table.  
This version is a re-write to try and speedup the algorithm.
v.2 - removing 'rights' queries, farm out cluster_oclc and cluster_htitem_jn
tables to core memory.
v.3 - re-implementation of the fundamental aggregation loop
"""

import sys, re
import phdb_utils
import MySQLdb
import datetime

VERBOSE = 0
NOW = datetime.datetime(2013, 4, 2)


def get_password_from_file(fn):
    infile = file(fn)
    line = infile.readline()
    return line.rstrip()


def get_connection():
    # open DB connection
    pw = get_password_from_file('/afs/umich.edu/user/p/u/pulintz/etc/.pw/ht_repository')
    try:
        conn = MySQLdb.connect (host = "mysql-htdev",
                            port=3306,
                            user = "ht_repository",
                            passwd = pw,
                            db = "ht_repository")
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


def run_single_query(cursor, query):
    """ Generic query runner, for a single result row """
    if VERBOSE:
        print query
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        result = row[0]
    except MySQLdb.Error, e:
        print "[run_single_query] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit()
    return result


def create_cluster(ccursor, ocns, vol_id):
    """ Creates a new cluster and populates tables appropriately. """
    
    # insert into cluster, get id
    ocn0 = ocns[0]
    query2 = "INSERT INTO holdings_cluster (cost_rights_id, osici, last_mod) VALUES (0, '%s', '%s')" % (ocn0, NOW)
    try:
        if VERBOSE:
            print query2
        ccursor.execute(query2)
        pkid = int(ccursor.lastrowid)
        #if ((pkid%1000) == 0):
        #    print "Creating cluster ID %i" % pkid 
        #cconn.commit()
    except MySQLdb.Error, e:
        print "[create_cluster] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit()
    # insert OCNs into cluster_oclc tables
    for nocn in ocns:
        oc = int(nocn)
        if (pkid in Cluster_oclc_d):
            #print "Adding %i to Cluster_oclc_d[%i]" % (oc, pkid)
            Cluster_oclc_d[pkid].add(oc)
            #print "Cluster_oclc_d = %s" % Cluster_oclc_d
        else:
            #print "Adding %i to Cluster_oclc_d[%i]" % (oc, pkid)
            Cluster_oclc_d[pkid] = set([oc])
            #print "Cluster_oclc_d = %s" % Cluster_oclc_d
        if (Oclc_cluster_d.has_key(oc)):
            #print "Adding %i to Oclc_cluster_d[%i]" % (pkid, oc)
            #print Oclc_cluster_d
            #print "Len: %i" % len(Oclc_cluster_d[oc])
            print "2 cluster oclc: vid=%s, oc=%i, pkid=%i, cid=%s" % (vol_id, oc, pkid, Oclc_cluster_d[oc])
            sys.exit()
        else:
            Oclc_cluster_d[oc] = pkid    
            #print "Adding %i to Oclc_cluster_d[%i]" % (pkid, oc)
            #print "Oclc_cluster_d = %s" % Oclc_cluster_d
             
    # insert volume_id into cluster_htitem_jn
    query4 =  """ INSERT INTO holdings_cluster_htitem_jn (cluster_id, volume_id)
                  VALUES (%s, '%s') """ % (pkid, vol_id)
    try:
        if VERBOSE:
            print query4
        ccursor.execute(query4)
    except MySQLdb.Error, e:
        print "[create_cluster] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit()
    
    #cconn.commit()
    #cconn.close()    
    return pkid


def merge_clusters(cid1, cid2):
    """ Merges clusters together.  Uses c1's id, adds
    c2 OCNs and volume_ids to c1, resolves rights, deletes c2 entries from 
    tables. """
    
    #if VERBOSE:
    print "Merging '%i'->'%i'" % (cid2, cid1)
    lconn = get_connection()
    lcursor = lconn.cursor()
    
    # get volume_ids
    queryc1a = "SELECT volume_id FROM holdings_cluster_htitem_jn WHERE cluster_id = %s" % cid1
    queryc2a = "SELECT volume_id FROM holdings_cluster_htitem_jn WHERE cluster_id = %s" % cid2
    c1vids = run_list_query(lcursor, queryc1a)
    c2vids = run_list_query(lcursor, queryc2a)
    # insert c2 vol_ids into c1
    for vid in c2vids:
        if not (vid in c1vids):
            mcquery2 = """ INSERT INTO holdings_cluster_htitem_jn (cluster_id, volume_id)  
                           VALUES (%s, '%s') """ % (cid1, vid)
            try:
                if VERBOSE:
                    print mcquery2
                lcursor.execute(mcquery2)
                lconn.commit()
            except MySQLdb.Error, e:
                print "[merge_clusters 1] Error %d: %s" % (e.args[0], e.args[1])
                print "Exiting..."
                sys.exit(1)
    # insert c2 OCNs into c1
    c2ocns = Cluster_oclc_d[cid2]
    for ocn in c2ocns:
        Cluster_oclc_d[cid1].add(ocn)
        Oclc_cluster_d[ocn] = cid1
                
    # delete c2
    del Cluster_oclc_d[cid2]
    
    mcquery5a = "DELETE FROM holdings_cluster_htitem_jn WHERE cluster_id = %s" % cid2
    mcquery5c = "DELETE FROM holdings_cluster WHERE cluster_id = %s" % cid2
    try:
        lcursor.execute(mcquery5a)
        lcursor.execute(mcquery5c)
        lconn.commit()
    except MySQLdb.Error, e:
        print "[merge_clusters 3] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit(1)
        
    lconn.commit()
    lconn.close()    


def cluster_main():
    """ main routine to create PHDB clusters. Pass it the cursor. """
    
    conn = get_connection()
    cursor = conn.cursor()
    
    ### outer loop over all volume_ids ###
    print "Grabbing volume_ids..."
    query1 = "SELECT DISTINCT(volume_id) FROM holdings_htitem"
    all_vids = run_list_query(cursor, query1)
    print "%i ids received..." % len(all_vids)
    # remove previously run vids
    #vol_ids = remove_vids_from_list(all_vids)
    
    viter = 0
    for vid in all_vids:
        viter += 1
        if (len(vid)<3):
            print "skipping: '%s'" % vid
            continue
        
        # skip already-run volume_ids.
        #if vid in Volid_cluster_d:
        #    continue
        
        ## get the OCNs for each volume_id ##
        query3 = "SELECT oclc FROM holdings_htitem_oclc WHERE volume_id = '%s'" % vid
        ocns = run_list_query(cursor, query3)
        # skip htitems with no oclc number
        if (len(ocns) == 0):
            continue
        
        # are any OCNs already participating in other clusters? #
        pclusters = set([])
        for ocn in ocns:
            if (Oclc_cluster_d.has_key(ocn)):
                cid = Oclc_cluster_d[ocn]
                pclusters.add(cid)
        
        # if yes, aggregate
        if (len(pclusters)>0):
            # add current volume_id to lowest matching cluster number
            cids = list(pclusters)
            cids.sort()
            lcid = cids.pop(0)
            query4 =  """ INSERT INTO holdings_cluster_htitem_jn (cluster_id, volume_id)
                  VALUES (%s, '%s') """ % (lcid, vid)
            try:
                if VERBOSE:
                    print query4
                cursor.execute(query4)
            except MySQLdb.Error, e:
                print "[create_cluster] Error %d: %s" % (e.args[0], e.args[1])
                print "Exiting..."
                sys.exit()
            # add all OCNs to lowest matching cluster number
            for ocn in ocns:
                Oclc_cluster_d[ocn] = lcid
                Cluster_oclc_d[lcid].add(ocn)
            # merge remaining clusters into root cluster
            while (len(cids)>0):
                cid = int(cids.pop())
                # merge the cid with lcid
                merge_clusters(lcid, cid)
        else:
            # make new cluster
            #create_cluster(ocns, vid)
            create_cluster(cursor, ocns, vid)
            conn.commit()
            
        # export data struct every 100k
        if ((viter % 100000)==0):
            dump_data_structure(Cluster_oclc_d, "/afs/umich.edu/user/p/u/pulintz/Code/PHDB/cluster_oclc_d.out.tsv")
                   
    conn.commit()
    conn.close()         
    print "dumping final data structure"
    dump_data_structure(Cluster_oclc_d, "/afs/umich.edu/user/p/u/pulintz/Code/PHDB/cluster_oclc_d.finalout.tsv")
    

def remove_vids_from_list(vids):
    print "removing previously run volume_ids from run."
    for vid in vids:
        if (vid in Volid_cluster_d):
            vids.remove(vid)
    return vids


def dump_table(table, outfn):
    """ dumps a flatfile of the specified query.  Useful to get around the file permissions
    problems for the DB servers using SELECT INTO OUTFILE. """
    
    conn = get_connection()
    cursor = conn.cursor()
    
    outfile = file(outfn, "w")
    query = "select * from %s" % table
    try:
        cursor.execute(query)
    except MySQLdb.Error, e:
        print "[run_list_query] Error %d: %s" % (e.args[0], e.args[1])
        print "Exiting..."
        sys.exit(1)
    if (cursor.rowcount > 0):
        while(1):
            row = cursor.fetchone()
            if row == None:
                break
            outline = "%s,%s,%s\n" % (row[0], row[1], row[2])
            #print outline
            outfile.write(outline)
        
    conn.close()
    

def dump_data_structure(dstruct, outfn):
    """ Exports one of the table data structures to a flatfile.  Structs are
    hashes of lists (sets). """
    outfile = file(outfn, 'w')
    for k, v in dstruct.iteritems():
        for val in v:
            outline = "%s\t%s\n" % (k, val)
            outfile.write(outline)
    

def load_cluster_htitems_flatfile(filen):
    """ loads data from a flatfile into data structures """
    dfile = file(filen)
    for row in dfile:
        bits = row.split(',')
        clust_id = int(bits[0])
        vol_id = bits[1].strip()
        Volid_cluster_d[vol_id] = []
        Volid_cluster_d[vol_id].append(clust_id)
        if (clust_id in Cluster_volid_d):
            Cluster_volid_d[clust_id].append(vol_id)
        else:
            Cluster_volid_d[clust_id] = []
            Cluster_volid_d[clust_id].append(vol_id)

if __name__ == '__main__':
    #from sys import argv
    
    ## one-off: dumping the htitem_oclc table
    #dump_table("cluster", "/htapps/pulintz.babel/phdb/cluster.csv.20110602")
    #sys.exit()
    
    ### Main Clustering Routine ###
    
    ## load data structures ##
    Volid_cluster_d = {}
    Cluster_volid_d = {}
    
    Cluster_oclc_d = {}
    Oclc_cluster_d = {}
    
    # read cluster_htitem_jn from flatfile (for those already generated).
    #clhtfn = "/htapps/pulintz.babel/phdb/cluster_htitem_jn.csv"
    #load_cluster_htitems_flatfile(clhtfn)
    #print "done making data structures.\n"
            
    ## end load data structures ##
    
    # remember to set NOW variable at beginning of file 
    cluster_main()
    
    print "done."
