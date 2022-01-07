<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#build_host"></a>

## build_host

<pre>
build_host(<a href="#build_host-entry">entry</a>, <a href="#build_host-data">data</a>, <a href="#build_host-srcs">srcs</a>, <a href="#build_host-webpack">webpack</a>, <a href="#build_host-shared">shared</a>)
</pre>

    Macro that allows easy building of the main host of a SPA

In addition to the usage of this macro, you will be required to pass in all required node_modules
for compilation as well as anything the shared config relies on (most likely your package.json) into data


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="build_host-entry"></a>entry |  the entry file to the route   |  none |
| <a id="build_host-data"></a>data |  any dependencies the route needs to build including npm modules   |  none |
| <a id="build_host-srcs"></a>srcs |  srcs files to be transpiled and sent to webpack   |  none |
| <a id="build_host-webpack"></a>webpack |  the webpack module to invoke. The users must provide their own load statement for webpack before this macro is called   |  none |
| <a id="build_host-shared"></a>shared |  a nodejs module file that exposes a map of dependencies to their shared module spec https://webpack.js.org/plugins/module-federation-plugin/#sharing-hints. An example of this is located within this repository under the private/webpack folder.   |  none |


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


<a id="#build_server"></a>

## build_server

<pre>
build_server(<a href="#build_server-name">name</a>, <a href="#build_server-srcs">srcs</a>, <a href="#build_server-data">data</a>, <a href="#build_server-kwargs">kwargs</a>)
</pre>

    Macro that construct the http server for the project

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="build_server-name"></a>name |  name of the package   |  none |
| <a id="build_server-srcs"></a>srcs |  source files from the package   |  none |
| <a id="build_server-data"></a>data |  any dependencies needed to build   |  none |
| <a id="build_server-kwargs"></a>kwargs |  any other inputs to js_library   |  none |


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


