#!/usr/bin/env python3

import os
import sys
import subprocess
import argparse
import shutil
from pathlib import Path
from datetime import datetime

def check_dependencies():
    """Check if required external programs are available."""
    if not shutil.which('fzf'):
        print("Error: 'fzf' is not installed or not in PATH.")
        print("\nTo install fzf:")
        print("  - On Ubuntu/Debian: sudo apt install fzf")
        print("  - On macOS: brew install fzf")
        print("  - On other systems: visit https://github.com/junegunn/fzf#installation")
        sys.exit(1)

def get_editor():
    """Retrieve the editor to use from the $EDITOR environment variable."""
    editor = os.getenv('EDITOR')
    if not editor:
        print("Error: The $EDITOR environment variable is not set. Please set it to your preferred editor.")
        sys.exit(1)
    return editor

def get_notes_directory():
    """Retrieve the directory to store notes from the $NOTES_DIRECTORY environment variable."""
    notes_dir = os.getenv('NOTES_DIRECTORY', Path.home() / ".notes")
    notes_path = Path(notes_dir)
    notes_path.mkdir(parents=True, exist_ok=True)
    return notes_path

def note(title=None):
    """
    Manage notes with fuzzy search and creation functionality.
    
    Args:
        title (str, optional): Partial title of the note to search for.
    """
    notes_dir = get_notes_directory()
    editor = get_editor()

    # If no title provided, list all notes ordered by date
    if not title:
        notes = sorted(
            notes_dir.glob('*.md'), 
            key=lambda p: datetime.strptime(p.stem.split()[0], "%d-%b-%Y") if len(p.stem.split()) > 0 else p.stat().st_mtime,
            reverse=True
        )
        for note_path in notes:
            print(note_path.name)
        return

    # Case-insensitive search for markdown files containing the title
    matches = list(notes_dir.glob(f'*{title}*.md'))

    if len(matches) == 1:
        # One match found, open with the editor
        subprocess.run([editor, str(matches[0])])
    elif len(matches) > 1:
        # Multiple matches, use fzf for selection
        try:
            selected_file = subprocess.run(
                ['fzf'], 
                input='\n'.join(str(m) for m in matches), 
                capture_output=True, 
                text=True, 
                cwd=str(notes_dir)
            )
            
            if selected_file.returncode == 0:
                subprocess.run([editor, selected_file.stdout.strip()])
            else:
                print("No file selected. Aborting.")
        except subprocess.CalledProcessError:
            print("Error: Failed to run fzf. Please check if it's installed correctly.")
            sys.exit(1)
    else:
        # No matches, create a new file with current date and title
        current_date = datetime.now().strftime("%d-%b-%Y")
        new_file = notes_dir / f"{current_date} {title}.md"
        subprocess.run([editor, str(new_file)])

def main():
    parser = argparse.ArgumentParser(
        description='A note-taking script that manages markdown files.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  note                     List all notes, sorted by date
  note meeting            Search for notes containing "meeting" or create a new one
  note "team standup"     Create/search note with spaces in the title
        '''
    )
    parser.add_argument(
        'title', 
        nargs='*', 
        help='Optional title to search for or create a new note'
    )
    
    # Check for required dependencies before processing arguments
    check_dependencies()
    
    args = parser.parse_args()
    note(' '.join(args.title) if args.title else None)

if __name__ == "__main__":
    main()
