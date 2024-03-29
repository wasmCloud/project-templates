use wasmbus_rpc::actor::prelude::*;
use wasmcloud_interface_messaging::*;

#[derive(Debug, Default, Actor, HealthResponder)]
#[services(Actor, MessageSubscriber)]
struct {{to_pascal_case project-name}}Actor {}

#[async_trait]
impl MessageSubscriber for {{to_pascal_case project-name}}Actor {
    /// handle subscription response
    async fn handle_message(&self, ctx: &Context, msg: &SubMessage) -> RpcResult<()> {
        // if the sender wants a reply
        if let Some(reply_to) = &msg.reply_to {
            MessagingSender::new()
                .publish(
                    ctx,
                    &PubMessage {
                        body: msg.body.clone(),
                        reply_to: None,
                        subject: reply_to.to_owned(),
                    },
                )
                .await?;
        }
        Ok(())
    }
}
