#!/bin/sh
#
# buildversion.sh - build a python file with svn version number 
#
# Usage: buildversion.sh > ptversion.py
# (output is a Python module to stdout)
#
# File: buildversion.sh
# Author: Alex Stivala
# Created: February 2008
#
# $Id: buildversion.sh 1121 2008-02-21 03:43:52Z astivala $
#

VERSION=`svnversion -n .`
DATE=`date`

cat <<EOF
# autogenerated by $0
# $DATE
def get_version():
    """
    Return version string containing global version number and 'build' date
    """
    return "Revision ${VERSION}, ${DATE}"
EOF
