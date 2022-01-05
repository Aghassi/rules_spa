# Declare the local Bazel workspace.
workspace(
    # If your ruleset is "official"
    # (i.e. is in the bazelbuild GitHub org)
    # then this should just be named "rules_spa"
    # see https://docs.bazel.build/versions/main/skylark/deploying.html#workspace
    name = "com_aghassi_rules_spa",
)

load(":internal_deps.bzl", "rules_spa_internal_deps")

# Fetch deps needed only locally for development
rules_spa_internal_deps()

load("//spa:repositories.bzl", "rules_spa_dependencies", "spa_register_toolchains")

# Fetch dependencies which users need as well
rules_spa_dependencies()

spa_register_toolchains(
    name = "spa1_14",
    spa_version = "1.14.2",
)

# For running our own unit tests
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.2")

gazelle_dependencies()

####
# Rules NodeJS
####
load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")

NODE_VERSION = "16.13.0"

# NOTE: this rule installs nodejs, npm, and yarn, but does NOT install
# your npm dependencies into your node_modules folder.
# You must still run the package manager to do this.
node_repositories(
    node_version = NODE_VERSION,
    package_json = ["//:package.json"],
)