package main

import (
	"github.com/wasmcloud/actor-tinygo"
	"github.com/wasmcloud/interfaces/httpserver/tinygo"
)

func main() {
	me := {{to_pascal_case project-name}}{}
	actor.RegisterHandlers(httpserver.HttpServerHandler(&me))
}

type {{to_pascal_case project-name}} struct{}

func (e *{{to_pascal_case project-name}}) HandleRequest(ctx *actor.Context, req httpserver.HttpRequest) (*httpserver.HttpResponse, error) {
	r := httpserver.HttpResponse{
		StatusCode: 200,
		Header:     make(httpserver.HeaderMap, 0),
		Body:       []byte("hello"),
	}
	return &r, nil
}