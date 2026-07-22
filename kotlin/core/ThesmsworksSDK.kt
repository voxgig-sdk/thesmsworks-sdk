package voxgig.thesmsworkssdk.core

/**
 * Thesmsworks SDK client. All transport and pipeline behaviour lives in the
 * SdkClient base (core/SdkClient.kt); this class binds the API-specific
 * entity accessors and the test-mode constructor.
 */
class ThesmsworksSDK(options: MutableMap<String, Any?>?) : SdkClient(options) {

  constructor() : this(null)


  /**
   * Returns a batch entity bound to this client.
   * Idiomatic usage: client.batch(null).list(null, null) or
   * client.batch(null).load(mutableMapOf("id" to ...), null).
   */
  fun batch(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.BatchEntity(this, entopts)
  }

  /**
   * Returns a batch_message entity bound to this client.
   * Idiomatic usage: client.batchMessage(null).list(null, null) or
   * client.batchMessage(null).load(mutableMapOf("id" to ...), null).
   */
  fun batchMessage(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.BatchMessageEntity(this, entopts)
  }

  /**
   * Returns a credit entity bound to this client.
   * Idiomatic usage: client.credit(null).list(null, null) or
   * client.credit(null).load(mutableMapOf("id" to ...), null).
   */
  fun credit(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.CreditEntity(this, entopts)
  }

  /**
   * Returns a flash entity bound to this client.
   * Idiomatic usage: client.flash(null).list(null, null) or
   * client.flash(null).load(mutableMapOf("id" to ...), null).
   */
  fun flash(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.FlashEntity(this, entopts)
  }

  /**
   * Returns a message entity bound to this client.
   * Idiomatic usage: client.message(null).list(null, null) or
   * client.message(null).load(mutableMapOf("id" to ...), null).
   */
  fun message(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.MessageEntity(this, entopts)
  }

  /**
   * Returns a one_time_password entity bound to this client.
   * Idiomatic usage: client.oneTimePassword(null).list(null, null) or
   * client.oneTimePassword(null).load(mutableMapOf("id" to ...), null).
   */
  fun oneTimePassword(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.OneTimePasswordEntity(this, entopts)
  }

  /**
   * Returns a schedule entity bound to this client.
   * Idiomatic usage: client.schedule(null).list(null, null) or
   * client.schedule(null).load(mutableMapOf("id" to ...), null).
   */
  fun schedule(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.ScheduleEntity(this, entopts)
  }

  /**
   * Returns a swagger entity bound to this client.
   * Idiomatic usage: client.swagger(null).list(null, null) or
   * client.swagger(null).load(mutableMapOf("id" to ...), null).
   */
  fun swagger(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.SwaggerEntity(this, entopts)
  }

  /**
   * Returns a util entity bound to this client.
   * Idiomatic usage: client.util(null).list(null, null) or
   * client.util(null).load(mutableMapOf("id" to ...), null).
   */
  fun util(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.thesmsworkssdk.entity.UtilEntity(this, entopts)
  }


  companion object {
    // testSDK builds a client in test mode: the test feature is activated,
    // installing the in-memory mock transport (no network activity).
    fun testSDK(): ThesmsworksSDK = testSDK(null, null)

    fun testSDK(
      testopts: MutableMap<String, Any?>?,
      sdkopts: MutableMap<String, Any?>?,
    ): ThesmsworksSDK {
      val sdk = ThesmsworksSDK(testOptions(testopts, sdkopts))
      sdk.mode = "test"
      return sdk
    }
  }
}
