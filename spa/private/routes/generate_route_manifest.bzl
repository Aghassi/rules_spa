"""A macro that wraps a script to generate an object that maps routes to their entry data"""

load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary", "npm_package_bin")

def generate_route_manifest(name, routes):
    """
    Generates a json file that is a representation of all routes

    Args:
        - name: name of the invocation
        - routes: the sources from the //src/routes rule to be used in the script
    Returns the generated manifest
    """

    nodejs_binary(
        name = "bin",
        data = [
            "@rules_spa//spa/private/routes:generate-route-manifest.js",
        ],
        entry_point = "@rules_spa//spa/private/routes:generate-route-manifest.js",
    )

    npm_package_bin(
        name = "route_manifest",
        tool = ":bin",
        data = [routes],
        args = [
            "$(execpath %s)" % routes,
        ],
        stdout = "route.manifest.json",
        visibility = ["//visibility:public"],
    )
