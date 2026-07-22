// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.
#![allow(dead_code, non_snake_case, unused_imports)]

use crate::utility::voxgigstruct::Value;

/// Batch is the typed data model for the batch entity.
#[derive(Debug, Clone)]
pub struct Batch {
}

/// BatchLoadMatch is the typed request payload for Batch.load.
#[derive(Debug, Clone)]
pub struct BatchLoadMatch {
    pub id: String,
}

/// BatchMessage is the typed data model for the batch_message entity.
#[derive(Debug, Clone)]
pub struct BatchMessage {
    pub ai: Option<bool>,
    pub content: String,
    pub deliveryreporturl: Option<String>,
    pub destination: Vec<Value>,
    pub schedule: Option<String>,
    pub sender: String,
    pub tag: Option<String>,
    pub ttl: Option<f64>,
    pub validity: Option<f64>,
}

/// BatchMessageCreateData is the typed request payload for BatchMessage.create.
#[derive(Debug, Clone)]
pub struct BatchMessageCreateData {
    pub ai: Option<bool>,
    pub content: String,
    pub deliveryreporturl: Option<String>,
    pub destination: Vec<Value>,
    pub schedule: Option<String>,
    pub sender: String,
    pub tag: Option<String>,
    pub ttl: Option<f64>,
    pub validity: Option<f64>,
}

/// BatchMessageRemoveMatch is the typed request payload for BatchMessage.remove.
#[derive(Debug, Clone)]
pub struct BatchMessageRemoveMatch {
    pub batchid: String,
}

/// Credit is the typed data model for the credit entity.
#[derive(Debug, Clone)]
pub struct Credit {
}

/// CreditLoadMatch is the typed request payload for Credit.load.
#[derive(Debug, Clone)]
pub struct CreditLoadMatch {
}

/// Flash is the typed data model for the flash entity.
#[derive(Debug, Clone)]
pub struct Flash {
}

/// Message is the typed data model for the message entity.
#[derive(Debug, Clone)]
pub struct Message {
    pub ai: Option<bool>,
    pub content: String,
    pub credit: Option<f64>,
    pub deliveryreporturl: Option<String>,
    pub destination: String,
    pub from: Option<String>,
    pub keyword: Option<String>,
    pub limit: Option<f64>,
    pub metadata: Option<Value>,
    pub responseemail: Option<Vec<Value>>,
    pub schedule: Option<String>,
    pub sender: String,
    pub skip: Option<f64>,
    pub status: Option<String>,
    pub tag: Option<String>,
    pub to: Option<String>,
    pub ttl: Option<f64>,
    pub unread: Option<bool>,
    pub validity: Option<f64>,
}

/// MessageLoadMatch is the typed request payload for Message.load.
#[derive(Debug, Clone)]
pub struct MessageLoadMatch {
    pub id: String,
}

/// MessageCreateData is the typed request payload for Message.create.
#[derive(Debug, Clone)]
pub struct MessageCreateData {
    pub ai: Option<bool>,
    pub content: String,
    pub credit: Option<f64>,
    pub deliveryreporturl: Option<String>,
    pub destination: String,
    pub from: Option<String>,
    pub keyword: Option<String>,
    pub limit: Option<f64>,
    pub metadata: Option<Value>,
    pub responseemail: Option<Vec<Value>>,
    pub schedule: Option<String>,
    pub sender: String,
    pub skip: Option<f64>,
    pub status: Option<String>,
    pub tag: Option<String>,
    pub to: Option<String>,
    pub ttl: Option<f64>,
    pub unread: Option<bool>,
    pub validity: Option<f64>,
}

/// MessageRemoveMatch is the typed request payload for Message.remove.
#[derive(Debug, Clone)]
pub struct MessageRemoveMatch {
    pub id: Option<String>,
    pub messageid: Option<String>,
}

/// OneTimePassword is the typed data model for the one_time_password entity.
#[derive(Debug, Clone)]
pub struct OneTimePassword {
    pub destination: Option<String>,
    pub length: Option<Value>,
    pub metadata: Option<Value>,
    pub passcode: Option<String>,
    pub sender: Option<String>,
    pub template: Option<String>,
    pub validity: Option<f64>,
}

/// OneTimePasswordLoadMatch is the typed request payload for OneTimePassword.load.
#[derive(Debug, Clone)]
pub struct OneTimePasswordLoadMatch {
    pub messageid: String,
}

/// OneTimePasswordCreateData is the typed request payload for OneTimePassword.create.
#[derive(Debug, Clone)]
pub struct OneTimePasswordCreateData {
    pub destination: Option<String>,
    pub length: Option<Value>,
    pub metadata: Option<Value>,
    pub passcode: Option<String>,
    pub sender: Option<String>,
    pub template: Option<String>,
    pub validity: Option<f64>,
}

/// Schedule is the typed data model for the schedule entity.
#[derive(Debug, Clone)]
pub struct Schedule {
}

/// Swagger is the typed data model for the swagger entity.
#[derive(Debug, Clone)]
pub struct Swagger {
}

/// Util is the typed data model for the util entity.
#[derive(Debug, Clone)]
pub struct Util {
}

/// UtilLoadMatch is the typed request payload for Util.load.
#[derive(Debug, Clone)]
pub struct UtilLoadMatch {
    pub errorcode: String,
}

