return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*", -- attiva per tutti i file
    }, {
      RGB = true, -- #RGB
      RRGGBB = true, -- #RRGGBB
      names = true, -- nomi dei colori tipo "Blue"
      RRGGBBAA = true, -- #RRGGBBAA
      rgb_fn = true, -- rgb() e rgba()
      hsl_fn = true, -- hsl() e hsla()
      css = true, -- tutte le sintassi CSS
      css_fn = true, -- funzioni CSS tipo rgb(), hsl(), ecc.
    })
  end,
}
