#!/usr/bin/env python3
# TODO:
#   * Currently, files must end with a blank line.

import sys

def main():
    task      = sys.argv[1]
    in_fname  = sys.argv[2]
    out_fname = sys.argv[3]

    with open(in_fname) as in_f, open(out_fname, 'wt') as out_f:
        if task == "clear":
            out_f.writelines(clear_code(in_f))
        elif task == "md":
            out_f.writelines(to_markdown(in_f))
        else:
            print("Invalid task!")


def clear_code(f):
    '''Clear code from an R script.
    '''
    for line in f:
        if line[0] not in ("#", "\n"):
            yield ""
        else:
            yield line


def to_markdown(f):
    '''Convert an R script to (R)Markdown.
    '''
    fenced = False
    prev_blank = False

    for line in f:
        if line[0:2] == "##":
            # This is a paragraph comment, so convert to plain text.
            if len(line) <= 3:
                yield line[2:]
            else:
                yield line[3:]

        elif line == "\n":
            # This is a blank line between comments, so print verbatim.
            yield line

        else:
            # This is a code block, so start a fence and print verbatim until
            # the next paragraph comment.
            prev_line = "```r\n"
            while line[0:2] != "##":
                yield prev_line
                prev_line = line
                line = next(f)
            yield "```\n\n"

            yield line[2:].lstrip(" ")


if __name__ == "__main__":
    main()
