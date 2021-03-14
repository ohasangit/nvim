" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

function! s:getGruvColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui") 
  let termColor = synIDattr(hlID(a:group), "fg", "cterm") 
  return [ guiColor, termColor ]
endfunction

let s:bg0  = s:getGruvColor('GruvboxBg0')
let s:bg1  = s:getGruvColor('GruvboxBg1')
let s:bg2  = s:getGruvColor('GruvboxBg2')
let s:bg4  = s:getGruvColor('GruvboxBg4')
let s:fg1  = s:getGruvColor('GruvboxFg1')
let s:fg4  = s:getGruvColor('GruvboxFg4')

let s:yellow = s:getGruvColor('GruvboxYellow')
let s:blue   = s:getGruvColor('GruvboxBlue')
let s:aqua   = s:getGruvColor('GruvboxAqua')
let s:orange = s:getGruvColor('GruvboxOrange')
let s:red    = s:getGruvColor('GruvboxRed')
let s:green  = s:getGruvColor('GruvboxGreen')
let s:purple = s:getGruvColor('GruvboxPurple')

call NERDTreeHighlightFile('md',         s:purple[1], s:bg0[1], s:purple[0], s:bg0[0])
call NERDTreeHighlightFile('yml',        s:yellow[1], s:bg0[1], s:yellow[0], s:bg0[0])
call NERDTreeHighlightFile('yaml',       s:yellow[1], s:bg0[1], s:yellow[0], s:bg0[0])
call NERDTreeHighlightFile('conf',       s:blue[1],   s:bg0[1], s:blue[0],   s:bg0[0])
call NERDTreeHighlightFile('config',     s:blue[1],   s:bg0[1], s:blue[0],   s:bg0[0])
call NERDTreeHighlightFile('cfg',        s:blue[1],   s:bg0[1], s:blue[0],   s:bg0[0])
call NERDTreeHighlightFile('LICENSE',    s:blue[1],   s:bg0[1], s:blue[0],   s:bg0[0])
call NERDTreeHighlightFile('txt',        s:blue[1],   s:bg0[1], s:blue[0],   s:bg0[0])
call NERDTreeHighlightFile('json',       s:orange[1], s:bg0[1], s:orange[0], s:bg0[0])
call NERDTreeHighlightFile('py',         s:red[1],    s:bg0[1], s:red[0],    s:bg0[0])
call NERDTreeHighlightFile('Dockerfile', s:orange[1], s:bg0[1], s:orange[0], s:bg0[0])
