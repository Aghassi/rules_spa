"""A macro for building the server bundle that will end up in a nodejs docker image"""

load("@build_bazel_rules_nodejs//:index.bzl", "js_library")
load("@aspect_rules_swc//swc:swc.bzl", "swc")

# Defines this as an importable module area for shared macros and configs

def build_server(name, srcs, data, **kwargs):
    """
    Macro that construct the http server for the project

    Args:
        name: name of the package
        srcs: source files from the package
        data: any dependencies needed to build
        **kwargs: any other inputs to js_library
    """

    # list of all transpilation targets from SWC to be passed to webpack
    deps = [
        ":transpile_" + files.replace("//", "").replace("/", "_").split(".")[0]
        for files in srcs
    ]

    # buildifier: disable=no-effect
    [
        swc(
            name = "transpile_" + s.replace("//", "").replace("/", "_").split(".")[0],
            args = [
                "-C jsc.parser.jsx=true",
                "-C jsc.parser.syntax=typescript",
                "-C jsc.target=es2015",
                "-C module.type=commonjs",
            ],
            srcs = [s],
        )
        for s in srcs
    ]

    js_library(
        name = name,
        srcs = deps + data,
        **kwargs
    )
