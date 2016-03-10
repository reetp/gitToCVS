# gitToCVS
Script to copy git code to CVS

Usage

For help

gitToCVS.sh -h

-c Contrib name
-v Contrib version
-s SME version
-d Home directory

Assumptions

Your git directory is in : /home/yourname/git/smeserver-contrib
Your CVS directory is in : /home/yourname/smecontribs/rpms/smeserver-contrib/contribs{smeversion}

gitToCVS.sh -c smeserver-contrib -v 0.5 -s 9 -d /home/joe

