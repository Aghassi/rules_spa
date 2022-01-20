"""A macro for creating a webpack federation route module"""

load("@aspect_rules_swc//swc:swc.bzl", "swc")

# Defines this as an importable module area for shared macros and configs

def build_route(name, entry, srcs, data, webpack, federation_shared_config):
    """
    Macro that allows easy composition of routes from a multi route spa

    Args:
        name: name of a route (route)
        entry: the entry file to the route
        srcs: source files to be transpiled and bundled
        data: any dependencies the route needs to build
        webpack: the webpack module to invoke. The users must provide their own load statement for webpack before this macro is called
        federation_shared_config: a nodejs module file that exposes a map of dependencies to their shared module spec https://webpack.js.org/plugins/module-federation-plugin/#sharing-hints. An example of this is located within this repository under the private/webpack folder.
    """

    build_name = name + "_route"

    # list of all transpilation targets from SWC to be passed to webpack
    deps = [
        ":transpile_" + files.replace("//", "").replace("/", "_").split(".")[0]
        for files in srcs
    ] + data

    # buildifier: disable=no-effect
    [
        swc(
            name = "transpile_" + s.replace("//", "").replace("/", "_").split(".")[0],
            args = [
                "-C jsc.parser.jsx=true",
                "-C jsc.parser.syntax=typescript",
                "-C jsc.transform.react.runtime=automatic",
                "-C jsc.transform.react.development=false",
                "-C module.type=commonjs",
            ],
            srcs = [s],
        )
        for s in srcs
    ]

    route_config = Label("//spa/private/webpack:webpack.route.config.js")
    webpack(
        name = name,
        args = [
            "--env name=" + build_name,
            "--env entry=./$(execpath :transpile_" + name + ")",
            "--env SHARED_CONFIG=$(location %s)" % federation_shared_config,
            "--env BAZEL_SRC_PATH=$(execpath)",
            "--output-path=$(@D)",
            "--config=$(rootpath %s)" % route_config,
        ],
        data = [
            route_config,
            federation_shared_config,
            Label("//spa/private/webpack:webpack.common.config.js"),
        ] + deps,
        output_dir = True,
        visibility = ["//src/client/routes:__pkg__"],
    )
