"""A macro for creating a webpack federation host module"""

load("@npm//webpack:index.bzl", "webpack")
load("@aspect_rules_swc//swc:swc.bzl", "swc")
load("@build_bazel_rules_nodejs//:index.bzl", "pkg_web")

# Defines this as an importable module area for shared macros and configs

def build_host(entry, data, srcs):
    """
    Macro that allows easy building of the main host of a SPA

    Args:
        entry: the entry file to the route
        data: any dependencies the route needs to build including npm modules
        srcs: srcs files to be transpiled and sent to webpack
    """

    # list of all transpilation targets from SWC to be passed to webpack
    deps = [
        ":transpile_" + files.replace("//", "").replace("/", "_").split(".")[0]
        for files in srcs
    ] + data

    # buildifier: disable=no-effect
    [
        swc(
            name = "transpile_" + s.replace("/", "_").split(".")[0],
            args = [
                "-C jsc.parser.jsx=true",
            ],
            srcs = [s],
        )
        for s in srcs
    ]

    host_config = Label("//spa/webpack:webpack.host.config.js")
    webpack(
        name = "host_build",
        args = [
            "--env name=host",
            "--env entry=./$(location :transpile_host)",
            "--output-path=$(@D)",
            "--config=$(rootpath %s)" % host_config,
        ],
        data = [
            Label("//spa/webpack:webpack.host.config.js"),
            Label("//spa/webpack:webpack.common.config.js"),
        ] + deps,
        output_dir = True,
    )

    pkg_web(
        name = "host",
        srcs = [
            ":host_build",
        ],
        additional_root_paths = ["%s/host_build" % native.package_name()],
        visibility = ["//visibility:public"],
    )
