const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const webpack = require('webpack');
module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    'app': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js')),
    'custom': ['./js/custom.js'].concat(glob.sync('./vendor/**/*.js')),
    'history': ['./js/history.js'].concat(glob.sync('./vendor/**/*.js')),
    'detail': ['./js/detail.js'].concat(glob.sync('./vendor/**/*.js')),
    'payment': ['./js/payment.js'].concat(glob.sync('./vendor/**/*.js')),
    'promptpay-qr': ['./js/qrcode/promptpay-qr.js'].concat(glob.sync('./vendor/**/*.js')),
    'qrcode': ['./js/qrcode/qrcode.js'].concat(glob.sync('./vendor/**/*.js')),
    'projects': ['./js/projects.js'].concat(glob.sync('./vendor/**/*.js')),
    'success': ['./js/success.js'].concat(glob.sync('./vendor/**/*.js'))
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
      },
      {
        test: /\.woff(2)?(\?[a-z0-9]+)?$/,
        loader: "url-loader?&limit=10000&name=/fonts/[name].[ext]"
      }, {
        test: /\.(ttf|eot|svg)(\?[a-z0-9]+)?$/,
        loader: "file-loader?&limit=10000&name=/fonts/[name].[ext]"
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery"
    }),
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
