# {{project-name}}

This actor demonstrates [WASI preview2][wasi-preview2] and [Component Model][cm] support in wasmCloud.
It uses the [WIT][wit]-ified [`wasmcloud/bus` interface][wit-wasmcloud/bus] to respond to requests from a [`httpserver` capability provider][provider-httpserver].

For each incoming request, the actor component will respond with information detailing the request it received -- effectively "echo"ing the request.

[wit]: https://github.com/WebAssembly/component-model/blob/main/design/mvp/WIT.md
[wasi-preview2]: https://github.com/bytecodealliance/wasmtime/issues/6370
[cm]: https://github.com/WebAssembly/component-model/blob/main/design/mvp/Explainer.md
[wit-wasmcloud/bus]: https://github.com/wasmCloud/wasmCloud/blob/main/crates/actor/wit/deps/wasmcloud/bus.wit
[provider-httpserver]: https://github.com/wasmCloud/capability-providers/tree/main/httpserver-rs

## Getting started

### 🏗  Build the signed actor

To build the project:

```console
wash build
```

You should see output similar to the following:

```
Actor built and signed and can be found at "/home/mrman/code/work/cosmonic/forks/project-templates/actor/echo-httpserver-preview2/build/<your actor name>_s.wasm"
```

### 🪪 Get your signed Actor ID

To get the ID of your actor, use `wash inspect` on the signed actor:

```console
wash inspect build/<your actor name>_s.wasm
```

The output should look something like this:

```
                      your-project-name - Module
  Account               XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  Module                YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
  Expires                                                                  never
  Can Be Used                                                        immediately
  Version                                                              0.1.0 (0)
  Call Alias                                                           (Not set)
                                   Capabilities
  HTTP Server
                                       Tags
  None
```

The `YYYYY...` value above is (next to `Module`) is your Actor ID. You'll need this for the next step.

### 👟 Start the actor on wasmCloud

After starting the [wasmCloud 🦀 Rust-powered host][wasmcloud/wasmcloud], use `wash start actor` to start your actor with it's ID:

```console
wash start actor <actor id> --host-id <ID of your rust host>
```

After running `wash start` you should see output like the following:

```
Actor [MA5Z5BFS2HB2NAIZNAG7JOCXVQKXQ2KPS422WI6OMQPTXIJVKGAUJXFN] (ref: [file:///home/mrman/code/work/cosmonic/forks/project-templates/actor/echo-httpserver-preview2/build/<your project>_s.wasm]) started on host [NDXXFJVVCYNUGVOPYUWTJIREYLRVHAYV4AUW46EG2Y2LHMK53SVUZHCC]
```

[wasmcloud/wasmcloud]: https://github.com/wasmCloud/wasmCloud

### ⛓  Start the `httpserver` provider

Start a [`httpserver`][provider-httpserver] provider:

```console
wash start provider wasmcloud.azurecr.io/httpserver:0.17.0
```

### ⛓  Link the actor and provider

Link the actor you built and ran to the `httpserver` provider using the [`wasmcloud:httpserver` contract][httpserver-contract]:

```console
wash link put YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY VAG3QITQQ2ODAOWB5TTQSDJ53XK3SHBEIFNK4AYJ5RKAX2UNSCAPHA5M wasmcloud:httpserver
```

[httpserver-contract]: https://github.com/wasmCloud/interfaces/tree/main/httpserver

### 🌐 Visit the echo server on the web

By default the `httpserver` provider starts a HTTP server at [`localhost:8000`](http://localhost:8000), so go there and check out your running actor!

For example, try visiting [`localhost:8000/?test=value`](http://localhost:8000/?test=value) to see the query parameters change.

## FAQ

Other questions you might have

### How do I customize this template to use other contracts & interfaces?

- You can change what contracts this actor claims in `wasmcloud.toml` and the `Makefile`. In the future this will just be in `wasmcloud.toml`.
- You can modify the `wit` folder and `wit/wit-deps.toml` to ensure the correct WIT contracts are accessible to [`wit-bindgen`][wit-bindgen].
- You can add any required dependencies in `Cargo.toml`
- Finally, modify [`src/lib.rs`](./src/lib.rs), changing/deleting the current implementation as you see fit.

[wit-bindgen]: https://github.com/bytecodealliance/wit-bindgen

### Using the included Github Actions

The generated project include two GitHub actions: `build.yml` and `release.yml` under `.github/workflows`. The build action will automatically build, lint, and check formatting for your actor. The release action will automatically release a new version of your actor whenever code is pushed to `main`, or when you push a tag with the form `vX.Y.Z`.

These actions require 3 secrets

1. `WASH_ISSUER_KEY`, which can be generated with `wash keys gen issuer`, then look for the 58 character `Seed` value
1. `WASH_SUBJECT_KEY`, which can be generated with `wash keys gen module`, then look for the 58 character `Seed` value
1. `WASMCLOUD_PAT`, which can be created by following the [Github PAT instructions](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) and ensuring the `write:packages` permission is enabled
