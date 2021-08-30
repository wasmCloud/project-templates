
use toml;

let bytes = std::fs::read("project-generate.toml").unwrap();
let data = toml::from_slice::<toml::Value>(&bytes).unwrap();

println!("imported: {:?}", data);
