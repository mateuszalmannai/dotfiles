todos() {
  cd "${NOTES_ROOT}" || return 
  $EDITOR "$(rg -le '\[ \]' --sort created | fzf)"
  cd - || return
}
