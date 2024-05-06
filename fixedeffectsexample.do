clear all

cd "/Users/fulyaersoy/Dropbox/Uchicago/Education/Discussion Sections/"

import delimited "fixedeffects.csv", clear //Note: this is a madeup dataset. In your problem set, you will be using data from an actual school district.

log using "fixedeffectsexample.smcl", replace

//Method 1:

tab student, gen(Dstudent)
tab teacher, gen(Dteacher)
tab year, gen(Dyear)
reg testscore Dstudent* Dteacher* Dyear*, hascon


//Method 2:
xtset teacher

xtreg testscore lagtestscore Dyear*, fe //Note: you need to create year dummies before running this regression if they weren't created before 
predict testscorePredicted, u

egen teacherUnique=tag(teacher) 
su testscorePredicted if teacherUnique==1, detail

log close
