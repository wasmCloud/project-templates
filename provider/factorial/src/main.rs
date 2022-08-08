//! {{ project-name }} capability provider
//!
//!
use wasmbus_rpc::provider::prelude::*;
use wasmcloud_interface_factorial::{Factorial, FactorialReceiver};

// main (via provider_main) initializes the threaded tokio executor,
// listens to lattice rpcs, handles actor links,
// and returns only when it receives a shutdown message
//
fn main() -> Result<(), Box<dyn std::error::Error>> {
    provider_main({{ to_pascal_case project-name }}Provider::default(), Some("{{ to_pascal_case project-name }}".to_string()))?;

    eprintln!("{{ project-name }} provider exiting");
    Ok(())
}

/// {{ project-name }} capability provider implementation
#[derive(Default, Clone, Provider)]
#[services(Factorial)]
struct {{ to_pascal_case project-name }}Provider {}

/// use default implementations of provider message handlers
impl ProviderDispatch for {{ to_pascal_case project-name }}Provider {}
impl ProviderHandler for {{ to_pascal_case project-name }}Provider {}

/// Handle Factorial methods
#[async_trait]
impl Factorial for {{ to_pascal_case project-name }}Provider {
    /// accepts a number and calculates its factorial
    async fn calculate(&self, _ctx: &Context, req: &u32) -> RpcResult<u64> {
        log::debug!("processing request calculate ({})", *req);
        Ok(n_factorial(*req))
    }
}

/// calculate n factorial
fn n_factorial(n: u32) -> u64 {
    match n {
        0 => 1,
        1 => 1,
        _ => {
            let mut result = 1u64;
            // add 1 because rust ranges exclude upper bound
            for v in 2..(n + 1) {
                result *= v as u64;
            }
            result
        }
    }
}
