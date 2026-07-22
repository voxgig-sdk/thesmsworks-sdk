// ThesmsworksError: the SDK error type (mirrors go core/error.go). The
// pipeline error discipline is Result<T, ThesmsworksError> throughout.

use crate::utility::voxgigstruct::Value;

#[derive(Clone, Debug)]
pub struct ThesmsworksError {
    pub sdk: String,
    pub code: String,
    pub msg: String,
    // Cleaned snapshots attached by makeError (Noval until then).
    pub result: Value,
    pub spec: Value,
}

impl ThesmsworksError {
    pub fn new(code: &str, msg: &str) -> ThesmsworksError {
        ThesmsworksError {
            sdk: "Thesmsworks".to_string(),
            code: code.to_string(),
            msg: msg.to_string(),
            result: Value::Noval,
            spec: Value::Noval,
        }
    }
}

impl std::fmt::Display for ThesmsworksError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str(&self.msg)
    }
}

impl std::error::Error for ThesmsworksError {}
