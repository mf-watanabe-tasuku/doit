const path = require('path');
const { VueLoaderPlugin } = require("vue-loader");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: './frontend/packs/main.js',
  output: {
    path: path.resolve(__dirname, 'public'),
    filename: 'js/[name].[contenthash].js',
    chunkFilename: 'js/[name].[contenthash].js'
  },
  optimization: {
    splitChunks: {
      cacheGroups: {
        vendor: {
          chunks: 'initial',
          test: /node_modules/,
          name: 'vendor'
        }
      }
    }
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: "vue-loader"
      },
      {
        enforce: 'pre',
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'eslint-loader',
        options: {
          fix: true
        }
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: [
          'css-loader'
        ]
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.(jpe?g|gif|png|svg|ico)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[contenthash].[ext]',
              outputPath: 'images',
              publicPath: '/images',
              esModule: false
            },
          },
          'image-webpack-loader',
        ],
      },
      {
        test: /\.html$/,
        loader: 'html-loader',
      },
    ]
  },
  plugins: [
    new VueLoaderPlugin(),
    new CleanWebpackPlugin({
      cleanOnceBeforeBuildPatterns: ["css", "js", "!uploads/**/*", "!/icons/**/*", "!/common/**/*"]
    }),
    new HtmlWebpackPlugin({
      template: './frontend/html/index.html'
    }),
    new MiniCssExtractPlugin({
      filename: 'css/[name].[contenthash].css',
    })
  ],
  resolve: {
    alias: {
      vue$: "vue/dist/vue.esm.js"
    },
    extensions: ['.js', '.vue']
  }
};