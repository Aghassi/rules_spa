"""A macro for creating a webpack federation host module"""

load("@aspect_rules_swc//swc:swc.bzl", "swc")
load("@build_bazel_rules_nodejs//:index.bzl", "pkg_web")

# Defines this as an importable module area for shared macros and configs
def build_host(entry, data, srcs, webpack, shared):
    """
    Macro that allows easy building of the main host of a SPA

    In addition to the usage of this macro, you will be required to pass in all required node_modules
    for compilation as well as anything the shared config relies on (most likely your package.json) into data

    Args:
        entry: the entry file to the route
        data: any dependencies the route needs to build including npm modules
        srcs: srcs files to be transpiled and sent to webpack
        webpack: the webpack module to invoke. The users must provide their own load statement for webpack before this macro is called
        shared: a nodejs module file that exposes a map of dependencies to their shared module spec https://webpack.js.org/plugins/module-federation-plugin/#sharing-hints. An example of this is located within this repository under the private/webpack folder.
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

    host_config = Label("//spa/private/webpack:webpack.host.config.js")
    webpack(
        name = "host_build",
        args = [
            "--env name=host",
            "--env entry=./$(location :transpile_host)",
            "--env SHARED_CONFIG=$(location %s)" % shared,
            "--output-path=$(@D)",
            "--config=$(rootpath %s)" % host_config,
        ],
        data = [
            host_config,
            shared,
            Label("//spa/private/webpack:webpack.common.config.js"),
            Label("//spa/private/webpack:webpack.module-federation.shared.js"),
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
