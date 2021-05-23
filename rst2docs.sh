#!/bin/bash

DOCUTILS_PATH=/usr/bin

${DOCUTILS_PATH}/rst2html <$1.rst >$1.html
${DOCUTILS_PATH}/rst2latex <$1.rst >$1.tex
pdflatex --shell-escape $1.tex
rm -rf $1.aux $1.log $1.out $1.tex
