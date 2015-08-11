#!/bin/sh
#
# svg2eps.sh - render SVG file to encapsulated PostScript using inkscape
#
# Usage: svg2pdf.sh name.svg [inkscape-opts]
#
#    SVG file name.svg will be converted to PDF file name.pdf in cwd
#
# Note that this requires rsh to mungerabah since for some reason 
# tech services can/will only install inkscape on that particular machine
# (from which the filesystems I am using on this one (charikar) are not
# available). So we have to rcp the input to mungerabah,
# rsh to run it on mungerabah and rcp the output back here.
#
# This requiers appropriate entries in .rhosts on mungerabah for the
# machine this is run from to allow rsh with no passwd.
#
# $Id: svg2pdf.sh 1324 2008-05-21 04:33:43Z astivala $
#

# host to run inkscape on, if not available on localhost
INKSCAPE_HOST=mungerabah.cs.mu.oz.au

# directory on INKSCAPE_HOST to put input and output files in
INKSCAPE_TMPDIR=/var/tmp

if [ $# -lt 1 ]; then
    echo "Usage: $0 name.svg [inkscape-opts]" >&2
    exit 1
fi

svgfile=$1
shift
inkscape_opts=$*
name=`basename ${svgfile} .svg`
type inkscape >/dev/null 2>&1
if [ $? -eq 0 ]; then
  inkscape -z -b none ${inkscape_opts} -A ${name}.pdf ${svgfile}
else
  rcp ${svgfile} ${INKSCAPE_HOST}:${INKSCAPE_TMPDIR}
  rsh ${INKSCAPE_HOST} inkscape -z -b none ${inkscape_opts} -A ${INKSCAPE_TMPDIR}/${name}.pdf ${INKSCAPE_TMPDIR}/${name}.svg
  rcp ${INKSCAPE_HOST}:${INKSCAPE_TMPDIR}/${name}.pdf .
  rsh ${INKSCAPE_HOST} rm ${INKSCAPE_TMPDIR}/${name}.svg ${INKSCAPE_TMPDIR}/${name}.pdf
fi
