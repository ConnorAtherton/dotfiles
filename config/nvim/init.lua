-- This makes each module source friendly such that I can source $VIMRC
-- and the editor will always pick up new config (closing and opening each config modification gets annoying)
local load = function(mod)
  package.loaded[mod] = nil
  return require(mod)
end

load 'user.options'
load 'user.plugins'
load 'user.keymaps'

-- Hack until everything is moved over
vim.cmd [[
  colorscheme nord

  "/
  "/  Goyo
  "/
  " TODO:
  " - if filetype is txt or md, enable spelling and grammar
  function! ProseMode()
    call goyo#execute(0, [])
    " TODO: Not sure what this does
    set complete+=s
    " Check out the goyo hooks for tmux settings in: goyo_ente and goyo_leave
  endfunction

  command! ProseMode call ProseMode()
  nmap <Leader>p :ProseMode<CR>
  function! s:goyo_enter()
    silent !tmux set status off
    set nocursorcolumn
    set nocursorline
    set noshowmode
    set noshowcmd
  endfunction

  function! s:goyo_leave()
    silent !tmux set status on
    set cursorcolumn
    set cursorline
    set showmode
    set showcmd
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  " Color name (:help cterm-colors) or ANSI code
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_ctermfg = 240

  " Color name (:help gui-colors) or RGB color
  let g:limelight_conceal_guifg = 'DarkGray'
  let g:limelight_conceal_guifg = '#777777'

  " Default: 0.5
  let g:limelight_default_coefficient = 0.7

  " Number of preceding/following paragraphs to include (default: 0)
  let g:limelight_paragraph_span = 1

  " Beginning/end of paragraph
  "   When there's no empty line between the paragraphs
  "   and each paragraph starts with indentation
  let g:limelight_bop = '^\s'
  let g:limelight_eop = '\ze\n^\s'

  " Highlighting priority (default: 10)
  "   Set it to -1 not to overrule hlsearch
  let g:limelight_priority = -1
]]
