extern crate wapc_guest as guest;
use actor_core as actorcore;

use guest::prelude::*;

#[no_mangle]
pub fn wapc_init() {
    actorcore::Handlers::register_health_request(health);
}

fn health(_h: actorcore::HealthCheckRequest) -> HandlerResult<actorcore::HealthCheckResponse> {
    Ok(actorcore::HealthCheckResponse::healthy())
}