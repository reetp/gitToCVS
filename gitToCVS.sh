#!/bin/bash

# Clean out your contrib directory
# cvsupdate -dPA
# make clean
# make prep

# git pull your changes
# make sure in your spec file you have the new version number and Patch file name
# The script will look for something like
# Patch1: MynewPatch.patch
# And will create it

#Set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`

# -c Contrib Name
# -v Contrib Version
# -s SME version

CONTRIB=""
VERSION=""
SMEVERSION=""
GITDIR=""
CVSDIR=""
HOMEDIR=""

while getopts ":c:v:s:d:h" opt; do
  case $opt in
    c)
#      echo "-c was triggered, Parameter: $OPTIND - $OPTARG" >&2
      CONTRIB=$OPTARG
#      echo "$CONTRIB - $OPTARG"
      ;;
    v)
#      echo "-v was triggered, Parameter: $OPTIND - $OPTARG" >&2
      VERSION=$OPTARG
#      echo "$VERSION - $OPTARG"
      ;;
    s)
#      echo "-s was triggered, Parameter: $OPTIND - $OPTARG" >&2
      SMEVERSION=$OPTARG
#      echo "$SMEVER - $OPTARG"
      ;;
    d)
#      echo "-s was triggered, Parameter: $OPTIND - $OPTARG" >&2
      HOMEDIR=$OPTARG
#      echo "$HOMEDIR - $OPTARG"
      ;;
    h)  #show help
      echo -e "Example: $SCRIPT -c smeserver-contrib -v 0.5 -s 9"\\n
      exit 1
      ;;
      
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Note to self on variable numbers
# -c = $4
# -v = $6
# -s = $8
# -d =$10

# Set the git directory
GITDIR="$HOMEDIR/git/$CONTRIB"
#echo "gitdir = $GITDIR"

# Set the cvs directory
CVSDIR="$HOMEDIR/smecontribs/rpms/smeserver-libreswan/contribs$SMEVERSION"
#echo "cvsdir = $CVSDIR"

# Move the old CVS to .old
mv $CVSDIR/$CONTRIB-$VERSION $CVSDIR/$CONTRIB-$VERSION.old

# Copy the git directory over to CVS
cp -R $GITDIR/$CONTRIB $CVSDIR/$CONTRIB-$VERSION

# If we diff here we can catch the Patch name
diff -ruN $CVSDIR/smeserver-libreswan.spec $GITDIR/smeserver-libreswan.spec |grep Patch

# Get the patch name
DIFF=$(diff -ruN $CVSDIR/smeserver-libreswan.spec $GITDIR/smeserver-libreswan.spec | grep Patch | sed 's/.*: //')

# Now diff the old and new directories and create the patch file
cd $CVSDIR

diff -ruN ./$CONTRIB-$VERSION.old ./$CONTRIB-$VERSION > /$CVSDIR/$DIFF

echo "DIFF is $DIFF"

# Now copy the spec file
/bin/cp -rf $GITDIR/smeserver-libreswan.spec $CVSDIR/smeserver-libreswan.spec

echo "Before you run me again clean your CVS directory"