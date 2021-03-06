const { environment } = require('@rails/webpacker')
const webpack = require('webpack') 
environment.plugins.append('Provide', 
  new webpack.ProvidePlugin({ 
    $: 'jquery', 
    jQuery: 'jquery', 
    Popper: ['popper.js', 'default'] 
  }) 
) 

  const sassLoader = environment.loaders.get('sass');
  // using dart-sass
  const sassLoaderConfig = sassLoader.use.find(function(element) {
    return element.loader === 'sass-loader';
  });
  sassLoaderConfig.options.implementation = require('sass');
module.exports = environment
