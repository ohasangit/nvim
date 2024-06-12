return {
  "robitx/gp.nvim",
  keys = {
    { '<leader>hn', '<cmd>GpChatNew<CR>',    desc = 'Chat New' },
    { '<leader>ht', '<cmd>GpChatToggle<CR>', desc = 'Chat Toggle' },
    { '<leader>hf', '<cmd>GpChatFinder<CR>', desc = 'Chat Finder' },
  },
  config = function()
    require('gp').setup(
      {
        openai_api_key = { "cat", vim.fn.stdpath('config') .. '/open-api-key.txt' },
        agents = {
          {
            name = "ChatGPT3-5",
            chat = false,
            command = false,
          },
          {
            name = "ChatGPT4",
            chat = false,
            command = false,
            model = { model = "gpt-4-turbo", temperature = 1.0, top_p = 1 },
            system_prompt =
            "Be concise. If asked for code, only output code without any accompanying text unless asked to do so.",
          },
          {
            name = "ChatGPT4-Omni",
            chat = true,
            command = true,
            model = { model = "gpt-4o", temperature = 1.0, top_p = 1 },
            system_prompt =
            "Be concise. If asked for code, only output code without any accompanying text unless asked to do so.",
          }
        },
        hooks = {
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please respond by writing unit tests for the code above. Only return code."
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
          end,
        }
      }
    )
  end,
}
