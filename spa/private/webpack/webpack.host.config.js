const ModuleFederationPlugin =
  require("webpack").container.ModuleFederationPlugin;
const generateWebpackCommonConfig = require("./webpack.common.config");
const shared = require("./webpack.module-federation.shared");

/**
 * Webpack configuration used to generate a unique route
 *
 * @param {Record<string, boolean|string}
 * @returns {import('webpack').Configuration} a Webpack configuration
 */
module.exports = ({ entry, production }) => {
  const commonConfig = generateWebpackCommonConfig({ production });

  return {
    entry,
    ...commonConfig,
    output: {
      ...commonConfig.output,
      filename: production ? `app.[name].[contenthash].js` : `app.[name].js`,
    },
    plugins: [
      new ModuleFederationPlugin({
        name: "app",
        filename: "appEntry.js",
        library: { type: "var", name: "app" },
        remotes: {},
        shared,
      }),
    ],
  };
};
