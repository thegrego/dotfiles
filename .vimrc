unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Vim-plug - VIM plugin manager config
call plug#begin('~/.vim/plugged')

" replace for all character case and text combinations
Plug 'tpope/vim-abolish'

" Dims text above and below the active paragraph
Plug 'junegunn/limelight.vim'

" Python autocompletion with Jedi engine
Plug 'davidhalter/jedi-vim'

" Linters and fixers engine
Plug 'dense-analysis/ale'

call plug#end()

" Start of Jedi config
let g:jedi#show_call_signatures = "0"
" End of Jedi config

" Start of Ale config

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let b:ale_linters = {'python': ['flake8', 'pydocstyle', 'bandit', 'mypy']}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'python': ['black', 'isort'],
      \}

" End of Ale config

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

let mapleader = ";"

" if has("autocmd")
"   " Treat all .md files as markdown
"   autocmd BufNewFile,BufRead *.md set filetype=markdown
" endif

filetype plugin indent on

set nobackup			" do not keep a backup file, user versions instead
      "employeeLocation": "123",
      "iso_dom_cd": "ch",

set clipboard=unnamed

set ts=2
set sw=2
set expandtab
set nu
set hlsearch
set relativenumber
set background=dark
colorscheme solarized

" if search string is lowecase the search is case insensitive,
" if search contains upper case characters then the search is case sensitive
" but first ignorecase must be on to use what smarcase gives
set ignorecase
set smartcase
set path+=** " fuzzy recursive search starting from the current directory

if &diff
	colorscheme industry
endif

" Limelight
" Color name (:help cterm-colors) or ANSI code
" let g:limelight_conceal_ctermfg = 'blue'
let g:limelight_conceal_ctermfg = 255

" Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = 'Red'
" let g:limelight_conceal_guifg = '#333333'

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

" Highlight line
set cursorlineopt=line
highlight clear CursorLine
highlight clear CursorLineNR
highlight CursorLine cterm=bold ctermbg=0 ctermfg=NONE guibg=darkred guifg=white
set cul

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Convinient way to do basic cursor movement in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <C-w> <S-Right>
inoremap <C-b> <S-left>
inoremap <C-^> <Home>
inoremap <C-$> <End>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Buffers list
map <leader>bl :buffers<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
    set stal=1
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()} " local paste mode if enabled
set statusline+=%F%m%r%h " Full path, modified tag [+] or [-], read only flag [RO], help buffer flag [help]
set statusline+=\ %w " Preview window flag [Preview]
set statusline+=\ \ CWD:\ %{getcwd()} " Working directory
set statusline+=\ \ L:%l/%L\ %P\ C:%c " curren line/lines, percentage through file of displayed window, current column
set statusline+=\ \ B:%n\ %Y " Buffer number, filetype [vim]
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\ %{&ff} " Encoding and Fileformat

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.yml,*.yaml :call CleanExtraSpaces()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
noremap <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
noremap <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>

" Toggle highlight current line
noremap <leader>hl :setlocal cul!<cr>

" Errors/search list in horizontal split - bottom
noremap <leader>co :copen<cr>

" Close errors/search split
noremap <leader>ccl :ccl<cr>

" Errors/search list
noremap <leader>cl :cl<cr>

" Next on the errors/search list
noremap <leader>cn :cn<cr>

" Previous on the errors/search list
noremap <leader>cp :cp<cr>

" Display error/elment from the errors/search list
noremap <leader>cc :cp.v:count1<cr>

" Save the folds on close and load the folds on open
au BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
au BufWinEnter ?* silent! loadview

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
