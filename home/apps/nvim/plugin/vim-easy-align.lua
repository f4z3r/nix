vim.g.easy_align_delimiters = {
  ['>'] = {
    ['pattern'] = '>>\\|=>\\|>'
  },
  ['/'] = {
    ['pattern'] =         '//\\+\\|/\\*\\|\\*/',
    ['delimiter_align'] = 'l',
    ['ignore_groups'] =   { '!Comment' }
  },
  [']'] = {
    ['pattern'] =       '[[\\]]',
    ['left_margin'] =   0,
    ['right_margin'] =  0,
    ['stick_to_left'] = 0
  },
  [')'] = {
    ['pattern'] =       '[()]',
    ['left_margin'] =   0,
    ['right_margin'] =  0,
    ['stick_to_left'] = 0
  },
  ['d'] = {
    ['pattern'] =      ' \\(\\S\\+\\s*[;=]\\)\\@=',
    ['left_margin'] =  0,
    ['right_margin'] = 0
  }
}

vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
