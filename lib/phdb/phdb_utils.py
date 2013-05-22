#!/usr/bin/python
"""
Useful general items for use with the PHDB database.
"""


rights_map = {
    'pd': 1,
    'ic': 2,
    'opb': 3,
    'orph': 4,
    'und': 5,
    'umall': 6,
    'world': 7,
    'nobody': 8,
    'pdus': 9,
    'cc-by': 10,
    'cc-by-nd': 11,
    'cc-by-nc-nd': 12,
    'cc-by-nc': 13,
    'cc-by-nc-sa': 14,
    'cc-by-sa': 15
}

def reduce_rights_list(rlist):
    """ Given a list of rights > 2, reduce down to 2 or 1 """
    if ('und' in rlist):
        rlist.remove('und')
        if (len(rlist) <= 2):
            return rlist
    if ('world' in rlist):
        return ['world']
    if (('pd' in rlist) and ('ic' in rlist)):
        rlist.remove('ic')
        if (len(rlist) <= 2):
            return rlist
    if (('pd' in rlist) and ('pdus' in rlist)):
        rlist.remove('pdus')
        if (len(rlist) <= 2):
            return rlist
    if (('ic' in rlist) and ('pdus' in rlist)):
        rlist.remove('ic')
        if (len(rlist) <= 2):
            return rlist
    print "problem with rlist: %s" % rlist
    return rlist
        

  
def resolve_rights_id(i, j):
    """ Given two rights integers, resolve the rights designation for the purposes
    of PHDB V.2 (April 2011).  The intent here is to only have one rights 
    designation for any OCLC number.  Returns the prevailing rights id. """
    
    if (not (type(i) is int) or not (type(i) is int)):
        print "Non-Integer in rights resolution: %s, %s" % (i, j)
        return 0
    
    nums = [i, j]
    nums.sort()
      
    t1 = nums[0]
    t2 = nums[1]
    # if theres a pd, use it
    if ((t1 == 1) or (t2 == 1)):
        return 1
    if (t1 == 2):
        if (t2 < 6):
            return 2
        else:
            return t2
    if (t1 < 6):
        return t2
    if ((t1 == 7) or (t2 == 7)):
        return 7
    return t2