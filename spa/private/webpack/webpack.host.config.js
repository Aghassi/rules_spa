const ModuleFederationPlugin =
  require("webpack").container.ModuleFederationPlugin;
const generateWebpackCommonConfig = require("./webpack.common.config");
const path = require("path");

/**
 * Webpack configuration used to generate a unique route
 *
 * @param {Record<string, boolean|string}
 * @returns {import('webpack').Configuration} a Webpack configuration
 */
module.exports = ({ entry, production, SHARED_CONFIG }) => {
  const commonConfig = generateWebpackCommonConfig({ production });
  // This must be required by the end user for now
  const shared = require(path.resolve(`${SHARED_CONFIG}`));

  return {
    entry,
    ...commonConfig,
    output: {
      ...commonConfig.output,
      filename: production ? `app.[name].[contenthash].js` : `app.[name].js`,
    },
    plugins: [
      ...commonConfig.plugins,
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
