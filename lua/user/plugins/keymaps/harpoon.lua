local kutils = require "user.keymaps._utils"
local n = kutils.n

-- Primeagen/harpoon keybinds
n("mm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
n("ma", ":lua require('harpoon.mark').add_file()<CR>")
--
n("<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
n("<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
n("<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
n("<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
--
n("<Leader>ht1", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
n("<Leader>ht2", ":lua require('harpoon.term').gotoTerminal(2)<CR>")
n("<Leader>ht3", ":lua require('harpoon.term').gotoTerminal(3)<CR>")
n("<Leader>ht4", ":lua require('harpoon.term').gotoTerminal(4)<CR>")
n("<C-t>", ":lua require('harpoon.term').gotoTerminal(0)<CR>")
