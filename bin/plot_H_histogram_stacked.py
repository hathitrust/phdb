#!/usr/bin/python
"""
Code to plot a dual histogram of the H-distribution data, ic and pd separate.
"""
 
import sys
import matplotlib.pyplot as plt
import numpy as np

MAX_H = 79

def plot_H_stack(id, title, hcounts_spm, hcounts_mpm, hcounts_ser):
    """ Takes a list of H-counts and plots them as a bar chart """
    fig_name = "%s-Hplot-stacked.png" % id
    print "making %s ..." % fig_name
    llen = len(hcounts_spm)
    xterms = range(1, llen+1)
    
    # font
    font1 = {'family' : 'stix',
             'weight' : 'bold',
             'size'   : 8}
    font2 = {'family' : 'normal',
             'weight' : 'normal',
             'size'   : 10}
    font3 = {'family' : 'normal',
             'weight' : 'bold',
             'size'   : 24}
    
    fig = plt.figure()
    bwidth = 0.75
        
    # set axes
    axis = [int(x) for x in range(1, len(hcounts_spm)+1)]
    xtics = [int(x) for x in range(0, len(hcounts_spm)+1, 5)]
    ptitle = "%s" % title
    #ax = fig.add_subplot(2,1,1)
    #bx = fig.add_subplot(2,1,1)
    #ax.set_title(ptitle, font3)
    plt.title(ptitle, font3)
    #ax.set_xlabel('H', font1)
    plt.xlabel('H', font3)
    #ax.set_ylabel('Cluster Count', font1)
    plt.ylabel('Count', font3)
    plt.xticks(xtics)
    # colors (green color='#006500', edgecolor='#004400')
    # colors (red color='r', edgecolor='#660000')
    # colors (orange color='#ff6314', edgecolor='#d64700')
    # colors (blue color = #0000ff', edgecolor='#000099')
    #plt.bar(axis, hcounts_l1, width=bwidth, align='center', color='#0000ff', edgecolor='#000099')
    plt.bar(axis, hcounts_spm, width=bwidth, align='center', color='#0000ee', edgecolor='#0000ee')
    plt.bar(axis, hcounts_mpm, width=bwidth, align='center', color='#eeaa00', edgecolor='#eeaa00', bottom=hcounts_spm)
    plt.bar(axis, hcounts_ser, width=bwidth, align='center', color='#004400', edgecolor='#004400', bottom=(hcounts_spm+hcounts_mpm))
    #plt.show()
    plt.savefig(fig_name)



def parse_Hfiles(spmfilen, mpmfilen, serfilen):
    """ Parses the 'h_distribution_report.py' outfile to plot all distributions.  Assumes
    there are individual files for singlepart monos, multipart monos, and serials. """
    
    spmfile = file(spmfilen)
    mpmfile = file(mpmfilen)
    serfile = file(serfilen)
    
    # parse mpm, ser datafiles, create hashes of each keyed on member_id
    mpm_map = {}
    for line in mpmfile.readlines():
        bits = line.split(',')
        member_id = bits[0]
        hcounts = bits[2:]
        data1 = [int(c) for c in hcounts]
        mpm_map[member_id] = data1
        
    ser_map = {}
    for line in serfile.readlines():
        bits = line.split(',')
        member_id = bits[0]
        hcounts = bits[2:]
        data1 = [int(c) for c in hcounts]
        ser_map[member_id] = data1
        
    # loop and stack    
    for line in spmfile.readlines():
        bits = line.split(',')
        member_id = bits[0]
        member_name = bits[1]
        hcounts = bits[2:]
        data_spm = [int(c) for c in hcounts]
        # this is inefficient, but whatever...
        data_mpm = mpm_map[member_id]
        data_ser = ser_map[member_id]
        
        np_spm = np.array(data_spm)
        np_mpm = np.array(data_mpm)
        np_ser = np.array(data_ser)
        plot_H_stack(member_id, member_name, np_spm, np_mpm, np_ser)
        #sys.exit()



if __name__ == '__main__':
    
    # demo data
    #h_list = [764, 4085, 7299, 10389, 14247, 19297, 18240, 16674, 18523, 20304]
    #plot_H("test", h_list)  
    spm = sys.argv[1]
    mpm = sys.argv[2]
    ser = sys.argv[3]
    
    parse_Hfiles(spm, mpm, ser)
    
    print "done."
