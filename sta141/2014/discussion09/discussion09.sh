
# Most Important
# ==============
# Use `man COMMAND` to look up help for COMMAND.
# This is similar to ? in R. Scroll through
# manuals with the arrow keys (or hjkl) and quit
# with q.
man ls

# Use `help KEYWORD` to look up help for KEYWORD.
help if

# Most of the time, `man` is the help you need!

# Browsing Files
# ==============
# The shell is a file browser.

# Use `pwd` to print the present working
# directory. 
pwd

# Use `ls` to print a list of all files and
# directories in the working directory.
ls

# Use `cd DIRECTORY` to change the working
# directory to a different directory.
# Shortcuts:
#   .   current directory
#   ..  parent directory
cd /home/username
cd ..

# Use `mv SOURCE DEST` to move a file.
mv foo.txt bar.txt

# Use `cp SOURCE DEST` to copy a file.
cp bar.txt baz.txt

# Use `rm FILE` to delete FILE. You can specify
# more than one file.
rm bar.txt baz.txt

# BE CAREFUL: there's no "trash can" or undo.

# Scripting
# =========
# The shell is a scripting language (like R).

# Use `echo TEXT` to print TEXT.
echo Hello world!

echo dog|cat

# Use single quotes for literal strings.
# Generally, this is what you want.
echo 'dog|cat'
echo 'This is $USER.'

# Use double quotes for slightly magic strings.
echo "dog|cat"
echo "This is $USER."

# Use `cat FILE` to print the contents of FILE. 
echo hello.txt
cat hello.txt

# You can also use cat to concatenate files.
cat hello.txt hello2.txt

# Use `head FILE` and `tail FILE` to examine the
# beginning or end of a file, much like the
# functions in R.
head letters.txt
tail letters.txt

# Pipes
# =====
# Think of data in the shell as water flowing
# through a pipe. You can easily redirect, or
# pipe, the output from one place to another.
# Commands:
#   |       pipe to next command
#   >       pipe to file (overwrite)
#   >>      pipe to file (append)

# Use `tr A B` to translate A into B.
echo Hello world! | tr H C

echo Hello world! | tr H J > foo.txt

echo Hello world! > foo.txt

echo Hello world! | tr H M >> foo.txt

# Use `tee FILE` to send output to a file and
# pass it on as well. Think of this as a T-shaped
# pipe--it sends output to 2 places.
echo Hello world! | tee foo.txt | tr H C

echo Hello world! | tee foo.txt bar.txt | tr H C

# Examining Files
# ===============
# Use `more FILE` or `less FILE` to scroll 
# through the contents of a file. Try both; you
# likely only have one or the other. You can exit
# by pressing q.
less Discussion9.sh
more Discussion9.sh

# Other Commands
# ==============
# Use `wc -l FILE` to count the number of lines
# in a FILE. The wc command can also count other
# things. See man wc.
wc -l letters.txt

# Use `sort FILE` to sort a FILE.
sort letters.txt

# Use `uniq FILE` to get the unique lines in a
# FILE. The file must be sorted first for this to
# work correctly.
sort letters.txt | uniq
sort letters.txt | uniq -c

# Use `cut -dX -fN FILE` to extract column N from
# a FILE whose columns are separated by X.
# For example, with a comma-separted (CSV) file,
cut -d, -f1-3 FILE

# Downloading Files
# =================
# To download a file from the shell, use either
# `wget URL` or `curl -O URL`. If one of these
# doesn't work, use the other; you might not have
# both commands installed.
wget http://www.uq.edu.au/pitchdrop-test/images/latest.jpg

curl -O http://www.uq.edu.au/pitchdrop-test/images/latest.jpg

# Archives
# ========
# Use `tar -cf ARCHIVE FILES` to create a .tar
# archive; add z to the arguments to make a
# .tar.gz archive. The -c is for "create".
tar -czf foo.tar.gz latest.jpg

# Use `tar -xf ARCHIVE` to extract a .tar
# archive; add z to extract a .tar.gz archive.
# The -x is for "extract".
tar -xzf foo.tar.gz

