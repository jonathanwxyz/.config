--[[ require("gitsigns").setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, {expr=true})

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, {expr=true})

    -- Actions
    map({"n", "v"}, "<leader>gs", ":Gitsigns stage_hunk<CR>", {desc = "Git Stage Hunk"})
    map({"n", "v"}, "<leader>gr", ":Gitsigns reset_hunk<CR>", {desc = "Git Reset Hunk"})
    map("n", "<leader>gS", gs.stage_buffer, {desc = "Git Stage Buffer"})
    map("n", "<leader>gu", gs.undo_stage_hunk, {desc = "Git Undo Stage Hunk"})
    map("n", "<leader>gR", gs.reset_buffer, {desc = "Git Reset Buffer"})
    map("n", "<leader>gp", gs.preview_hunk, {desc = "Git Preview Hunk"})
    map("n", "<leader>gb", function() gs.blame_line{full=true} end, {desc = "Git Blame Line"})
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>gd", gs.diffthis, {desc = "Git Diff"})
    map("n", "<leader>gD", function() gs.diffthis("~") end, {desc = "Git Diff ~"})
    map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
} ]]
