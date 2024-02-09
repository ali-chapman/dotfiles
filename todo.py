#!/usr/bin/env python
import os
import argparse

def main():
    conf = os.path.expanduser('~/.config/.todo')
    if not os.path.exists(conf):
        with open(conf, 'w'):
            pass

    with open(conf, 'r') as f:
        lines = f.readlines()

    lines = [line.strip() for line in lines if line.strip()]

    parser = argparse.ArgumentParser(description="List, add, remove, or edit todo items.")
    parser.add_argument('index', nargs='*', type=int, help="Index number of item.")
    parser.add_argument('-a', '--add', metavar="ITEM", help="Add a todo item.")
    parser.add_argument('-r', '--remove', metavar="INDEX", type=int, help="Remove an item by INDEX number.")
    parser.add_argument('-e', '--edit', nargs=2, metavar=("INDEX", "ITEM"), help="Edit an item at INDEX with the provided text.")
    parser.add_argument('-f', '--filter', metavar="KEYWORD", help="Filter todos by a keyword")
    args = parser.parse_args()

    if args.edit:
        index, new_text = args.edit
        if 1 <= int(index) <= len(lines):
            lines[int(index) - 1] = new_text
            with open(conf, 'w') as f:
                f.writelines('\n'.join(lines) + '\n')
            print_lines(conf)
        else:
            print(f"Invalid index: {index}")
 
    if not args.index and not args.add and not args.remove and not args.edit and not args.filter:
        if not lines:
            print("No items in the TODO list.")
        else:
            print_lines(conf)
    elif args.filter:
        for line in enumerated_lines(conf):
            if args.filter.lower() in line.lower():
                print(line)
    elif args.index:
        for index in args.index:
            if 1 <= index <= len(lines):
                print(f"[{index}]: {lines[index - 1]}")
            else:
                print(f"Invalid index: {index}")
    elif args.add:
        with open(conf, 'a') as f:
            f.write(args.add.replace('\n', '') + '\n')
        print_lines(conf)
    elif args.remove:
        if 1 <= args.remove <= len(lines):
            lines.pop(args.remove - 1)
            with open(conf, 'w') as f:
                f.writelines('\n'.join(lines) + '\n')
            print_lines(conf)
        else:
            print(f"Invalid index: {args.remove}")
 
def print_lines(conf):
    for line in enumerated_lines(conf):
        print(line)

def enumerated_lines(conf):
    with open(conf, 'r') as f:
        lines = f.readlines()
    lines = [line.strip() for line in lines if line.strip()]
    return [f"[{i+1}]: {item}" for i, item in enumerate(lines)]

if __name__ == "__main__":
    main()
