require 'colorizer'.setup ({
  -- highlight colors of all filetypes
  '*';
  -- but exclude vim and lua filetypes
  '!vim';
  '!lua';
  -- enable parsing rgb(...) functions in css
  css = { rgb_fn = true; };
}, {
  -- enable RGBA for all
  RRGGBBAA = true;
})
