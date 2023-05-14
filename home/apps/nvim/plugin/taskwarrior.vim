" ===========================================================================
" ============================== Taskwarrior ================================
" ===========================================================================
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
let g:task_report_command  = ['summary', 'age', 'today', 'high', 'sch']
" allows user to override task configurations. Seperated by space.
let g:task_rc_override     = 'rc.defaultwidth=999'
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <'
" backward arrow ...
let g:task_left_arrow      = '> '
" info window position
let g:task_info_position   = 'belowright'
" default fields to ask for
let g:task_default_prompt  = ['project', 'schedule', 'due', 'tag', 'is',
      \'description', 'depends']

" set custom highlights
highlight link taskwarrior_id               Grey
highlight link taskwarrior_is               Green
highlight link taskwarrior_due              RedBold
highlight link taskwarrior_priority         Orange
highlight link taskwarrior_depends          Aqua
highlight link taskwarrior_scheduled        Yellow
highlight link taskwarrior_estimate         Purple
highlight link taskwarrior_totalactivetime  Blue
highlight link taskwarrior_until            Gray
highlight link taskwarrior_start            GreenBold
highlight link taskwarrior_project          Red
highlight link taskwarrior_tags             Green
highlight link taskwarrior_description      Normal

highlight link taskwarrior_entry            Orange
