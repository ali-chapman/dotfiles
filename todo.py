#!/usr/bin/env python
import os
import argparse
from datetime import datetime

def main():
    todo_conf = os.path.expanduser('~/.config/.todo')
    done_conf = os.path.expanduser('~/.config/.done')
    
    # Ensure both files exist
    for conf in [todo_conf, done_conf]:
        if not os.path.exists(conf):
            with open(conf, 'w'):
                pass

    # Read existing todos
    with open(todo_conf, 'r') as f:
        lines = f.readlines()

    lines = [line.strip() for line in lines if line.strip()]

    parser = argparse.ArgumentParser(description="List, add, remove, or edit todo items.")
    parser.add_argument('input', nargs='*', help="Either indices to show, the todo item to add, or no argument to list todos")
    parser.add_argument('-r', '--remove', metavar="INDEX", type=int, help="Complete and remove an item by INDEX number.")
    parser.add_argument('-e', '--edit', nargs=2, metavar=("INDEX", "ITEM"), help="Edit an item at INDEX with the provided text.")
    parser.add_argument('-f', '--filter', metavar="KEYWORD", help="Filter todos by a keyword. Can be used with '-d'")
    parser.add_argument('-d', '--show-done', action='store_true', help="Show completed todos")
    parser.add_argument('-q', '--quiet', action=argparse.BooleanOptionalAction, help="Suppress output")
    args = parser.parse_args()

    # Show done todos if requested
    if args.show_done:
        with open(done_conf, 'r') as f:
            done_lines = f.readlines()
        if not done_lines:
            print("No completed todos.")
        else:
            print("Completed Todos:")
            for line in done_lines:
                if args.filter:
                    if args.filter.lower() in line.lower():
                        print(line.strip())
                else:
                    print(line.strip())
        return

    # Always apply edit first if present
    if args.edit:
        index, new_text = args.edit
        if 1 <= int(index) <= len(lines):
            lines[int(index) - 1] = new_text
            with open(todo_conf, 'w') as f:
                f.writelines('\n'.join(lines) + '\n')
            if not args.quiet:
                print_lines(todo_conf)
        else:
            print(f"Invalid index: {index}")
    
    # Handle remove (marking as done)
    if args.remove:
        if 1 <= args.remove <= len(lines):
            # Get the todo item to be marked as done
            done_item = lines.pop(args.remove - 1)
            
            # Add timestamp to the done item
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            done_entry = f"{timestamp} - {done_item}\n"
            
            # Write to todo file
            with open(todo_conf, 'w') as f:
                f.writelines('\n'.join(lines) + '\n')
            
            # Append to done file
            with open(done_conf, 'a') as f:
                f.write(done_entry)
            
            if not args.quiet:
                print(f"Completed: {done_item}")
                print_lines(todo_conf)
        else:
            print(f"Invalid index: {args.remove}")
    
    # Handle filter
    if args.filter:
        for line in enumerated_lines(todo_conf):
            if args.filter.lower() in line.lower():
                print(line)
        return

    # If all inputs are digits, show those specific todos
    if args.input and all(arg.isdigit() for arg in args.input):
        for index in map(int, args.input):
            if 1 <= index <= len(lines):
                print(f"[{index}]: {lines[index - 1]}")
            else:
                print(f"Invalid index: {index}")
        return

    # If no specific action and no input, always show todos
    if not args.input and not args.remove and not args.edit and not args.filter:
        if not lines:
            print("No items in the TODO list.")
        else:
            print_lines(todo_conf)
        return

    # If input is not indices, treat as a new todo item
    if args.input:
        todo_item = ' '.join(args.input)
        with open(todo_conf, 'a') as f:
            f.write(todo_item.replace('\n', '') + '\n')
        if not args.quiet:
            print_lines(todo_conf)
 
def print_lines(conf, filter=None):
    if filter:
        lines = [line for line in enumerated_lines(conf) if filter.lower() in line.lower()]
    else:
        lines = enumerated_lines(conf)
    for line in lines:
        print(line)

def enumerated_lines(conf):
    with open(conf, 'r') as f:
        lines = f.readlines()
    lines = [line.strip() for line in lines if line.strip()]
    return [f"[{i+1}]: {item}" for i, item in enumerate(lines)]

if __name__ == "__main__":
    main()
