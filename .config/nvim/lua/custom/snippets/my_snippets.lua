local ls = require 'luasnip'
-- FIX: WIP

-- Helper function to generate random Lorem Ipsum text
local function random_lorem_ipsum(word_count)
  math.randomseed(os.time()) -- Seed the random number generator

  local lorem_words = {
    'Lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'sed',
    'do',
    'eiusmod',
    'tempor',
    'incididunt',
    'ut',
    'labore',
    'et',
    'dolore',
    'magna',
    'aliqua',
    'enim',
    'ad',
    'minim',
    'veniam',
    'quis',
    'nostrud',
    'exercitation',
    'ullamco',
    'laboris',
    'nisi',
    'ut',
    'aliquip',
    'ex',
    'ea',
    'commodo',
    'consequat',
  }
  local lorem_text = {}

  for i = 1, word_count do
    local word = lorem_words[math.random(#lorem_words)] -- Get a random word from the list
    table.insert(lorem_text, word)
  end

  return table.concat(lorem_text, ' ') -- Join words with spaces
end

-- Create a new snippet for generating random lorem ipsum text
ls.snippets = {
  all = {
    ls.parser.parse_snippet('lorem', function()
      return random_lorem_ipsum(10) -- Generates 10 random words (adjust as needed)
    end),
  },
}
