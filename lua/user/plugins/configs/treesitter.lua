local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

local parsers = {
	"bash",
	"bibtex",
	"c",
	"cmake",
	"comment",
	"cpp",
	"css",
	"diff",
	"dockerfile",
	"fennel",
	"fish",
	"go",
	"graphql",
	"html",
	"http",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"latex",
	"lua",
	"make",
	"ninja",
	"nix",
	"norg",
	"org",
	"perl",
	"php",
	"python",
	"r",
	"rasi",
	"regex",
	"ruby",
	"rust",
	"scss",
	"tsx",
	"typescript",
	"vim",
	"vue",
	"xml",
	"yaml",
	"zig",
}

require("nvim-treesitter.parsers").list.xml = {
	install_info = {
		url = "https://github.com/Trivernis/tree-sitter-xml",
		files = { "src/parser.c" },
		generate_requires_npm = true,
		branch = "main",
	},
	filetype = "xml",
}

configs.setup {
    autotag = {
        enable = true,
        filetypes = { "html" , "xml" }
    },
    enable = true,
    context_commentstring = { enable = true },
    -- https://github.com/nvim-treesitter/nvim-treesitter-refactor#highlight-definitions
    refactor = {
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {["<leader>xp"] = "@parameter.inner"},
            swap_previous = {["<leader>xP"] = "@parameter.inner"}
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>pf"] = "@function.outer",
                ["<leader>pc"] = "@class.outer"
            }
        },
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        }
    },
    ensure_installed = parsers , -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = true,
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    }
}
