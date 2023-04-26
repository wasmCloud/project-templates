package main

import (
	provider "github.com/wasmCloud/provider-sdk-go"
	core "github.com/wasmcloud/interfaces/core/tinygo"
)

var (
	p *provider.WasmcloudProvider
)

func main() {
	var err error

	p, err = provider.New(
		"{{capability_id}}",
		provider.WithNewLinkFunc(handleNewLink),
		provider.WithDelLinkFunc(handleDelLink),
		provider.WithHealthCheckMsg(healthCheckMsg),
	)
	if err != nil {
		panic(err)
	}

	err = p.Start()
	if err != nil {
		panic(err)
	}
}

func healthCheckMsg() string {
	return "Barebones provider!"
}

func handleNewLink(linkdef core.LinkDefinition) error {
	return nil
}

func handleDelLink(_ core.LinkDefinition) error {
	return nil
}
