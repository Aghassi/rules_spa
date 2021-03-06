"""Our "development" dependencies

Users should *not* need to install these. If users see a load()
statement from these, that's a bug in our distribution.
"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def rules_spa_internal_deps():
    "Fetch deps needed for local development"
    maybe(
        http_archive,
        name = "build_bazel_integration_testing",
        urls = [
            "https://github.com/bazelbuild/bazel-integration-testing/archive/165440b2dbda885f8d1ccb8d0f417e6cf8c54f17.zip",
        ],
        strip_prefix = "bazel-integration-testing-165440b2dbda885f8d1ccb8d0f417e6cf8c54f17",
        sha256 = "2401b1369ef44cc42f91dc94443ef491208dbd06da1e1e10b702d8c189f098e3",
    )

    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
        ],
    )

    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        ],
    )

    # Override bazel_skylib distribution to fetch sources instead
    # so that the gazelle extension is included
    # see https://github.com/bazelbuild/bazel-skylib/issues/250
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "07b4117379dde7ab382345c3b0f5edfc6b7cff6c93756eac63da121e0bbcc5de",
        strip_prefix = "bazel-skylib-1.1.1",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/archive/1.1.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/archive/1.1.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "io_bazel_stardoc",
        sha256 = "c9794dcc8026a30ff67cf7cf91ebe245ca294b20b071845d12c192afe243ad72",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
            "https://github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "aspect_bazel_lib",
        sha256 = "8c8cf0554376746e2451de85c4a7670cc8d7400c1f091574c1c1ed2a65021a4c",
        url = "https://github.com/aspect-build/bazel-lib/releases/download/v0.2.6/bazel_lib-0.2.6.tar.gz",
    )

    # The minimal version of rules_nodejs we need
    maybe(
        http_archive,
        name = "build_bazel_rules_nodejs",
        sha256 = "ddb78717b802f8dd5d4c01c340ecdc007c8ced5c1df7db421d0df3d642ea0580",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.6.0/rules_nodejs-4.6.0.tar.gz"],
    )

    # The minimal version of rules_swc that we need
    maybe(
        http_archive,
        name = "aspect_rules_swc",
        sha256 = "67d6020374627f60c6c1e5d5e1690fcdc4fa39952de8a727d3aabe265ca843be",
        strip_prefix = "rules_swc-0.1.0",
        url = "https://github.com/aspect-build/rules_swc/archive/v0.1.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_nodejs",
        sha256 = "005c59bf299d15d1d9551f12f880b1a8967fa883654c897907a667cdbb77c7a6",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.6.0/rules_nodejs-core-4.6.0.tar.gz"],
    )

    # rules_js is needed for rules_swc
    maybe(
        http_archive,
        name = "aspect_rules_js",
        sha256 = "dd78b4911b7c2e6c6e919b85cd31572cc15e5baa62b9e7354d8a1065c67136e3",
        strip_prefix = "rules_js-0.3.1",
        url = "https://github.com/aspect-build/rules_js/archive/v0.3.1.tar.gz",
    )

    # Rules Docker requirements
    maybe(
        http_archive,
        name = "io_bazel_rules_docker",
        sha256 = "92779d3445e7bdc79b961030b996cb0c91820ade7ffa7edca69273f404b085d5",
        strip_prefix = "rules_docker-0.20.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.20.0/rules_docker-v0.20.0.tar.gz"],
    )

    # Required to offer local dev with ibazel
    maybe(
        git_repository,
        name = "com_github_ash2k_bazel_tools",
        commit = "4daedde3ec61a03db841c8a9ca68288972e25a82",
        remote = "https://github.com/ash2k/bazel-tools.git",
    )
