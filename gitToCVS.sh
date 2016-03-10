#!/bin/bash

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

while getopts ":c:v:s:h" opt; do
  case $opt in
    c)
      echo "-c was triggered, Parameter: $OPTIND - $OPTARG" >&2
      CONTRIB=$OPTARG
      echo "$CONTRIB - $OPTARG"
      ;;
    v)
      echo "-v was triggered, Parameter: $OPTIND - $OPTARG" >&2
      VERSION=$OPTARG
      echo "$VERSION - $OPTARG"
      ;;
    s)
      echo "-s was triggered, Parameter: $OPTIND - $OPTARG" >&2
      SMEVERSION=$OPTARG
      echo "$SMEVER - $OPTARG"
      ;;
      
    h)  #show help
      echo -e "Example: $SCRIPT -c contribname -v contribversion -s smeversion"\\n
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

# -c = $4
# -v = $6
# -s = $8

# cd ~/git/smeserver-libreswan

#
echo "cd ~/smecontribs/rpms/$CONTRIB/$CONTRIB-$VERSION"
HOMEDIR="/home/john"

GITDIR="$HOMEDIR/git/$CONTRIB"
echo "gitdir = $GITDIR"

CVSDIR="$HOMEDIR/smecontribs/rpms/smeserver-libreswan/contribs$SMEVERSION"
echo "cvsdir = $CVSDIR"

#echo "cd ~/smecontribs/rpms/smeserver-libreswan/contribs$SMEVERSION"

# Move the old CVS to .old
mv $CVSDIR/$CONTRIB-$VERSION $CVSDIR/$CONTRIB-$VERSION.old

# Copy the git directory over to CVS
cp -R $GITDIR/$CONTRIB $CVSDIR/$CONTRIB-$VERSION

# If we diff here we can catch the Patch name
diff -ruN $CVSDIR/smeserver-libreswan.spec $GITDIR/smeserver-libreswan.spec |grep Patch

# Get the patch name
DIFF=$(diff -ruN $CVSDIR/smeserver-libreswan.spec $GITDIR/smeserver-libreswan.spec | grep Patch | sed 's/.*: //')

# Now diff the old and new directories and create the patch file
diff -ruN $CVSDIR/$CONTRIB-$VERSION.old $CVSDIR/$CONTRIB-$VERSION > /$CVSDIR/$DIFF

echo "DIFF is $DIFF"

# Now copy the spec file
/bin/cp -rf $GITDIR/smeserver-libreswan.spec $CVSDIR/smeserver-libreswan.spec

