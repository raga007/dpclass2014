try:
    with open('student_data.txt') as f:
        content = f.readlines()
except IOError:
    print "Failed to open student database file"
finally:
    f.close()

nameDict = {}
eidDict = {}
emailDict = {}

#Assuming each line of student_data is the following format:
#       EID First Name
for str in content:
    ls = str.split()
    nameDict[ls[1]+' '+ls[2]] = (ls[0], ls[3])
    eidDict[ls[0]] = (ls[1]+' '+ls[2], ls[3])
    emailDict[ls[3]] = (ls[1]+' '+ls[2], ls[0])

def all_EID():
    return tuple([tup[0] for tup in nameDict.values()])

def all_Name():
    return tuple([tup[0] for tup in eidDict.values()])

def all_Email():
    return tuple([tup[1] for tup in nameDict.values()])

def lookupOne(args, hashes, indexes):
    for hash, index in zip(hashes, indexes):
        if hash.has_key(args):
            return hash[args][index]
    print "Could not find " + args
    return 0

def printResults(results):
    for res in xrange(len(results)-1):
        print results[res] + ", "
    if len(results) >= 1:
        print results[len(results)-1]

def lookup(args, hashes, indexes, quiet):
    if isinstance(args, list):
        results = []
        for key in args:
            res = lookupOne(key, hashes, indexes)
            if res != 0:
                results.append(res)
        if not quiet: printResults(results)
        return results
    else:
        re = lookupOne(args, hashes, indexes)
        if not quiet: print re
        return re

def lookupEmail(args, quiet=False):
    return lookup(args, [nameDict, eidDict], [1, 1], quiet)

def lookupEID(args, quiet=False):
    return lookup(args, [nameDict, emailDict], [0, 1], quiet)

def lookupName(args, quiet=False):
    return lookup(args, [eidDict, emailDict], [0, 0], quiet)