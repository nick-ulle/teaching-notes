#!/usr/bin/env python2
"""Assignment Notebook Tool

This script can strip solution cells or insert grading cells in Jupyter
notebooks.
"""

import argparse
import nbformat as nb
import os.path


# Configuration Variables
SOLN_SUFFIX = '-solutions.ipynb'
SOLN_HEADER = '#### SOLUTION' # header for solution cells

EXER_HEADER = '__Exercise' # header for exercise cells
GRADE_HEADER = '<strong style="color:#F00">\nGrade: \n</strong>'
GRADE_CELL = nb.NotebookNode(
    cell_type = 'markdown',
    metadata = {},
    source = GRADE_HEADER
)


def nb_strip(path):
    if not path.endswith(SOLN_SUFFIX):
        msg = "Error: input path '{}' doesn't end with '{}'."
        print(msg.format(path, SOLN_SUFFIX))
        return

    out_path = path[:-len(SOLN_SUFFIX)] + '.ipynb'
    if os.path.exists(out_path):
        print("Error: output path '{}' already exists.".format(out_path))
        return 

    # Strip solution cells.
    notebook = nb.read(path, nb.NO_CONVERT)
    notebook['cells'] = [
        cell for cell in notebook['cells']
        if not cell['source'].startswith(SOLN_HEADER)
    ]

    # Write the stripped notebook to a file.
    nb.write(notebook, out_path)
    print("Wrote '{}'.".format(out_path))


def nb_grade(path):
    if os.path.isdir(path):
        paths = [
            os.path.join(path, x) for x in os.listdir(path)
            if x.endswith('.ipynb')
        ]
    elif os.path.exists(path):
        paths = [path]
    else:
        print("Error: input path '{}' doesn't exist.".format(path))

    for path in paths:
        print("Converting '{}'...".format(path))
        notebook = nb.read(path, nb.NO_CONVERT)

        # Insert a grade cell before every exercise cell.
        i = 0
        cells = notebook['cells']
        while i < len(cells):
            if cells[i]['source'].startswith(EXER_HEADER):
                # Exercise cell: insert a new grade cell before.
                cells.insert(i, GRADE_CELL)
                i += 2
            elif cells[i]['source'] == GRADE_HEADER:
                # Grade cell: skip past the subsequent exercise cell.
                i += 2
            else:
                i += 1

        nb.validate(notebook)
        nb.write(notebook, path)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("command", choices = ('strip', 'grade'),
        help = "action to take")
    ap.add_argument("path", help = "path to file or directory")

    args = ap.parse_args()
    if args.command == 'strip':
        nb_strip(args.path)
    elif args.command == 'grade':
        nb_grade(args.path)


if __name__ == '__main__':
    main()
