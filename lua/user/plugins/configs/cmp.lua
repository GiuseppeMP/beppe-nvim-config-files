-- Set up nvim-cmp.
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end
vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "snippets/ultisnips" }
vim.g.UltiSnipsExpandTrigger = "<tab>"

require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/vscode" })
require("luasnip.loaders.from_vscode").lazy_load()


local lspkind = require 'lspkind'

local function get_snippet()
    return {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    }
end

local has_words_before = function()
    -- unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function get_mapping()
    -- default behavior
    local cr = cmp.mapping.confirm({ select = false })

    -- copilot behavior
    if conf.user.copilot.enabled then
        cr = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        })
    end

    return cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cr,
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "v", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "v", "s" }),
    })
end

local function get_sources()
    local snip_sources = {
        { name = "copilot",  group_index = 2 }, -- For copilot users
        { name = 'nvim_lsp' },                  -- For nvim lsp users
        { name = 'vsnip' },                     -- For vsnip users.
        { name = 'luasnip' },                   -- For luasnip users.
        { name = 'ultisnips' },                 -- For ultisnips users.
        { name = 'snippy' },                    -- For snippy users.
    }

    local other_sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'lsp' },
    }

    if conf.user.copilot.enabled then
        table.insert(snip_sources, { name = 'copilot', group_index = 2 })
    end

    return cmp.config.sources(snip_sources, other_sources)
end



local function get_format()
    return {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            symbol_map = { Copilot = "" },
            mode = 'symbol',       -- show only symbol annotations
            max_width = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        }),
    }
end

local function get_sorting()
    local comparators = {
        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    }

    if conf.user.copilot.enabled then
        table.insert(comparators, require("copilot_cmp.comparators").prioritize)
    end


    return {
        priority_weight = 2,
        comparators = comparators
    }
end


local function get_confirm_opts()
    local opts = {
        select = true,
    }
    if conf.user.copilot.enabled then
        opts.behavior = cmp.ConfirmBehavior.Replace
    end
    return opts
end


cmp.setup({
    snippet = get_snippet(),
    mapping = get_mapping(),
    sources = get_sources(),
    formatting = get_format(),
    sorting = get_sorting(),
    confirm_opts = get_confirm_opts(),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})
