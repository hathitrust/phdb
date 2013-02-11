#!/usr/bin/env python

"""
Module for retrieving an HT "metadata" files from the HT website.  
Usage:  python grab_hathi_file.py hathi_upd_20100901.txt.gz
"""

import urllib
import urllib2
import re, os, glob, sys
import gzip

def get_HT_filenames(url):
    """ Returns the full urls of all datafiles on the given page. """
    # grab the page
    response = urllib2.urlopen(url)
    final_hits = []
    
    # pull out the terms that match a url in the page
    html = response.read()
    hits = re.findall("\"http:.+\.txt\.gz\"", html)
    hits = [re.sub("\"", "", hit) for hit in hits]
    
    return hits


def retrieve_HT_file(urls, targetfile, dir, month=''):
    """ Retrieves the file into the current directory.
    If 'month' parameter is specified, it will pull all the files for that month.
    Month must be a two character string, e.g. '04' for April. """
    date_re = re.compile("_(\d+)\.")
    for url in urls:
        # construct local path
        bits = url.split("/")
        filen = bits[-1]
        local_filen = "%s/%s" % (dir, filen)
        # check month
        if (month):
            date_search = date_re.search(filen)
            date = date_search.group(1)
            file_month = date[4:6]
            if (file_month != month):
                continue
            # retrieve
            print "Grabbing %s" % filen
            urllib.urlretrieve(url,filename=local_filen)
            continue
        if (filen == targetfile):
            # retrieve
            print "Grabbing %s" % filen
            urllib.urlretrieve(url,filename=local_filen)
            

def unzip_all_files(dir):
    for infile in glob.glob(os.path.join(dir, '*.gz')):
        print "Unzipping %s..." % infile
        fileObj = gzip.GzipFile(infile, 'rb');
        fileContent = fileObj.readlines();
        fileObj.close()

        fileObjOut = file(infile.replace('.gz',''), 'wb');
        fileObjOut.writelines(fileContent)
        fileObjOut.close()
        

if __name__ == "__main__":
    
    filename = sys.argv[1]
    
    cwd = os.getcwd()

    root_url = "http://www.hathitrust.org/hathifiles"
    #local_dir = "/home/pete/Documents/Data/HathiTrust/MetadataFiles"
    print "grabbing %s from %s" % (filename, root_url)
    
    # grab filenames
    files = get_HT_filenames(root_url)
    retrieve_HT_file(files, filename, cwd)
    
    # for each gz filename
    unzip_all_files(cwd)
    print "done."#!/usr/bin/env python

