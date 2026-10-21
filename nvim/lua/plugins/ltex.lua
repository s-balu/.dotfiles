local conf = vim.g.spell_conf

local function read_dict(path)
  local words = {}
  local f = io.open(vim.fn.expand(path), "r")
  if not f then
    vim.notify("spell dict not found: " .. path, vim.log.levels.WARN)
    return words
  end
  for line in f:lines() do
    local word = line:gsub("/.*$", ""):gsub("^%s*(.-)%s*$", "%1")
    if word ~= "" and not word:match("^#") then
      table.insert(words, word)
    end
  end
  f:close()
  return words
end

local words = read_dict(conf.dict)

local dictionary, disabled_rules, hidden_fp = {}, {}, {}
for _, lang in ipairs(conf.ltex_langs) do
  dictionary[lang] = words
  disabled_rules[lang] = { "OXFORD_SPELLING_Z_NOT_S" }
  hidden_fp[lang] = {}
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex_plus = {
          filetypes = { "tex", "plaintex", "bib", "markdown" },
          settings = {
            ltex = {
              language = conf.ltex_langs[1],
              checkFrequency = "save",
              dictionary = dictionary,
              disabledRules = disabled_rules,
              hiddenFalsePositives = hidden_fp,
              additionalRules = { enablePickyRules = true },
              latex = {
                commands = {
                  ["\\citep{}"] = "dummy",
                  ["\\citet{}"] = "dummy",
                  ["\\citealt{}"] = "dummy",
                  ["\\autoref{}"] = "dummy",
                  ["\\SI{}{}"] = "dummy",
                  ["\\si{}"] = "dummy",
                  ["\\code{}"] = "dummy",
                },
                environments = {
                  equation = "ignore",
                  align = "ignore",
                  lstlisting = "ignore",
                  verbatim = "ignore",
                },
              },
            },
          },
        },
      },
    },
  },
}
