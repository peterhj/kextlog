#!/usr/bin/python

from datetime import *
import csv
import sys
import time

log_file = open(sys.argv[1], 'rb')
log_iter = csv.reader(log_file, delimiter=':')

now = datetime.now()
now = datetime.strptime(''.join([str(now.year), ' ',
                                 str(now.month), ' ',
                                 str(now.day), ' ',
                                 str(now.hour), ':',
                                 str(now.minute), ':',
                                 str(now.second), ' GMT']),
                                 '%Y %m %d %H:%M:%S %Z').strftime('%s')

#now = time.localtime()

f = '%Y %b %d %H:%M:%S %Z'

for i, row in enumerate(log_iter):
    row[2] = row[2][:2]
    s = ''.join(['2012 ', row[0], ':', row[1], ':', row[2], ' GMT'])
    t = datetime.strptime(s, f)
    #t = time.strptime(s, f)
    n = t.strftime('%s')
    if (n > now):
        s = ''.join(['2011 ', row[0], ':', row[1], ':', row[2], ' GMT'])
        t = datetime.strptime(s, f)
        #t = time.strptime(s, f)
        n = time.strftime('%s')
    #print(s)
    print(n)
