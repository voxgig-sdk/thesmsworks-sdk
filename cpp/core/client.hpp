// Thesmsworks SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/types.hpp); this class binds the API-specific entity
// accessors and the test-mode constructor.

#ifndef SDK_CORE_CLIENT_HPP
#define SDK_CORE_CLIENT_HPP

#include <memory>

#include "../core/types.hpp"
#include "../entity/entities.hpp"

namespace sdk {

class ThesmsworksSDK : public SdkClient {
public:
  explicit ThesmsworksSDK(Value options = Value::undef()) : SdkClient(options) {}


  // Batch entity bound to this client.
  std::shared_ptr<BatchEntity> batch(Value entopts = Value::undef()) {
    return std::make_shared<BatchEntity>(this, entopts);
  }

  // BatchMessage entity bound to this client.
  std::shared_ptr<BatchMessageEntity> batch_message(Value entopts = Value::undef()) {
    return std::make_shared<BatchMessageEntity>(this, entopts);
  }

  // Credit entity bound to this client.
  std::shared_ptr<CreditEntity> credit(Value entopts = Value::undef()) {
    return std::make_shared<CreditEntity>(this, entopts);
  }

  // Flash entity bound to this client.
  std::shared_ptr<FlashEntity> flash(Value entopts = Value::undef()) {
    return std::make_shared<FlashEntity>(this, entopts);
  }

  // Message entity bound to this client.
  std::shared_ptr<MessageEntity> message(Value entopts = Value::undef()) {
    return std::make_shared<MessageEntity>(this, entopts);
  }

  // OneTimePassword entity bound to this client.
  std::shared_ptr<OneTimePasswordEntity> one_time_password(Value entopts = Value::undef()) {
    return std::make_shared<OneTimePasswordEntity>(this, entopts);
  }

  // Schedule entity bound to this client.
  std::shared_ptr<ScheduleEntity> schedule(Value entopts = Value::undef()) {
    return std::make_shared<ScheduleEntity>(this, entopts);
  }

  // Swagger entity bound to this client.
  std::shared_ptr<SwaggerEntity> swagger(Value entopts = Value::undef()) {
    return std::make_shared<SwaggerEntity>(this, entopts);
  }

  // Util entity bound to this client.
  std::shared_ptr<UtilEntity> util(Value entopts = Value::undef()) {
    return std::make_shared<UtilEntity>(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  static std::shared_ptr<ThesmsworksSDK> testSDK() {
    return testSDK(Value::undef(), Value::undef());
  }

  static std::shared_ptr<ThesmsworksSDK> testSDK(Value testopts, Value sdkopts) {
    auto sdk = std::make_shared<ThesmsworksSDK>(SdkClient::testOptions(testopts, sdkopts));
    sdk->mode = "test";
    return sdk;
  }

  // Convenience no-arg constructor.
  static std::shared_ptr<ThesmsworksSDK> create() {
    return std::make_shared<ThesmsworksSDK>(Value::undef());
  }
};

using ThesmsworksSDKPtr = std::shared_ptr<ThesmsworksSDK>;

} // namespace sdk

#endif // SDK_CORE_CLIENT_HPP
