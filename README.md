# Image-Url to Model Converter

Fluter tool for extract name, description from the Urls

## Restriction:
Currently its only supports 'peakpx.com'
## Where to start?
- The starting screen just shows input field, convert button and warning message (warning about site restriction)
## Input:
- Paste urls in the follwing format,
  ```
  https://w0.peakpx.com/wallpaper/410/412/HD-wallpaper-plain-black-black-thumbnail.jpg,
  https://w0.peakpx.com/wallpaper/730/501/HD-wallpaper-iphone-14-pro-thumbnail.jpg,
  https://w0.peakpx.com/wallpaper/83/677/HD-wallpaper-don-t-waste-your-time-success-english-quotes-inspirational-motivation-thumbnail.jpg,
  https://w0.peakpx.com/wallpaper/266/1012/HD-wallpaper-street-night-city-neon-road-cars-thumbnail.jpg
  ```
  *Note: url must be ends with comma.

  ## Output:
  ```
  [
      Model(
          id: 1,
          name: 'plain black black',
          description: 'HD-wallpaper plain black black thumbnail',
          imageUrl: ' https://w0.peakpx.com/wallpaper/410/412/HD-wallpaper-plain-black-black-thumbnail.jpg'.
      ),
      Model(
          id: 2,
          name: 'iphone 14 pro',
          description: 'HD wallpaper iphone 14 pro thumbnail.jpg',
          imageUrl: ' https://w0.peakpx.com/wallpaper/730/501/HD-wallpaper-iphone-14-pro-thumbnail.jpg'.
      ),
      Model(
          id: 3,
          name: 'don t waste your time success english quotes inspirational motivation',
          description: 'HD wallpaper don t waste your time success english quotes inspirational motivation thumbnail.jpg',
          imageUrl: 'https://w0.peakpx.com/wallpaper/83/677/HD-wallpaper-don-t-waste-your-time-success-english-quotes-inspirational-motivation-thumbnail.jpg'.
      ),
      Model(
          id: 4,
          name: 'street night city neon road cars',
          description: 'HD wallpaper street night city neon road cars thumbnail',
          imageUrl: 'https://w0.peakpx.com/wallpaper/266/1012/HD-wallpaper-street-night-city-neon-road-cars-thumbnail.jpg'.
      ),
  ]
  ```
## UI Screenshots:
![Mobile View - before conversion](https://github.com/[abin-ps]/[urls-to-model-converter]/blob/[main]/before_conversion_mobile_view_image.jpg?raw=true)

![Mobile View - after conversion](https://github.com/[abin-ps]/[urls-to-model-converter]/blob/[main]/after_conversion_mobile_view_image.jpg?raw=true)


![Web View - before conversion](https://github.com/[abin-ps]/[urls-to-model-converter]/blob/[main]/before_conversion_web_view_image.jpg?raw=true)

![Web View - after conversion](https://github.com/[abin-ps]/[urls-to-model-converter]/blob/[main]/after_conversion_web_view_image.jpg?raw=true)


## Demo

![Web View - Demo](https://github.com/[abin-ps]/[urls-to-model-converter]/blob/[main]/before_conversion_web_view_demo.webm?raw=true)