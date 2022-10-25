//! Implementation for wasmcloud:messaging.
//!
use std::convert::Infallible;
use tracing::debug;
use wasmbus_rpc::{core::LinkDefinition, provider::prelude::*};
use wasmcloud_interface_messaging::{
    Messaging, MessagingReceiver, PubMessage, ReplyMessage, RequestMessage,
};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // handle lattice control messages and forward rpc to the provider dispatch
    // returns when provider receives a shutdown control message
    provider_main(
        {{ to_pascal_case project-name }}Provider::default(),
        Some("{{ to_pascal_case project-name }} Provider".to_string()),
    )?;

    eprintln!("{{ to_pascal_case project-name }} provider exiting");
    Ok(())
}

/// Implementation for wasmcloud:messaging
#[derive(Default, Clone, Provider)]
#[services(Messaging)]
struct {{ to_pascal_case project-name }}Provider {}
// use default implementations of provider message handlers
impl ProviderDispatch for {{ to_pascal_case project-name }}Provider {}

/// Handle provider control commands
/// put_link (new actor link command), del_link (remove link command), and shutdown
#[async_trait]
impl ProviderHandler for {{ to_pascal_case project-name }}Provider {
    /// Provider should perform any operations needed for a new link,
    /// including setting up per-actor resources, and checking authorization.
    /// If the link is allowed, return true, otherwise return false to deny the link.
    async fn put_link(&self, ld: &LinkDefinition) -> RpcResult<bool> {
        debug!("putting link for actor {:?}", ld);

        Ok(true)
    }

    /// Handle notification that a link is dropped: close the connection
    async fn delete_link(&self, actor_id: &str) {
        debug!("deleting link for actor {}", actor_id);
    }

    /// Handle shutdown request with any cleanup necessary
    async fn shutdown(&self) -> std::result::Result<(), Infallible> {
        Ok(())
    }
}

/// Handle Messaging methods
#[async_trait]
impl Messaging for {{ to_pascal_case project-name }}Provider {
    async fn publish(&self, _ctx: &Context, _msg: &PubMessage) -> RpcResult<()> {
        Err(RpcError::NotImplemented)
    }

    async fn request(&self, _ctx: &Context, _msg: &RequestMessage) -> RpcResult<ReplyMessage> {
        Err(RpcError::NotImplemented)
    }
}
