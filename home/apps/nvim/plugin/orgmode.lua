require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {'~/Documents/sb/**/*' },
  org_agenda_skip_scheduled_if_done = true,
  org_agenda_skip_deadline_if_done = true,
  org_deadline_warning_days = 4,
  org_default_notes_file = '~/Documents/sb/inbox.org',
  org_todo_keywords = { 'TODO(t)', 'ON HOLD(o)', 'BLOCKED(b)', 'DELAYED(y)', '|', 'DONE(d)', 'DELEGATED(l)'},
  org_log_into_drawer = 'LOGBOOK',
  org_tags_column = 100,
  org_archive_location = 'archive/%s',
  org_blank_before_new_entry = {
    heading = false,
    plain_list_item = false,
  },
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '** TODO %?\n   CREATED: %U'
    },
    s = {
      description = 'Scheduled Task',
      template = '** TODO %?\n   CREATED: %U SCHEDULED: %t'
    },
    d = {
      description = 'Done Task',
      template = '** DONE %?\n   CREATED: %U SCHEDULED: %t CLOSED: %U'
    },
    n = {
      description = 'Note',
      template = '** TODO %?\n   CREATED: %U\n   Relates to: %a'
    },
    j = {
      description = 'Journal Entry',
      template = '** %<%Y-%m-%d> %<%A>\n*** %U\n    %?',
      target = '~/Documents/sb/journal.org',
    },
  },
  mappings = {
    org = {
      org_timestamp_up = '<c-q>'
    }
  }
})
