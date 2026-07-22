// Swagger entity client (generated). Shared entity runtime (data/match
// state, entity context, the runOp pipeline + feature hooks) lives in
// EntityBase (core/types.hpp); this class binds the entity name and its
// supported CRUD operations.

#pragma once

#include <memory>

#include "../core/types.hpp"

namespace sdk {

class SwaggerEntity : public EntityBase {
public:
  SwaggerEntity(SdkClient* client, Value entopts = Value::undef())
      : EntityBase("swagger", client, entopts) {}

  EntityPtr make() override {
    Value opts = vmap();
    if (this->entopts.is_map()) {
      for (const auto& kv : *this->entopts.as_map()) {
        map_put(opts, kv.first, kv.second);
      }
    }
    return std::make_shared<SwaggerEntity>(this->client, opts);
  }

  Value load(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("load", this->name_);
    }

  Value list(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("list", this->name_);
    }

  Value create(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("create", this->name_);
    }

  Value update(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("update", this->name_);
    }

  Value remove(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("remove", this->name_);
    }
};

} // namespace sdk
