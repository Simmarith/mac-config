if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'leshill/vim-json'
Plug 'jparise/vim-graphql'
Plug '/usr/local/opt/fzf/'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'groenewege/vim-less'
Plug 'alvan/vim-closetag'
Plug 'heavenshell/vim-jsdoc'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'obxhdx/vim-auto-highlight'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'maksimr/vim-jsbeautify'
Plug 'thinca/vim-localrc'
Plug 'airblade/vim-gitgutter'
Plug 'stevearc/vim-arduino'
Plug 'tpope/vim-surround'
Plug 'hashivim/vim-terraform'
Plug 'CodeMyst/vimsence'

call plug#end()

" Vanilla Settings

set number relativenumber
set splitbelow splitright
set expandtab
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
colorscheme ron 

" Plugin Settings

let mapleader = ","
let g:ycm_autoclose_preview_window_after_completion = 1
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_additional_descriptions = 1
let g:jsdoc_input_description = 1
let g:jsdoc_enable_es6 = 1
let g:AutoPairsFlyMode = 0
let test#javascript#mocha#executable = 'cross-env NODE_ENV=test mocha --inspect-brk --compilers js:babel-core/register'
let g:goyo_width = 120
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:editorconfig_Beautifier = '~/.vim/.editorconfig'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ale_fixers = ['eslint']
let g:ale_fix_on_save = 1

" Testing suite
nmap <silent> t<c-n> :TestNearest<CR>
nmap <silent> t<c-f> :TestFile<CR>
nmap <silent> t<c-a> :TestSuite<CR>
nmap <silent> t<c-l> :TestLast<CR>
nmap <silent> t<c-g> :TestVisit<CR>

" Alignment formatting
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" JS formatter
autocmd FileType javascript noremap <buffer>  <c-f> :ALEFix<cr>
autocmd FileType vue noremap <buffer> <c-f> :ALEFix<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Status line customisation
function! MyStatusLine()
  " default
  let line = '%f%m %y'
  " Arduino stuff
  if &ft == 'arduino'
    let port = arduino#GetPort()
    let board = g:arduino_board
    let line = '%f%m [' . matchstr(board, '[^,]*') . '] [' . g:arduino_programmer . ']'
    if !empty(port)
      let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
    endif
  endif
  return line
endfunction
autocmd BufRead,BufNewFile,BufEnter * setl statusline=%!MyStatusLine()

" Weird filetypes
autocmd BufNewFile,BufRead *.groff set filetype=groff

" Automation
autocmd BufWritePost *.groff silent! !groff -m ms % -T pdf > %.pdf

" Custom Makros

nmap <s-f> :FZF<cr>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
