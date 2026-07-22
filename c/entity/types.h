// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return
// `voxgig_value*`), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support. This header is standalone
// and is not #included by any generated .c.

#ifndef THESMSWORKS_ENTITY_TYPES_H
#define THESMSWORKS_ENTITY_TYPES_H

#include "sdk.h"

// Batch is the typed data model for the batch entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Batch;

// BatchLoadMatch is the typed request payload for Batch.load.
typedef struct {
  char*id;
} BatchLoadMatch;

// BatchMessage is the typed data model for the batch_message entity.
typedef struct {
  bool ai;  // optional
  char*content;
  char*deliveryreporturl;  // optional
  voxgig_value*destination;
  char*schedule;  // optional
  char*sender;
  char*tag;  // optional
  double ttl;  // optional
  double validity;  // optional
} BatchMessage;

// BatchMessageCreateData is the typed request payload for BatchMessage.create.
typedef struct {
  bool ai;  // optional
  char*content;
  char*deliveryreporturl;  // optional
  voxgig_value*destination;
  char*schedule;  // optional
  char*sender;
  char*tag;  // optional
  double ttl;  // optional
  double validity;  // optional
} BatchMessageCreateData;

// BatchMessageRemoveMatch is the typed request payload for BatchMessage.remove.
typedef struct {
  char*batchid;
} BatchMessageRemoveMatch;

// Credit is the typed data model for the credit entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Credit;

// CreditLoadMatch is the typed request payload for Credit.load.
typedef struct {
  char _unused;  // placeholder: no modelled members
} CreditLoadMatch;

// Flash is the typed data model for the flash entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Flash;

// Message is the typed data model for the message entity.
typedef struct {
  bool ai;  // optional
  char*content;
  double credit;  // optional
  char*deliveryreporturl;  // optional
  char*destination;
  char*from;  // optional
  char*keyword;  // optional
  double limit;  // optional
  voxgig_value*metadata;  // optional
  voxgig_value*responseemail;  // optional
  char*schedule;  // optional
  char*sender;
  double skip;  // optional
  char*status;  // optional
  char*tag;  // optional
  char*to;  // optional
  double ttl;  // optional
  bool unread;  // optional
  double validity;  // optional
} Message;

// MessageLoadMatch is the typed request payload for Message.load.
typedef struct {
  char*id;
} MessageLoadMatch;

// MessageCreateData is the typed request payload for Message.create.
typedef struct {
  bool ai;  // optional
  char*content;
  double credit;  // optional
  char*deliveryreporturl;  // optional
  char*destination;
  char*from;  // optional
  char*keyword;  // optional
  double limit;  // optional
  voxgig_value*metadata;  // optional
  voxgig_value*responseemail;  // optional
  char*schedule;  // optional
  char*sender;
  double skip;  // optional
  char*status;  // optional
  char*tag;  // optional
  char*to;  // optional
  double ttl;  // optional
  bool unread;  // optional
  double validity;  // optional
} MessageCreateData;

// MessageRemoveMatch is the typed request payload for Message.remove.
typedef struct {
  char*id;  // optional
  char*messageid;  // optional
} MessageRemoveMatch;

// OneTimePassword is the typed data model for the one_time_password entity.
typedef struct {
  char*destination;  // optional
  voxgig_value*length;  // optional
  voxgig_value*metadata;  // optional
  char*passcode;  // optional
  char*sender;  // optional
  char*template;  // optional
  double validity;  // optional
} OneTimePassword;

// OneTimePasswordLoadMatch is the typed request payload for OneTimePassword.load.
typedef struct {
  char*messageid;
} OneTimePasswordLoadMatch;

// OneTimePasswordCreateData is the typed request payload for OneTimePassword.create.
typedef struct {
  char*destination;  // optional
  voxgig_value*length;  // optional
  voxgig_value*metadata;  // optional
  char*passcode;  // optional
  char*sender;  // optional
  char*template;  // optional
  double validity;  // optional
} OneTimePasswordCreateData;

// Schedule is the typed data model for the schedule entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Schedule;

// Swagger is the typed data model for the swagger entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Swagger;

// Util is the typed data model for the util entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Util;

// UtilLoadMatch is the typed request payload for Util.load.
typedef struct {
  char*errorcode;
} UtilLoadMatch;

#endif // THESMSWORKS_ENTITY_TYPES_H
