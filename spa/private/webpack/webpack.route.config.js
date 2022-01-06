const ModuleFederationPlugin =
  require("webpack").container.ModuleFederationPlugin;
const generateWebpackCommonConfig = require("./webpack.common.config");
const shared = require("./webpack.module-federation.shared");

/**
 * Webpack configuration used to generate a unique road
 *
 * @param {Record<string, boolean|string}
 * @returns {import('webpack').Configuration} a Webpack configuration
 */
module.exports = ({ entry, production, name }) => {
  const commonConfig = generateWebpackCommonConfig({ production });

  return {
    entry,
    ...commonConfig,
    output: {
      ...commonConfig.output,
      filename: production
        ? `${name}.[name].[contenthash].js`
        : `${name}.[name].js`,
    },
    plugins: [
      new ModuleFederationPlugin({
        name,
        filename: "remoteEntry.[contenthash].js",
        exposes: {
          "./route": entry,
        },
        shared,
      }),
    ],
  };
};
