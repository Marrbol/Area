const { defineConfig } = require('@vue/cli-service')
const Dotenv = require('dotenv-webpack');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    port: 8081 // Change this to your desired port
  },
  configureWebpack: {
    plugins: [new Dotenv()],
  },
});