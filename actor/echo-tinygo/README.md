# {{project-name}}

This actor takes an incoming HTTP request and returns a simple HTTP response. 
This is very similar to the echo example in the [tinygo actor sdk](https://github.com/wasmcloud/actor-tinygo).
Feel free to experiment with the code to see how you can change the HTTP response easily.

## Building
To build this actor and sign the WebAssembly file, run `make`.

Make sure the wasmcloud host is running (and a registry and a nats
server) as described in [Getting
Started](https://wasmcloud.dev/overview/installation/)

Start an http server provider and link it to your actor.
This only needs to be done once, even if you test multiple iterations of
your actor.
```
make provider
make link
```

To run your actor, issue the following commands
```
# push the signed wasm to your OCI registry
make push
# start the actor
make start
```

To test it,
```
curl -v localhost:8085/abc
```
It should print the response "hello" on your console.

### Using the included Github Actions
If you store your source code on Github, we've gone ahead and included two actions: `build.yml` and `release.yml` under `.github/workflows`. The build action will automatically build, lint, and check formatting for your actor. The release action will automatically release a new version of your actor whenever code is pushed to `main`, or when you push a tag with the form `vX.Y.Z`. 

These actions require 3 secrets
1. `WASH_ISSUER_KEY`, which can be generated with `wash keys gen issuer`, then look for the 56 character `Seed` value
1. `WASH_SUBJECT_KEY`, which can be generated with `wash keys gen module`, then look for the 56 character `Seed` value
1. `WASMCLOUD_PAT`, which can be created by following the [Github PAT instructions](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) and ensuring the `write:packages` permission is enabled