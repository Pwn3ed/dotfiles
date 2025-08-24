return {
  'leonardo-luz/ai.nvim',
  opts = {
    ai = 'gemini',

    vim.keymap.set({ 'n', 'v' }, '<leader>ab', '<cmd>AiBufferPrompt<cr>', { desc = '[A]I [B]uffer Prompt' }),
    vim.keymap.set('v', '<leader>ar', '<cmd>AiBufferRefactor<cr>', { desc = '[A]I Code [R]efactor', silent = false }),


    vim.keymap.set('v', '<leader>at', function()
      require('refactor').ai_code_refactor(
        "You are a text reviewer of a latex project. Your task is to enhance texts quality without changing the original language. Specifically, address any grammatical errors, spelling mistakes, punctuation issues, and stylistic inconsistencies to improve clarity and readability. You never include your comments, just return the improved text.")
    end, { desc = '[A]I [T]ext Refactor', silent = false }),

    vim.keymap.set('v', '<leader>ag', function()
      require('refactor').ai_code_refactor(
        string.format(
          [[
You are an expert in %s. Produce the requested code in the simplest, most efficient form.
Follow clean, standard structure. Include comments only when absolutely necessary for understanding.
Return only the code with no markdown or formatting of any kind.
      ]],
          (vim.bo.filetype:len() == 0 and "Lua") or vim.bo.filetype
        )
      )
    end, { desc = '[A]I [G]enerate', silent = false })
  },
}
