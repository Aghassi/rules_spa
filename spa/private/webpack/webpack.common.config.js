const ModuleScopePlugin = require("react-dev-utils/ModuleScopePlugin");

module.exports = ({ production, BAZEL_SRC_PATH }) => {
  return {
    cache: false,

    mode: production ? "production" : "development",
    devtool: "source-map",

    optimization: {
      minimize: false,
    },

    output: {
      filename: production ? "[name].[contenthash].js" : "[name].js",
      publicPath: "auto",
      // crossOriginLoading: "anonymous",
    },

    resolve: {
      extensions: [".jsx", ".js"],
      fallback: {
        // In the browser, let `path` be an empty module
        path: false,
      },
    },
    plugins: [new ModuleScopePlugin(BAZEL_SRC_PATH)],
  };
};
