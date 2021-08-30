// {{to_snake_case interface}}.smithy
//

// Tell the code generator how to reference symbols defined in this namespace
metadata package = [ { namespace: "{{ namespace }}.{{to_snake_case interface}}", crate: "{{ to_snake_case project-name }}" } ]

namespace {{namespace}}.{{to_snake_case interface}}

use org.wasmcloud.model#wasmbus

/// Description of {{ to_pascal_case interface }} service
@wasmbus( actorReceive: true )
service {{ to_pascal_case interface }} {
  version: "0.1",
  operations: [ Convert ]
}

/// Converts the input string to a result
operation Convert {
  input: String,
  output: String
}

