package voxgig.thesmsworkssdk.core

import java.util.{Map => JMap}

// Thesmsworks SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/SdkClient.scala); this class binds the API-specific
// entity accessors and the test-mode constructor.
class ThesmsworksSDK(options: JMap[String, Object]) extends SdkClient(options) {

  def this() = this(null)


  /**
   * Returns a batch entity bound to this client.
   * Idiomatic usage: client.batch(null).list(null, null) or
   * client.batch(null).load(java.util.Map.of("id", ...), null).
   */
  def batch(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.BatchEntity(this, entopts)

  /**
   * Returns a batch_message entity bound to this client.
   * Idiomatic usage: client.batchMessage(null).list(null, null) or
   * client.batchMessage(null).load(java.util.Map.of("id", ...), null).
   */
  def batchMessage(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.BatchMessageEntity(this, entopts)

  /**
   * Returns a credit entity bound to this client.
   * Idiomatic usage: client.credit(null).list(null, null) or
   * client.credit(null).load(java.util.Map.of("id", ...), null).
   */
  def credit(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.CreditEntity(this, entopts)

  /**
   * Returns a flash entity bound to this client.
   * Idiomatic usage: client.flash(null).list(null, null) or
   * client.flash(null).load(java.util.Map.of("id", ...), null).
   */
  def flash(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.FlashEntity(this, entopts)

  /**
   * Returns a message entity bound to this client.
   * Idiomatic usage: client.message(null).list(null, null) or
   * client.message(null).load(java.util.Map.of("id", ...), null).
   */
  def message(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.MessageEntity(this, entopts)

  /**
   * Returns a one_time_password entity bound to this client.
   * Idiomatic usage: client.oneTimePassword(null).list(null, null) or
   * client.oneTimePassword(null).load(java.util.Map.of("id", ...), null).
   */
  def oneTimePassword(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.OneTimePasswordEntity(this, entopts)

  /**
   * Returns a schedule entity bound to this client.
   * Idiomatic usage: client.schedule(null).list(null, null) or
   * client.schedule(null).load(java.util.Map.of("id", ...), null).
   */
  def schedule(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.ScheduleEntity(this, entopts)

  /**
   * Returns a swagger entity bound to this client.
   * Idiomatic usage: client.swagger(null).list(null, null) or
   * client.swagger(null).load(java.util.Map.of("id", ...), null).
   */
  def swagger(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.SwaggerEntity(this, entopts)

  /**
   * Returns a util entity bound to this client.
   * Idiomatic usage: client.util(null).list(null, null) or
   * client.util(null).load(java.util.Map.of("id", ...), null).
   */
  def util(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.thesmsworkssdk.entity.UtilEntity(this, entopts)


}

object ThesmsworksSDK {

  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  def testSDK(): ThesmsworksSDK = testSDK(null, null)

  def testSDK(testopts: JMap[String, Object], sdkopts: JMap[String, Object]): ThesmsworksSDK = {
    val sdk = new ThesmsworksSDK(SdkClient.testOptions(testopts, sdkopts))
    sdk.mode = "test"
    sdk
  }
}
