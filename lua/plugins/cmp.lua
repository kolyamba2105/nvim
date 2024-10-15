return {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            formatting = {
                format = function(_, vim_item)
                    local icon, hl = MiniIcons.get("lsp", vim_item.kind)

                    vim_item.kind = icon .. " " .. vim_item.kind
                    vim_item.kind_hl_group = hl

                    return vim_item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            }),
            sources = {
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
    },
    enabled = false,
    event = { "InsertEnter" },
}
