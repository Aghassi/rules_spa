# Bazel rules for a SPA (single page architecture)

A set of macros and rules to support building a **S**ingle **P**age **A**rchitecture (SPA) with Bazel + Webpack Module Federation

**Please be advised this rule set is in very preliminary development and may break at anytime between changes.**

_NOTE:_ This rule set depends on `webpack` (v5+) and `react-dev-utils` via installation of `npm` with `rules_nodejs`. This currently is not encoded into the Bazel graph, so be sure to bring your own versions.

## Installation

From the release you wish to use:
<https://github.com/aghassi/rules_spa/releases>
copy the WORKSPACE snippet into your `WORKSPACE` file.

## Releasing

Create a new tag release in the GitHub UI and allow the CI to update it with the appropriate release notes for users to consume
