#EE422C Grading Script
#Author: Ang Li
#Fall 2012

import commands
import sys
import pickle
import re
import SDB

lab_name = "Lab10"

#lab_info contains (due_date, test_name)
#due date means all files should be committed before this day
#e.g. for projects due on 9-14 23:59:59, due_date should be 9-15
lab_info = {
"Lab1":("2012-09-07", "HelloWorldTest"),
"Lab2":("2012-09-19", "TestPostfix"),
"Lab3":("2012-09-21", "TestJavaConstructs"),
"Lab4":("2012-09-28", "TestPairingConstraints"),
"Lab5":("2012-10-05", "TestSudoku"),
"Lab6":("2012-10-20", "TestLogProcessor"),
"Lab7":("2012-10-26", "TestRecDC"),
"Lab8":("2012-11-02", "TestTaskTicTac"),
"Lab9":("2012-11-09", "TestMicroBlogger"),
"Lab10":("2012-11-21", "TestMicroBlogger"),
"Lab11":("2012-12-21", "None")
}

due_date = lab_info[lab_name][0]
test_name = lab_info[lab_name][1]
eid_list = SDB.all_EID()
score_dict = {}
url_dict = {}

def load_list(fName):
    try:
        f = open(fName, "rb")
        input_list = pickle.load(f)
        if input_list:
            return input_list
        else: return []
    except IOError:
        print "Failed to open "+fName
        return 0

#Find the score in JUnit log and record in score_dict
#JUnit is expected to print a message in this format:
#@score,Name,EID,<actual score>
def grep_score(log):
    word_list = re.split('@|,|\n', log)
    for i in xrange(len(word_list)):
        if word_list[i] == "score":
            score = 0
            try:
                score = int(word_list[i+3])
            except:
                print "Wrong score msg format in log:"
                print log
            score_dict[word_list[i+2].lower()] = score
            print score_dict[word_list[i+2].lower()]

#Find the score in JUnit log and return it
def grep_score2(log):
    word_list = re.split('@|,|\n', log)
    for i in xrange(len(word_list)):
        if word_list[i] == "score":
            score = 0
            try:
                score = int(word_list[i+3])
                return score
            except:
                print "Wrong score msg format in log:"
                print log
    

#Generate csv file for Blackboard
#Assumes the format of each line is:
#   "Last Name","First Name","EID","Score"
def output_score():
    #print score_dict
    print "Writing scores to "+lab_name+"_scores.csv"
    of = open(lab_name+"_scores.csv",'wb')
    for line in open("a.csv",'r'):
        words = line.replace('\"', '').split(',')
        #print words
        if words[1]=="First Name":
            of.write(line)
            continue
        if score_dict.has_key(words[2].lower()):
            words[3] = str(score_dict[words[2]])
        else:
            words[3] = '0'
        #print words[0]+','+words[1]+','+words[2].lower()+','+words[3]+'\n'
        of.write(words[0]+','+words[1]+','+words[2].lower()+','+words[3]+'\n')
    of.close()

#Detect and handle failure when running a submission
def exe_error_handle_run(verb, exeResult, eid, input_list, error_list):
    print exeResult[1]
    grep_score(exeResult[1])
    if(exeResult[0] != 0):
        print eid + " failed"
        
        error_list.append(eid)
        with open(lab_name+"_exe_error.log", "a") as f:
            f.write("Failed tests for " + eid + "\n" + exeResult[1])
            f.write("###################################\n\n")

#Detect and handle failure for general operations 
def exe_error_handle_normal(verb, exeResult, eid, input_list, error_list):
    if(exeResult[0] != 0):
        print "###################################"
        print "Failed to " + verb + " " + eid
        print exeResult[1]
        error_list.append(eid)

#Core execution routine
#verb: operation name
#cms: the command to be executed in command line
#single: whether running a single or batch operations
#input_list: list of EIDs to be processed
#retry: only run those failed in last time or all
#fail_dat_name: name of the file that stores the failed cases
#exe_error_handle: specifies the error handle routine to use
def execute(verb, cmds, single, input_list, retry, fail_dat_name, exe_error_handle):
    work_list = input_list
    error_list = []
    if retry:
        work_list = load_list(fail_dat_name)
    if not input_list:
        print "Empty input list"
        exit()
#print work_list
    for eid in work_list:
        print verb + " " + eid;
        for cmd in cmds:
            exeResult = commands.getstatusoutput(cmd.format(eid=eid))
            exe_error_handle(verb, exeResult, eid, input_list, error_list)
    if error_list and not single:
        pickle.dump(error_list, open(fail_dat_name, "wb"))
    else:
        print "All clear!"
        return 0

#Check out all the repos. If retry is True, only check out the previously failed ones
def checkout(retry, single=(False, [])):
    cmds = ["svn co -r {{" + due_date + "}} https://subversion.assembla.com/svn/utexas_{eid}"]
    execute("check out", cmds, single[0], single[1] if single[0] else eid_list, retry, lab_name+"_failed_checkout.pickle", exe_error_handle_normal)

#Update all the repos. If retry is True, only update the previously failed ones
def update(retry, single=(False, [])):
    execute("update", ["svn up -r {{" + due_date + "}} utexas_{eid}/" + lab_name + "/ "], single[0], single[1] if single[0] else eid_list, retry, lab_name+"_failed_update.pickle", exe_error_handle_normal)

#Push file named fName into each source directory (utexas_EID/<lab_name>/src)
def push(fName, single=(False, [])):    #"mkdir -p ./utexas_{eid}/Lab6/src/ee422C"
    cmds = [ "cp " + fName + " utexas_{eid}/" + lab_name + "/src/"]
    print cmds
    execute("push script", cmds, single[0], eid_list, False, lab_name+"_failed_run.pickle", exe_error_handle_normal)

#Compile all the .java files for <lab_name>. If retry is True, only compile the previously failed ones
def compile(retry, single=(False, [])):
    cmds = ["javac -Xlint -cp junit.jar:guava-13.0.1.jar:gson-2.2.2.jar:utexas_{eid}/" + lab_name + "/src/ utexas_{eid}/" + lab_name + "/src/*.java"]
    execute("compile", cmds, single[0], single[1] if single[0] else eid_list, retry, lab_name+"_failed_compile.pickle", exe_error_handle_normal)

#Run all the projects of <lab_name>. If retry is True, only run the previously failed ones
def run(retry, single=(False, [])):
    #Clear error log
    if not single[0]:
        with open(lab_name+"_exe_error.log", 'w'):
            pass
    cmds = ["java -cp junit.jar:guava-13.0.1.jar:gson-2.2.2.jar:utexas_{eid}/" + lab_name + "/src/:. org.junit.runner.JUnitCore " + test_name ]
    execute("run", cmds, single[0], single[1] if single[0] else eid_list, retry, lab_name+"_failed_run.pickle", exe_error_handle_run)
    if not single[0] and not retry:
            output_score()

def run_blogger(retry, single=(False, [])):
    #Clear error log
    if not single[0]:
        with open(lab_name+"_exe_error.log", 'w'):
            pass
    cmds = [ "javac -Xlint -cp junit.jar:guava-13.0.1.jar:gson-2.2.2.jar:url/:. ./url/*.java" ]
    commands.getstatus(cmds[0])
    for line in open("urls.txt",'r'):
        words = line.split(' ')
        score_dict[words[0]] = 0
        cmd = "java -Durl="+words[1].strip()+" -cp junit.jar:guava-13.0.1.jar:gson-2.2.2.jar:url/:. org.junit.runner.JUnitCore " + test_name
        print "running " + words[0]
        exeResult = commands.getstatusoutput(cmd)
        score_dict[words[0]] = grep_score2(exeResult[1])
        print exeResult[1]
    if not single[0] and not retry:
        output_score()


opDict = {'co':checkout, 'up':update, 'push':push, 'cmpl':compile, 'run':run, 'runb':run_blogger }

#This is where the program starts to run
if len(sys.argv)>1:
    retry = False
    if len(sys.argv)==3:
        if sys.argv[2] == 'r':
            retry = True
        elif sys.argv[2] in eid_list:
            opDict[sys.argv[1]](False, (True, [sys.argv[2]]))
            exit()
        elif SDB.lookupEID(sys.argv[2], True) in eid_list:
            opDict[sys.argv[1]](False, (True, [SDB.lookupEID(sys.argv[2], True)]))
            exit()
        else:
            opDict[sys.argv[1]](sys.argv[2])
            exit()
    opDict[sys.argv[1]](retry)

