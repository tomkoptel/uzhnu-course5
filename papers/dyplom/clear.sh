#!/bin/bash
# Clear
find -E $TEX/ -maxdepth 1 -type f ! -regex ".*\.(tex|log|blg|bib|cls|sty|bst|clo|asm|gitignore)" -exec rm -f {} \; ;
