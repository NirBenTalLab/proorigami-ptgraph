#!/bin/sh
#
# mkoutindex.sh - build index.html file for output files from renderall.sh
#
# Build an index.html file for the PNG and SVG output files from 
# renderall.sh
#
# Usage: mkoutindex.sh [outdir]
#
# Run this script from where the output directory is under.
# (ie same as runall_ptg.sh) If outdir is not specified, ./output
# is used.
#
# Creates or overwrites index.html in the outdir.
#
# $Id: mkoutindex.sh 2010 2008-10-29 23:53:10Z astivala $
#

myname=`basename $0`
mydir=$PWD

# input/output directory (output of ptgrunall.sh)
PTGROOT=${mydir}/output

if [ $# -eq 1 ]; then
    outdir=${mydir}/$1
else
    outdir=${PTGROOT}
fi

cd ${outdir}

htmlfile=index.html

echo "<!-- Generated by $0 $* on `date` -->" > ${htmlfile}
echo "<p>build date `date`" >> ${htmlfile}
echo "<table>" >> ${htmlfile}
for svgfile in *.svg
do
    echo -n "  <tr>" >> ${htmlfile}
    echo -n "<td><a href=\"${svgfile}\">${svgfile}</a>" >> ${htmlfile}
    pdbid=`basename ${svgfile} .svg`
    pngfile=${pdbid}.png
    echo " <td><a href=\"${pngfile}\">${pngfile}</a>" >> ${htmlfile}
    echo "<td><a target=\"_blank\" href=\"http://www.pdb.org/pdb/explore.do?structureId=${pdbid}\">PDB structure summary page for ${pdbid}</a>" >> ${htmlfile}
    echo "</tr>" >> ${htmlfile}
done
echo "</table>" >> ${htmlfile}

