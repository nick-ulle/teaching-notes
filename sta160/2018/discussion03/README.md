# Discussion 3: More About Git

## References

For the Unix shell:
* [Unix Shell Notes][shell-lesson] (from Software Carpentry). See lessons 1, 2.
* [Explain Any Shell Command][explain-shell]

For Git:
* [Git Website][git]. Go here to download git.
* [Git Notes][git-lesson] (from Software Carpentry). See lessons 1-9, 14.
* [Git Cheatsheet][git-cheatsheet]
* [Git Interactive Tutorial][try-git]

[git]: https://git-scm.com/
[shell-lesson]: http://swcarpentry.github.io/shell-novice/
[git-lesson]: http://swcarpentry.github.io/git-novice/
[git-cheatsheet]: https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf
[try-git]: https://try.github.io/
[explain-shell]: https://explainshell.com/

## Topics From Last Week

### Getting Around the Shell

* Check working directory with `pwd`

* List files in directory with `ls`

* Change directory with `cd`

* Special paths:
    + `.` the current working directory
    + `-` the previous working directory
    + `..` the directory above
    + `~` the home directory

* Keyboard shortcuts:
    + `Tab` to automatically complete a path or command
    + `Up` to get the previous command
    + `Ctrl-r` to search backward in command history

### Git Setup

How to configure git for the very first time with `git config --global`

How to create a repository with `git init NAME`

### Saving Work

How to:

* Check a repo's status with `git status`

* Review changes with `git diff`

* Stage changes with `git add`

* Commit changes with `git commit`

* Check the history of changes with `git log`

### Distributing Work

* Manage remotes with `git remote`

* Upload commits with `git push`


## Collaboration & Reproducibility

Tips for collaborative and reproducible work:

* Use paths relative to the current directory (NEVER absolute paths).
* DO NOT commit large (> 10 MB) files.
* Write meaningful commit messages.
* Use meaningful file names (not `a.txt`, `b.txt`).
* Put a comment at the beginning of each script or notebook that briefly
  explains what's inside.
* Make small commits each time you get to a checkpoint in your work, rather
  than one large commit at the end of the day.
* Workflow: write out what you're going to do (in a text or Markdown file), do
  it, then write out what did/didn't work and what's next.
