#! /usr/bin/bash

function note() {
  local notes_dir="${HOME}/notes"
  local title="$1"

  if [ -z "$title" ]; then
    ls $notes_dir
    return
  fi

  shopt -s nocaseglob

  # Search for markdown files containing the title in the filename
  local matches=("$notes_dir"/*"$title"*.md)

  shopt -u nocaseglob

  if [ ${#matches[@]} -eq 1 ] && [ "${matches[0]}" != "$notes_dir/*$title*.md" ]; then
    # One match found, open it with lvim
    lvim "${matches[0]}"
  elif [ ${#matches[@]} -gt 1 ]; then
    # Multiple matches found, use fzf to let the user select one
    local selected_file=$(printf "%s\n" "${matches[@]}" | fzf)

    if [ -n "$selected_file" ]; then
      lvim "$selected_file"
    else
      echo "No file selected. Aborting."
    fi

  else
    # No matches found, create a new file with the current date and title
    local current_date=$(date +%d-%b-%Y)
    local new_file="$notes_dir/$current_date $title.md"
    lvim "$new_file"
  fi

}

 

function open_note() {
  local folder="${HOME}/Documents/notes"
  lvim "${folder}/$(ls $folder | fzf)"
}
