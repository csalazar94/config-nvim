return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
  },
  opts = {
    workspaces = {
      {
        name = "second-brain",
        path = "/Users/csalazar/Library/CloudStorage/GoogleDrive-camilosalazar94@gmail.com/My Drive/vaults/second-brain/",
      },
    },
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return os.date("%Y%m%d%H%M") .. "-" .. suffix
    end,
    notes_subdir = "inbox",
    daily_notes = {
      folder = "inbox/dailies",
    },
    new_notes_location = "notes_subdir",
    follow_url_func = function(url)
      if jit then
        if jit.os == "OSX" then
          vim.fn.jobstart({ "open", url }) -- Mac OS
        end
        if jit.os == "Windows" then
          vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        end
        if jit.os == "Linux" then
          vim.fn.jobstart({ "xdg-open", url }) -- linux
        end
      end
    end,
  },

}
