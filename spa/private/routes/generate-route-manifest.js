const fs = require("fs");
const path = require("path");

// Create the object to represent the manifest
const manifest = {
  "/": "index.sha.js",
};

const getDirectories = (source) =>
  fs
    .readdirSync(source, { withFileTypes: true })
    .filter((dirent) => dirent.isDirectory())
    .map((dirent) => dirent.name);
const getFilesInDirectory = (source) =>
  fs
    .readdirSync(source, { withFileTypes: true })
    .filter((dirent) => dirent.isFile())
    .map((dirent) => dirent.name);

const outputRoutesBase = process.argv[2];

const routeDirs = getDirectories(outputRoutesBase);

// For each folder we read, check what it is and
// determine the route mapping
routeDirs.forEach((dir) => {
  const remoteEntry = getFilesInDirectory(`${outputRoutesBase}/${dir}`).filter(
    (file) => !file.endsWith(".map") && file.startsWith("remote")
  );

  switch (dir) {
    case "default":
      manifest["/"] = `${remoteEntry}`;
      break;
    default:
      manifest[`${dir}`] = `${remoteEntry}`;
      break;
  }
});

// Finally write out the manifest
process.stdout.write(JSON.stringify(manifest, null, 2));
