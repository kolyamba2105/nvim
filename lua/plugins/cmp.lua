return {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")
        local snip = require("luasnip")

        cmp.setup({
            formatting = {
                format = function(entry, vim_item)
                    local source_names = {
                        buffer = "[Buffer]",
                        luasnip = "[Snippet]",
                        nvim_lsp = "[LSP]",
                        nvim_lsp_signature_help = "[LSP]",
                    }
                    vim_item.menu = source_names[entry.source.name]

                    return vim_item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
            }),
            sources = {
                { name = "luasnip" },
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            },
            snippet = {
                expand = function(args) snip.lsp_expand(args.body) end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
    },
    event = { "InsertEnter" },
}
