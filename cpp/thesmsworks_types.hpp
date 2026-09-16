// Typed reference models for the Thesmsworks SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Array fields surface as std::vector<Value>, object
// fields as std::map<std::string, Value>, and any/null fields as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_THESMSWORKS_TYPES_HPP
#define SDK_THESMSWORKS_TYPES_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct Batch {
  std::string id;  // optional
};

struct BatchLoadMatch {
  std::string id;
};

struct BatchMessage {
  bool ai;  // optional
  std::string content;
  std::string deliveryreporturl;  // optional
  std::vector<Value> destinations;
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
  std::vector<Value> destinations;
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
  double credits;  // optional
  std::string destination;  // optional
  std::string from;  // optional
  std::string id;  // optional
  std::string keyword;  // optional
  double limit;  // optional
  std::map<std::string, Value> metadata;  // optional
  std::string sender;  // optional
  double skip;  // optional
  std::string status;  // optional
  std::string to;  // optional
  bool unread;  // optional
};

struct MessageLoadMatch {
  std::string id;
};

struct MessageCreateData {
  double credits;  // optional
  std::string destination;  // optional
  std::string from;  // optional
  std::string id;  // optional
  std::string keyword;  // optional
  double limit;  // optional
  std::map<std::string, Value> metadata;  // optional
  std::string sender;  // optional
  double skip;  // optional
  std::string status;  // optional
  std::string to;  // optional
  bool unread;  // optional
};

struct MessageRemoveMatch {
  std::string id;
};

struct OneTimePassword {
  std::string destination;  // optional
  std::map<std::string, Value> length;  // optional
  std::map<std::string, Value> metadata;  // optional
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
  std::map<std::string, Value> length;  // optional
  std::map<std::string, Value> metadata;  // optional
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
