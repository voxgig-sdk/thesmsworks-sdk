// Typed reference models for the Thesmsworks SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Object/array/any fields surface as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_THESMSWORKS_TYPES_HPP
#define SDK_THESMSWORKS_TYPES_HPP

#include <cstdint>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct Batch {};

struct BatchLoadMatch {
  std::string id;
};

struct BatchMessage {
  bool ai;  // optional
  std::string content;
  std::string deliveryreporturl;  // optional
  std::vector<Value> destination;
  std::string schedule;  // optional
  std::string sender;
  std::string tag;  // optional
  double ttl;  // optional
  double validity;  // optional
};

struct BatchMessageCreateData {
  bool ai;  // optional
  std::string content;
  std::string deliveryreporturl;  // optional
  std::vector<Value> destination;
  std::string schedule;  // optional
  std::string sender;
  std::string tag;  // optional
  double ttl;  // optional
  double validity;  // optional
};

struct BatchMessageRemoveMatch {
  std::string batchid;
};

struct Credit {};

struct CreditLoadMatch {};

struct Flash {};

struct Message {
  bool ai;  // optional
  std::string content;
  double credit;  // optional
  std::string deliveryreporturl;  // optional
  std::string destination;
  std::string from;  // optional
  std::string keyword;  // optional
  double limit;  // optional
  Value metadata;  // optional
  std::vector<Value> responseemail;  // optional
  std::string schedule;  // optional
  std::string sender;
  double skip;  // optional
  std::string status;  // optional
  std::string tag;  // optional
  std::string to;  // optional
  double ttl;  // optional
  bool unread;  // optional
  double validity;  // optional
};

struct MessageLoadMatch {
  std::string id;
};

struct MessageCreateData {
  bool ai;  // optional
  std::string content;
  double credit;  // optional
  std::string deliveryreporturl;  // optional
  std::string destination;
  std::string from;  // optional
  std::string keyword;  // optional
  double limit;  // optional
  Value metadata;  // optional
  std::vector<Value> responseemail;  // optional
  std::string schedule;  // optional
  std::string sender;
  double skip;  // optional
  std::string status;  // optional
  std::string tag;  // optional
  std::string to;  // optional
  double ttl;  // optional
  bool unread;  // optional
  double validity;  // optional
};

struct MessageRemoveMatch {
  std::string id;  // optional
  std::string messageid;  // optional
};

struct OneTimePassword {
  std::string destination;  // optional
  Value length;  // optional
  Value metadata;  // optional
  std::string passcode;  // optional
  std::string sender;  // optional
  std::string template;  // optional
  double validity;  // optional
};

struct OneTimePasswordLoadMatch {
  std::string messageid;
};

struct OneTimePasswordCreateData {
  std::string destination;  // optional
  Value length;  // optional
  Value metadata;  // optional
  std::string passcode;  // optional
  std::string sender;  // optional
  std::string template;  // optional
  double validity;  // optional
};

struct Schedule {};

struct Swagger {};

struct Util {};

struct UtilLoadMatch {
  std::string errorcode;
};

} // namespace types
} // namespace sdk

#endif // SDK_THESMSWORKS_TYPES_HPP
