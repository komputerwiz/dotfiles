require 'imlib2'

function conky_weather_icon(file,r,x,y)

   if conky_window == nil then return end

   image = imlib_load_image(file)
   if image == nil then return end
   imlib_context_set_image(image)

   if r == "1" then
      x = conky_window.width - imlib_image_get_width() - x
   end
   imlib_render_image_on_drawable(x,y)
   imlib_free_image()

   return ""

end
