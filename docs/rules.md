<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#build_route"></a>

## build_route

<pre>
build_route(<a href="#build_route-name">name</a>, <a href="#build_route-entry">entry</a>, <a href="#build_route-data">data</a>, <a href="#build_route-webpack">webpack</a>, <a href="#build_route-shared">shared</a>)
</pre>

    Macro that allows easy composition of routes from a multi route spa

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="build_route-name"></a>name |  name of a route (route)   |  none |
| <a id="build_route-entry"></a>entry |  the entry file to the route   |  none |
| <a id="build_route-data"></a>data |  any dependencies the route needs to build   |  none |
| <a id="build_route-webpack"></a>webpack |  the webpack module to invoke. The users must provide their own load statement for webpack before this macro is called   |  none |
| <a id="build_route-shared"></a>shared |  a nodejs module file that exposes a map of dependencies to their shared module spec https://webpack.js.org/plugins/module-federation-plugin/#sharing-hints. An example of this is located within this repository under the private/webpack folder.   |  none |


<a id="#generate_route_manifest"></a>

## generate_route_manifest

<pre>
generate_route_manifest(<a href="#generate_route_manifest-name">name</a>, <a href="#generate_route_manifest-routes">routes</a>)
</pre>

Generates a json file that is a representation of all routes.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="generate_route_manifest-name"></a>name |  name of the invocation   |  none |
| <a id="generate_route_manifest-routes"></a>routes |  the sources from the //src/routes rule to be used in the script   |  none |

**RETURNS**

the generated manifest


