
# Use `pwd` to print the present working directory. That is, the directory
# you're currently in.
pwd

# Use `ls` to print a list of all files and directories in the present working
# directory.
ls

# Use `cd DIRECTORY` to change the working directory to a different directory.
# .. indicates the directory above the working directory.
cd /home/username
cd ..

# Use `man COMMAND` to look up help for COMMAND. This is similar to ? in R.
# You can exit from a manual by pressing q.
man ls

# Use `echo TEXT` to print TEXT. It is important to use single quotes ' around
# the TEXT.
echo 'Hello world!'

# Use `head FILE` and `tail FILE` to examine the beginning or end of file,
# much like the functions in R.
head myfile.txt
tail myfile.txt

# Use `more FILE` or `less FILE` to scroll through the contents of a file.
# Try both; you likely only have one or the other. You can exit by pressing q.
less myfile.txt
more myfile.txt

# Use `cat FILE1 FILE2 FILE3 ...` to concatenate files.
cat myfile1.txt myfile2.txt

# Use `wc -l FILE` to count the number of lines in a FILE. The wc command also
# has many other features. See man wc.
wc -l myfile.txt

# Use `uniq FILE` to get the unique lines in a FILE. The file must be sorted
# first for this to work correctly.
uniq myfile.txt

# Use `sort FILE` to sort a FILE.
sort myfile.txt

# Use `cut -dX -fN FILE` to extract column N from a FILE whose columns are 
# separated by X. For example, with a comma-separted (CSV) file,
cut -d, -f1-3 FILE

# Use `tr A B` to translate A into B.
echo 'a' | tr 'a' 'b'

# You can pipe the output of one command as input to another command using the
# pipe character |.
sort myfile | uniq

cat myfile1.txt myfile2.txt | uniq

# You can pipe the output of a command to a file using >.
wc -l myfile.txt > results.txt

# You can append the output of a command to a file using >>.
wc -l myotherfile.txt >> results.txt

