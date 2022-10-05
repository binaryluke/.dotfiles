# Find and Replace
# -a => absolute paths
# -t => type (f for 'file')
# . => search pattern (. for everything)
# -x => same as --exec
# -i => in-place edit ('' means don't output the backup file)
# -e => the command (ie regex to do the replacement)
echo "fd -a -t f . DIR_TO_FIND_IN -x sed -i '' -e \"s/FROM/TO/g\""

# Multiline Find and Replace
# Credit: https://www.xmodulo.com/search-and-replace-multi-line-string.html
# -i => in-place edit
# -0 => turns Perl into "file slurp" mode, where Perl reads the entire input file in one shot (intead of line by line)
# -pe => allows you to run Perl code (pattern matching and replacement in this case) and display output from the command line
echo "fd -a -t f . DIR_TO_FIND_IN -x perl -i -0pe \"s/FROM/TO/g\""

# Stats for Git Diff
echo "git diff --stat"

