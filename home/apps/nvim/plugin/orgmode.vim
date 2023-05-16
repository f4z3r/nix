" ===========================================================================
" =============================== Org Mode ==================================
" ===========================================================================

lua << EOF
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {'~/Documents/sb/**/*' },
  org_default_notes_file = '~/Documents/sb/todo/scratch.org',
  org_todo_keywords = { 'TODO(t)', 'ON HOLD(o)', 'BLOCKED(b)', '|', 'DONE(d)', 'DELEGATED'},
  org_log_into_drawer = 'LOGBOOK',
  org_tags_column = 100,
  org_archive_location = '~/Documents/sb/archive/default.org',
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n  %U'
    },
    s = {
      description = 'Scheduled Task',
      template = '* TODO %?\n  %U SCHEDULED: %t'
    },
    d = {
      description = 'Done Task',
      template = '* DONE %?\n  %U SCHEDULED: %t CLOSED: %U'
    },
    n = {
      description = 'Note',
      template = '* TODO %?\n  %U\n  Relates to: %a'
    }
  }
})
EOF
