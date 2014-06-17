import os
import SDB
import commands
from datetime import datetime
import time
import pickle

lab_name = 'Lab6'
#time_tuple = (2008, 11, 12, 13, 51, 18, 2, 317, 0)
date_str = "2012-09-14 23:59:59"
dt = datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")

due_datetime = (2012, 9, 14, 23, 59, 59, 999999, None)


dirs = filter(os.path.isdir, os.listdir('.'))
#dt = datetime.datetime(*due_datetime[0, 7])

idiot_list = []
procrasnator_list = []
drop = []

for dir in dirs:
    tup = dir.partition('_')
    if tup[0] == "utexas":
        wrong = False
        paths = (dir+'/'+lab_name, dir+'/'+lab_name+'/src')
        files = (paths[1]+'/SudokuClient.java', paths[1]+'/SudokuServer.java', paths[1]+'/SudokuSolver.java')
        if not (tup[2] in SDB.all_EID()):
            drop.append(tup[2])
        for path in paths:
            if not os.path.exists(path):
                print tup[2] + " has no path " + path
                #print "instead, it has: "
                wrong = True
                break
        if not wrong:
            for file in files:
                if not os.path.exists(file):
                    stat = commands.getstatus("svn rename " + paths[1] + "/SudokuTest.java " + paths[1] + "/TestSudoku.java")
                    if stat[0]==0:
                        commands.getstatus("svn ci " + paths[1] + " -m 'fixed test file naming'")
                    print tup[2] + " has no file " + os.path.basename(file)
                    wrong = True
        if wrong:
            idiot_list.append(tup[2])
if drop:
    print "Dropped:"
    print drop
print "Idiots of this week are: "
print idiot_list
pickle.dump(idiot_list, open("Lab3_failed_update.pickle", "wb"))
print "Email them: "
print SDB.lookupEmail(idiot_list, True)
