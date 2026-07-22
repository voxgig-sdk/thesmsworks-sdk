package voxgig.thesmsworkssdk.core;

import java.util.Map;

/**
 * Thesmsworks SDK client. All transport and pipeline behaviour lives in
 * the SdkClient base (core/SdkClient.java); this class binds the
 * API-specific entity accessors and the test-mode constructor.
 */
public class ThesmsworksSDK extends SdkClient {

  public ThesmsworksSDK() {
    this(null);
  }

  public ThesmsworksSDK(Map<String, Object> options) {
    super(options);
  }


  /**
   * Returns a batch entity bound to this client.
   * Idiomatic usage: client.batch(null).list(null, null) or
   * client.batch(null).load(Map.of("id", ...), null).
   */
  public SdkEntity batch(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.BatchEntity(this, entopts);
  }

  /**
   * Returns a batch_message entity bound to this client.
   * Idiomatic usage: client.batchMessage(null).list(null, null) or
   * client.batchMessage(null).load(Map.of("id", ...), null).
   */
  public SdkEntity batchMessage(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.BatchMessageEntity(this, entopts);
  }

  /**
   * Returns a credit entity bound to this client.
   * Idiomatic usage: client.credit(null).list(null, null) or
   * client.credit(null).load(Map.of("id", ...), null).
   */
  public SdkEntity credit(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.CreditEntity(this, entopts);
  }

  /**
   * Returns a flash entity bound to this client.
   * Idiomatic usage: client.flash(null).list(null, null) or
   * client.flash(null).load(Map.of("id", ...), null).
   */
  public SdkEntity flash(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.FlashEntity(this, entopts);
  }

  /**
   * Returns a message entity bound to this client.
   * Idiomatic usage: client.message(null).list(null, null) or
   * client.message(null).load(Map.of("id", ...), null).
   */
  public SdkEntity message(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.MessageEntity(this, entopts);
  }

  /**
   * Returns a one_time_password entity bound to this client.
   * Idiomatic usage: client.oneTimePassword(null).list(null, null) or
   * client.oneTimePassword(null).load(Map.of("id", ...), null).
   */
  public SdkEntity oneTimePassword(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.OneTimePasswordEntity(this, entopts);
  }

  /**
   * Returns a schedule entity bound to this client.
   * Idiomatic usage: client.schedule(null).list(null, null) or
   * client.schedule(null).load(Map.of("id", ...), null).
   */
  public SdkEntity schedule(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.ScheduleEntity(this, entopts);
  }

  /**
   * Returns a swagger entity bound to this client.
   * Idiomatic usage: client.swagger(null).list(null, null) or
   * client.swagger(null).load(Map.of("id", ...), null).
   */
  public SdkEntity swagger(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.SwaggerEntity(this, entopts);
  }

  /**
   * Returns a util entity bound to this client.
   * Idiomatic usage: client.util(null).list(null, null) or
   * client.util(null).load(Map.of("id", ...), null).
   */
  public SdkEntity util(Map<String, Object> entopts) {
    return new voxgig.thesmsworkssdk.entity.UtilEntity(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  public static ThesmsworksSDK testSDK() {
    return testSDK(null, null);
  }

  public static ThesmsworksSDK testSDK(
      Map<String, Object> testopts, Map<String, Object> sdkopts) {
    ThesmsworksSDK sdk = new ThesmsworksSDK(SdkClient.testOptions(testopts, sdkopts));
    sdk.mode = "test";
    return sdk;
  }
}
