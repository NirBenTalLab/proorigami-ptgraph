#!/bin/sh
#
# update_pdb.sh - update the local copy of the PDB (pdb format files only)
#
# Uses rsync.
# Refer to PDB documentation at  ftp://ftp.wwpdb.org/pub/pdb/README
#
# $Id: update_pdb.sh 3064 2009-12-18 03:15:57Z alexs $
#

PDBROOT=/local/munk/data/pdb/pdb

rsync --stats -a --port=33444 rsync.wwpdb.org::ftp_data/structures/divided/pdb/ ${PDBROOT}
