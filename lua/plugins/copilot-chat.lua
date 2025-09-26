return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = false,
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken',
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
      { '<leader>cx', '<cmd>CopilotChatClose<cr>', desc = 'Close Copilot Chat' },
      {
        '<leader>cs',
        function()
          require('CopilotChat').save_chat()
        end,
        desc = 'Save Copilot Chat',
      },
      {
        '<leader>ch',
        function()
          require('CopilotChat').load_chat_history()
        end,
        desc = 'Browse Chat History',
      },
    },
    init = function()
      -- Define additional functions
      local chat_module = require('CopilotChat')

      ---@diagnostic disable: inject-field
      -- Function to save chat with a custom name
      function chat_module.save_chat()
        -- Check if chat window is visible
        local chat_visible = chat_module.chat and chat_module.chat:visible()

        if not chat_visible then
          vim.notify('No active chat to save. Please open a chat first with <leader>cc', vim.log.levels.WARN)
          return
        end

        vim.ui.input({ prompt = 'Save chat as: ' }, function(name)
          if name and name ~= '' then
            vim.cmd('CopilotChatSave ' .. vim.fn.shellescape(name))
          end
        end)
      end

      -- Function to load chat history with interactive selection
      function chat_module.load_chat_history()
        local history_path = vim.fn.stdpath('data') .. '/copilotchat_history'
        local scan = require('plenary.scandir')
        local files = scan.scan_dir(history_path, { depth = 1, only_files = true })

        if #files == 0 then
          vim.notify('No saved chat histories found', vim.log.levels.WARN)
          return
        end

        -- Extract just the filenames without path and extension
        local choices = {}
        for _, file in ipairs(files) do
          local name = vim.fn.fnamemodify(file, ':t:r')
          table.insert(choices, name)
        end

        vim.ui.select(choices, { prompt = 'Select chat history:' }, function(choice)
          if choice then
            vim.cmd('CopilotChatLoad ' .. choice)
          end
        end)
      end
    end,
    opts = {
      sticky = { '#files:**/*', '#buffer', '$claude-3.7-sonnet-thought' },
      mappings = {
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        submit_prompt = {
          normal = '<C-j>',
          insert = '<C-j>',
        },
      },
    },
  },
}
