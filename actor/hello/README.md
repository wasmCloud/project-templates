# {{ project-name }} Actor

This actor makes use of a single capability, `wasmcloud:httpserver`, in order to receive HTTP requests and respond with the classic "Hello, World!".

## The implementation

To respond to http requests, the actor must implement the
`HttpResponse` method of the
[HttpServer interface](https://github.com/wasmCloud/interfaces/tree/main/httpserver) interface.

The implementation is in the file [src/lib.rs](./src/lib.rs)

## See it in action

- To compile the actor and generate a signed Webassembly module, type `wash build`.
- Run the wasmCloud host with `wash up`
- In your browser at `localhost:4000`, in the **Actors** table, use the dropdown to start the actor **From File** and select the built and signed module from step 1
- Start the HTTP server provider **From Registry** with OCI reference `wasmcloud.azurecr.io/httpserver:0.17.0`
- Link your hello actor to the HTTP server provider with a link value of `address=0.0.0.0:8080`
- `curl localhost:8080` to see your response, or follow the browser instructions below

### In a browser

Visit the url "http://localhost:8000" to see your response in the browser.

## How do I customize this template to use other contracts & interfaces?

- You can change what contracts this actor claims in `wasmcloud.toml` and the `Makefile`. In the future this will just be in `wasmcloud.toml`.
- You will then need to change the dependencies in `Cargo.toml` to import the interfaces for the contracts you want. Delete the `wasmcloud-interface-httpserver` dep if you're not using that contract.
- Finally, change the `src/lib.rs` file, changing/deleting the current interface import and `impl` block, while adding a new import & `impl` for any contracts you added!

### Using the included Github Actions

The generated project include two GitHub actions: `build.yml` and `release.yml` under `.github/workflows`. The build action will automatically build, lint, and check formatting for your actor. The release action will automatically release a new version of your actor whenever code is pushed to `main`, or when you push a tag with the form `vX.Y.Z`.

These actions require 3 secrets

1. `WASH_ISSUER_KEY`, which can be generated with `wash keys gen issuer`, then look for the 58 character `Seed` value
1. `WASH_SUBJECT_KEY`, which can be generated with `wash keys gen module`, then look for the 58 character `Seed` value
1. `WASMCLOUD_PAT`, which can be created by following the [Github PAT instructions](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) and ensuring the `write:packages` permission is enabled
