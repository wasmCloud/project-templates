use serde_json::json;
use wasmbus_rpc::actor::prelude::*;
use wasmcloud_interface_httpserver::{HttpRequest, HttpResponse, HttpServer, HttpServerReceiver};

#[derive(Debug, Default, Actor, HealthResponder)]
#[services(Actor, HttpServer)]
struct {{to_pascal_case project-name}}Actor {}

/// Implementation of HttpServer trait methods
#[async_trait]
impl HttpServer for {{to_pascal_case project-name}}Actor {
    async fn handle_request(&self, _ctx: &Context, req: &HttpRequest) -> RpcResult<HttpResponse> {
        let body = json!({
            "method": &req.method,
            "path": &req.path,
            "query_string": &req.query_string,
            "body": b"".to_vec(),
        });
        let resp = HttpResponse {
            body: serde_json::to_vec(&body)
                .map_err(|e| RpcError::ActorHandler(format!("serializing response: {}", e)))?,
            ..Default::default()
        };
        Ok(resp)
    }
}
