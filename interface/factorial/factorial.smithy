// {{to_snake_case interface}}.smithy
// A simple service that calculates the factorial of a whole number


// Tell the code generator how to reference symbols defined in this namespace
metadata package = [ { namespace: "{{ namespace }}.{{ to_snake_case interface }}", crate: "{{ to_snake_case project-name }}" } ]

namespace {{ namespace }}.{{ to_snake_case interface }}

use org.wasmcloud.model#wasmbus
use org.wasmcloud.model#U32
use org.wasmcloud.model#U64

/// The {{ to_pascal_case interface }} service has a single method, calculate, which
/// calculates the factorial of its whole number parameter.
@wasmbus(
    contractId: "{{ contract_id }}",
    actorReceive: true,
    providerReceive: true )
service {{ to_pascal_case interface }} {
  version: "0.1",
  operations: [ Calculate ]
}

/// Calculates the factorial (n!) of the input parameter
operation Calculate {
  input: U32,
  output: U64
}

