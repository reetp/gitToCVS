#!/bin/sh


# -c Contrib Name
# -v Contrib Version
# -s SME version


while getopts ":cvs:" opt; do
  case $opt in
    a)
      echo "-c was triggered, Parameter: $OPTARG" >&2
      ;;
    v)
      echo "-c was triggered, Parameter: $OPTARG" >&2
      ;;
    s)
      echo "-c was triggered, Parameter: $OPTARG" >&2
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


# cd ~/git/smeserver-libreswan


# cd ~/smecontribs/rpms/smeserver-libreswan


# cd contribs9

# mv smeserver-libreswan-0.5 smeserver-libreswan-0.5.old

# cp -R ~/git/smeserver-libreswan/smeserver-libreswan ~/smecontribs/rpms/smeserver-libreswan/contribs9/smeserver-libreswan-0.5

# cp ~/git/smeserver-libreswan/smeserver-libreswan.spec ~/smecontribs/rpms/smeserver-libreswan/contribs9/smeserver-libreswan.spec

# diff -ruN smeserver-libreswan-0.5.old smeserver-libreswan-0.5 > smeserver-libreswan-fix-masq-templates.patch
