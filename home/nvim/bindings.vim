" ===========================================================================
" ==================== General Bindings Multi-Language ======================
" ===========================================================================

" ==== Leader ============================================================{{{
" Leader update
let maplocalleader = '\'
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
" }}}


" ==== ESC remaps ========================================================{{{
" <Esc> remaps
nnoremap <c-y> <esc>
inoremap <c-y> <esc>
vnoremap <c-y> <esc>
cnoremap <c-y> <esc>
tnoremap <esc> <c-\><c-N>
" }}}


" ==== Folding ==========================================================={{{
" reduce foldlevel
nnoremap [f zm
" increase foldlevel
nnoremap ]f zr
" unmap s in normal mode
nmap s <nop>
" Split downwards
nmap sj :SplitjoinSplit<cr>
" Join upwards
nmap sk :SplitjoinJoin<cr>
" }}}


" ==== Debugging ========================================================={{{
" launch
nnoremap <leader>dd :call vimspector#Launch()<cr>
" reset
nnoremap <leader>dr :call vimspector#Reset()<cr>
" continue
nnoremap <leader>dc :call vimspector#Continue()<cr>
" toggle
nnoremap <leader>dt :call vimspector#ToggleBreakpoint()<cr>
nnoremap <leader>dT :call vimspector#ClearBreakpoints()<cr>
" restart
nmap <leader>dk <Plug>VimspectorRestart
" out
nmap <leader>do <Plug>VimspectorStepOut
" in
nmap <leader>di <Plug>VimspectorStepInto
" step
nmap <leader>ds <Plug>VimspectorStepOver
" inspect
nmap <leader>di <Plug>VimspectorBalloonEval
xmap <leader>di <Plug>VimspectorBalloonEval
" }}}


" ==== Vimux ============================================================={{{
" (v)imux (p)rompt
nnoremap <leader>vp :VimuxPromptCommand<cr>
" (v)imux (c)ommand
nmap <c-c> :VimuxPromptCommand<cr>
" (v)imux (l)ast
nnoremap <leader>vl :VimuxRunLastCommand<cr>
" (v)imux (q)uit
nnoremap <leader>vq :VimuxCloseRunner<cr>
" (v)imux interrupt
nnoremap <leader>vx :VimuxInterrruptRunner<cr>
" (v)imux (i)nspect
nnoremap <leader>vi :VimuxInspectRunner<cr>
" (v)imux (z)oom
nnoremap <leader>vz :call VimuxZoomRunner()<cr>
" send selected text to vimux
function! VimuxSlime()
  call VimuxRunCommand(@v, 0)
endfunction
" vimux slime
vnoremap <c-d> "vy :call VimuxSlime()<cr>
" send enter
nnoremap <c-d> :call VimuxSendKeys("Enter")<cr>
" }}}


" ==== Refactoring ======================================================={{{
" (r)efactor (s)earch error
nnoremap <leader>rs :CocList diagnostics<cr>
" (r)efactor (r)ename
nmap <leader>rr <Plug>(coc-rename)
" refactor (n)ext error
nmap ]e <plug>(ale_next_wrap_error)
" refactor (p)revious error
nmap [e <plug>(ale_previous_wrap_error)
" refactor (w)arnings (n)ext
nmap ]w <plug>(ale_next_wrap_warning)
" refactor (w)arnings (p)revious
nmap [w <plug>(ale_previous_wrap_warning)
" (r)efactor (f)ix
nnoremap <leader>rf :ALEFix<cr>
" (r)efactor (S)uggest fixes
nnoremap <leader>rS :ALEFixSuggest<cr>
" (r)efactor (l)int
nnoremap <leader>rl :ALELint<cr>
" (r)efactor (c)oc (d)isable
nnoremap <leader>rcd :CocDisable<cr>
" (r)efactor (c)oc (e)nable
nnoremap <leader>rce :CocEnable<cr>
" (r)efactor (a)le (d)isable
nnoremap <leader>rad :ALEDisable<cr>
" (r)efactor (a)le (e)nable
nnoremap <leader>rae :ALEEnable<cr>
" coc goto overrides
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" }}}


" ==== Quickfix =========================================================={{{
" (q)uickfix (n)ext
nnoremap ]q :cnext<cr>
" (q)uickfix (p)revious
nnoremap [q :cprevious<cr>
" (q)uickfix (o)pen
nnoremap <leader>qo :copen<cr>
" (q)uickfix (c)lose
nnoremap <leader>qc :cclose<cr>
" (q)uickfix (s)earch
nnoremap <leader>qs <cmd>lua require('telescope.builtin').quickfix()<cr>
" }}}


" ==== Locations ========================================================={{{
" (l)ocation list (n)ext
nnoremap ]l :lnext<cr>
" (l)ocation list (o)pen
nnoremap [l :lprevious<cr>
" (l)ocation list (o)open
nnoremap <leader>lo :lopen<cr>
" (l)ocation list (c)lose
nnoremap <leader>lc :lclose<cr>
" (l)ocation (s)earch
nnoremap <leader>ls <cmd>lua require('telescope.builtin').loclist()<cr>
" }}}


" ==== AutoComplete ======================================================{{{
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" see plugin/coc.vim for documentation showing
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <c-j> <Plug>(coc-snippets-expand-jump)
" }}}


" ==== Movement =========================================================={{{
" Scrolling
nnoremap n j
nnoremap N J
vnoremap n j
vnoremap N J

" Fast scrolling
nnoremap <c-n> 10j
nnoremap <c-k> 10k
vnoremap <c-n> 10j
vnoremap <c-k> 10k

" Scrolling by visual line
nnoremap <M-n> gj
nnoremap <M-k> gk
vnoremap <M-n> gj
vnoremap <M-k> gk
nnoremap <M-h> g0
nnoremap <M-l> g$
vnoremap <M-h> g0
vnoremap <M-l> g$
" Fast front back line movement
nnoremap <c-h> zH_
nnoremap <c-l> $
vnoremap <c-h> zH_
vnoremap <c-l> $
onoremap <c-h> _
onoremap <c-l> $
" Enable camelCase inner word motion with WORD
map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> gE <Plug>CamelCaseMotion_ge
sunmap W
sunmap B
sunmap E
sunmap gE

" Easy movement in insert mode
" delete word and char already default <c-w> and <c-h> respectively
" <c-a> pastes default register
" move to end of line
inoremap <c-e> <c-o>A
" move to beginning of line
inoremap <c-b> <c-o>I

" coc scrolling on hover
nnoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" }}}


" ==== Text Objects ======================================================{{{
" Create mappings for function text objects
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" }}}


" ==== Search ============================================================{{{
" (s)earch (t)ags
nnoremap <leader>st <cmd>lua require('telescope.builtin').tags()<cr>
" (s)earch local (t)ags
nnoremap <leader>sT <cmd>lua require('telescope.builtin').current_buffer_tags()<cr>
" (s)earch (g)it commit
nnoremap <leader>sg <cmd>lua require('telescope.builtin').git_commits()<cr>
" (s)earch (C)ommand
nnoremap <leader>sC <cmd>lua require('telescope.builtin').commands()<cr>
" (s)earch using (a)g (silver searcher/ripgrep)
nnoremap <leader>sa <cmd>lua require('telescope.builtin').live_grep()<cr>
" (s)earch (k)eymapping
nnoremap <leader>sk <cmd>lua require('telescope.builtin').keymaps()<cr>
" (s)earch (s)earch history
nnoremap <leader>sS <cmd>lua require('telescope.builtin').search_history()<cr>
" (s)earch command (h)istory
nnoremap <leader>sh <cmd>lua require('telescope.builtin').command_history()<cr>
" (s)earch (c)ontinue
nnoremap <leader>sc <cmd>lua require('telescope.builtin').resume()<cr>
" (s)earch silver searcher like for cusor word
nnoremap <leader>sA <cmd>lua require('telescope.builtin').grep_string()<cr>
" (s)earch (l)ocationlist
nnoremap <leader>sl <cmd>lua require('telescope.builtin').loclist()<cr>
" (s)earch (q)uicklist
nnoremap <leader>sq <cmd>lua require('telescope.builtin').quickfix()<cr>
" (s)earch all (Q)uicklists
nnoremap <leader>sQ <cmd>lua require('telescope.builtin').quickfixhistory()<cr>

" (s)earch (r)eferences
nnoremap <leader>sr :Telescope coc references_used<cr>
" (s)earch (d)efinitions
nnoremap <leader>sd :Telescope coc definitions<cr>
" (s)earch (i)mplementations
nnoremap <leader>si :Telescope coc implementations<cr>
" (s)earch (s)ymbols
nnoremap <leader>ss :Telescope coc document_symbols<cr>
" (s)earch (w)orkspace symbols
nnoremap <leader>sw :Telescope coc workspace_symbols<cr>

" see plugin/grep-operator.vim (ss)
" search for visual selection using //
vnoremap // y/\V<c-r>=escape(@",'/\')<cr><cr>
" (s)earch (n)otes
nnoremap <leader>sn :Pad search<cr>
" make all searches appear in the middle of the screen
nnoremap j nzz
nnoremap J Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" }}}


" ==== Machine (System) =================================================={{{
" (m)achine open terminal in (t)ab
nnoremap <leader>zt :tabnew<cr>:terminal<cr>a
" (m)achine open terminal on (s)split
nnoremap <leader>zs :split<cr>:terminal<cr>a
" (m)achine open terminal on (v)ertical split
nnoremap <leader>zv :vsplit<cr>:terminal<cr>a
" (m)achine vim (q)uit
nnoremap <c-q> :qa<cr>
" (m)achine vim (q)uit
nnoremap <leader>zq :qa<cr>
" (m)achine vim suspend (sleep zzz)
nnoremap <leader>zz <c-z>
" (m)achine vim hard (Q)uit
nnoremap <leader>zQ :qa!<cr>
" (m)achine (c)hange (d)irectory to directory of local file (only for tab)
nnoremap <leader>zcd :tcd %:p:h<cr>
" (m)achine (u)ndo change directory (only for tab)
nnoremap <leader>zu :execute 'tcd' . Get_project_root()<cr>
" }}}


" ==== Toggles ==========================================================={{{
" (t)oggle (t)agbar
nnoremap <localleader>tt :TagbarToggle<cr>
" (t)oggle colorcolumn (l)ine
nnoremap <localleader>tl :set colorcolumn=100<cr>
" (t)oggle (g)olden ratio
nnoremap <localleader>tg :GoldenRatioToggle<cr>
" (t)oggle (u)ndo tree
nnoremap <localleader>tu :GundoToggle<cr>
" (t)oggle (b)ackground
nnoremap <localleader>tb :call Toggle_background()<cr>
" (t)oggle (s)yntax
nnoremap <expr> <localleader>ts exists('g:syntax_on') ? ':syntax off<cr>' : ':syntax enable<cr>'
" (t)oggle (w)rap
nnoremap <localleader>tw :call Toggle_wrap()<cr>
" }}}


" ==== Git ==============================================================={{{
" (g)it (s)tatus
nnoremap <leader>gs :Git<cr>
" (g)it (p)tatus
nnoremap <leader>gp :Git! push<cr>
" (g)it (f)etch
nnoremap <leader>gf :Git! fetch<cr>
" (g)it pul(l)
nnoremap <leader>gl :Git! pull<cr>
" (g)it (c)ommit
nnoremap <leader>gc :Git commit<cr>a
" (g)it (a)dd
nnoremap <leader>ga :GWrite<cr>
" (g)it (A)mend
nnoremap <leader>gA :Git commit --amend<cr>
" (g)it (m)ove
nnoremap <leader>gm :GMove
" (g)it (b)lame
nnoremap <leader>gb :Git blame<cr>
" Use for merge conflicts, head refers to local changes, last refers to pulled
" changes.
" (g)it (d)iff
nnoremap <leader>gd :Gvdiffsplit!<cr>
" (g)it diff (h)ead
nnoremap <leader>gh :diffset //2<cr>
" (g)it diff last(z)
nnoremap <leader>gz :diffset //3<cr>
" }}}


" ==== Files ============================================================={{{
" Switch to alternate file
nnoremap <localleader>s :A<enter>
" Trigger dispatch maker
nnoremap <leader>m :Dispatch<enter>
" Trigger dispatch maker in the background
nnoremap <leader>p :Dispatch!<enter>
" (f)ile (s)ave
nnoremap <leader>fs :update<cr>
" (f)ile (n)ew (in buffer's dir)
nnoremap <leader>fn :e %:p:h/
" (f)ile (N)ew in project root
nnoremap <leader>fN :e
" control-p link
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>
" (f)iles in (p)roject
nnoremap <leader>ff <cmd>lua require('telescope.builtin').git_files()<cr>
" (f)iles (c)ontent
nnoremap <leader>fc <cmd>lua require('telescope.builtin').live_grep()<cr>

" (f)ile (r)efresh
nnoremap <leader>fr :checktime %<cr>
" (f)ile new (t)emp
nnoremap <leader>ft :execute "e " . Get_tmp_file()<cr>
" fern integration
nnoremap - :execute 'Fern ' . Get_project_root() . ' -drawer -reveal=%'<cr>
nnoremap + :execute 'Fern ' . Get_project_root() . ' -drawer -toggle -reveal=%'<cr>
" }}}


" ==== Windows ==========================================================={{{
" (w)indow (d)elete
nnoremap <leader>wd :q<cr>
" (w)indow (v)ertical split
nnoremap <leader>wv :vsplit<cr>
" (w)indow (s)plit
nnoremap <leader>ws :split<cr>
" (w)indow (r)esize (balances all windows)
nnoremap <leader>wr <c-w>=
" (w)indow = equalize
nnoremap <leader>w= <c-w>=
" (w)indow focus l
nnoremap <leader>wl <c-w>lzH
tnoremap <leader>wl <c-\><c-N><c-w>lzH
" (w)indow focus h
nnoremap <leader>wh <c-w>hzH
tnoremap <leader>wh <c-\><c-N><c-w>hzH
" (w)indow focus j
nnoremap <leader>wn <c-w>jzH
tnoremap <leader>wn <c-\><c-N><c-w>jzH
" (w)indow focus k
nnoremap <leader>wk <c-w>kzH
tnoremap <leader>wk <c-\><c-N><c-w>kzH
" (w)indow (t)ab new
nnoremap <leader>wt :$tabnew<cr>
" }}}


" ==== Buffer ============================================================{{{
" (b)uffer (s)elect
nnoremap <leader>bs ggVG
" (b)uffer (y)ank
nnoremap <leader>by ggVGy
" close buffer without closing window command
command! Bd :bp | :sp | :bn | :bd
" (b)uffer (d)elete
nnoremap <leader>bd :Bd<cr>
" fast switch buffer
nnoremap <leader><tab> :b#<cr>
" (b)uffer fuzzy search
nnoremap <leader>bb <cmd>lua require('telescope.builtin').buffers()<cr>
" close all buffers except current
command! Bk execute '%bdelete|edit #|normal `"'
" (b)uffer only (k)eep current
nnoremap <leader>bk :Bk<cr>
" Navigate to buffer count within tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap [t <Plug>AirlineSelectPrevTab
nmap ]t <Plug>AirlineSelectNextTab
" }}}


" ==== Organisation ======================================================{{{
" Start (p)omodoro with name auto
nnoremap <leader>op :PomodoroStart auto<cr>
" (j)ump to next todo/fixme tag in file
nnoremap <silent> ]o /\C\<\(TODO\\|FIXME\\|XXX\\|OPTIMIZE\\|NOTE\)\><cr>:noh<cr>
" (J)ump to previous todo/fixme tag in file
nnoremap <silent> [o ?\C\<\(TODO\\|FIXME\\|XXX\\|OPTIMIZE\\|NOTE\)\><cr>:noh<cr>
" (o)rganisation generate (t)odo quickfix for current file
nnoremap <leader>ot :vimgrep /\C\<\(TODO\\|FIXME\\|XXX\\|OPTIMIZE\\|NOTE\)\>/g %<cr>:copen<cr>
" (o)rganisation (s)ession (c)reate
nnoremap <leader>osc :mksession ~/.vim/sessions/
" (o)rganisation (s)ession (l)oad
nnoremap <leader>osl :source ~/.vim/sessions/
" (o)rganisation (s)ession (m)anage
nnoremap <leader>osm :e ~/.vim/sessions/<cr>
" (o)rganisation (s)ession (m)anage
nnoremap <leader>osm :e ~/.vim/sessions/<cr>
" }}}


" ==== Notes ============================================================={{{
" (n)otes (s)earch
nnoremap <leader>ns :Pad search<cr>
" (n)otes (l)ist
nnoremap <leader>nl :Pad ls<cr>
" (n)otes (n)ew
nnoremap <leader>nn :Pad new<cr>
" (n)otes (f)ile (local)
nnoremap <leader>nf :Pad! this<cr>
" }}}


" ==== Testing ==========================================================={{{
" (t)est (n)earest
nnoremap <leader>tn :TestNearest<cr>
" (t)est (s)uite
nnoremap <leader>ts :TestSuite<cr>
" (t)est (f)ile
nnoremap <leader>tf :TestFile<cr>
" (t)est (l)ast
nnoremap <leader>tl :TestLast<cr>
" (t)est (v)isit
nnoremap <leader>tv :TestVisit<cr>
" }}}


" ==== Misc =============================================================={{{
" Simple pasting from default register
inoremap <c-r> <c-r>"
" Do not store the deleted text in default register when pasting in visual
" mode.
xnoremap <silent> p p:let @"=@0<cr>
" Copy default register contents to system copy clipboard
nnoremap <silent> <leader>yy :call Copy_to_clipboard()<cr>
" List yank stack
nnoremap <silent> <leader>yl  :<C-u>CocList -A --normal yank<cr>

" change last written word to UPPER_CASE
inoremap <M-l> <esc>bviwUea
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
