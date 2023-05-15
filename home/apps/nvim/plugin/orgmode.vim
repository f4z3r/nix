" ===========================================================================
" =============================== Org Mode ==================================
" ===========================================================================

lua << EOF
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {'~/Documents/sb/**/*' },
  org_default_notes_file = '~/Documents/sb/todo/scratch.org',
  org_todo_keywords = { 'TODO(t)', 'BLOCKED(b)', '|', 'DONE(d)', 'DELEGATED'},
  org_log_into_drawer = 'LOGBOOK',
  org_tags_column = 100,
})
EOF
