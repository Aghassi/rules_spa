"Public API re-exports"

load("//spa/private/routes:generate_route_manifest.bzl", _generate_route_manifest = "generate_route_manifest")
load("//spa/private:build_routes.bzl", _build_route = "build_route")

generate_route_manifest = _generate_route_manifest
build_route = _build_route
