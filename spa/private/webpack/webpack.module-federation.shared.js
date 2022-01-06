// TODO: have this be generated based on a list of dependencies or a file provided
// by the end user
const deps = require("../../../../package.json").dependencies;
module.exports = {
  ...deps,
  "react-router-dom": {
    singleton: true,
    eager: false,
  },
  "react-dom": {
    singleton: true,
    eager: false,
  },
  react: {
    singleton: true,
    eager: false,
  },
};
