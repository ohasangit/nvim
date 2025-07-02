return {
  'martineausimon/nvim-lilypond-suite',
  config = function()
    require('nvls').setup({
      lilypond = {
        mappings = {
          player = "<C-1>"
        }
      }
    })
  end
}
