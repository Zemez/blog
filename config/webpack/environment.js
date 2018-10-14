const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// const bootstrap = require('bootstrap')

/* Automatically load modules instead of having to import or require them everywhere. */
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment

/* To use jQuery in views */
// environment.loaders.append('expose', {
//   test: require.resolve('jquery'),
//   use: [{
//     loader: 'expose-loader',
//     options: '$'
//   }]
// })
