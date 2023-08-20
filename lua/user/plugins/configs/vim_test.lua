local g = vim.g

g.ultest_use_pty = 1

g['test#strategy'] = {
    nearest = 'neovim',
    file = 'neovim',
    suite = 'neovim',
}


vim.cmd [[ command! -nargs=* -bar DebugTestNearest call test#run('debug_nearest', split(<q-args>)) ]]

vim.cmd [[ command! -nargs=* -bar DebugTestFile call test#run('debug_file', split(<q-args>)) ]]
