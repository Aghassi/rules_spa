const ModuleFederationPlugin =
  require("webpack").container.ModuleFederationPlugin;
const generateWebpackCommonConfig = require("./webpack.common.config");
const path = require("path");

/**
 * Webpack configuration used to generate a unique road
 *
 * @param {Record<string, boolean|string}
 * @returns {import('webpack').Configuration} a Webpack configuration
 */
module.exports = ({
  entry,
  production,
  name,
  SHARED_CONFIG,
  BAZEL_SRC_PATH,
}) => {
  const commonConfig = generateWebpackCommonConfig({
    production,
    BAZEL_SRC_PATH,
  });
  // This must be required by the end user for now
  const shared = require(path.resolve(`${SHARED_CONFIG}`));

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
