-- Fixes focus loss problems on macOS
-- wrapping in vim.cmd()
-- vim.cd() Executes Vim Script commands
vim.cmd([[
function! s:TexFocusVim() abort
    silent execute "!open -a iTerm"
    redraw!
endfunction

augroup vimtex_event_focus
    au!
    au User VimTexEventViewReverse call s:TexFocusVim()
augroup END
]])

-- Viewer method, upon compilation
vim.g.vimtex_view_method = "skim"

-- View Option
vim.g.vimtex_view_general_viewer = "skim"
vim.g.vimtex_view_general_options = "--unique"

-- Determine to automatically open PDF viewer after compilation
vim.g.vimtex_view_automatic = 1

-- Most VimTex mappings rely on localleader and this can be changed
-- with the following line:
vim.g.maplocalleader = ","

-- Keymappings for VimTeX

-- Trigger VimTexView
-- nmap <localleader>v <plug>(vimtex-view)
vim.api.nvim_set_keymap("n", "<localleader>v", "<plug>(vimtex-view)", { noremap = true })
