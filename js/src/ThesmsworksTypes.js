// Typed models for the Thesmsworks SDK (JSDoc typedefs).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
// edit by hand.

/**
 * @typedef {Object} Batch
 */

/**
 * @typedef {Object} BatchLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} BatchMessage
 * @property {boolean} [ai]
 * @property {string} content
 * @property {string} [deliveryreporturl]
 * @property {Array} destination
 * @property {string} [schedule]
 * @property {string} sender
 * @property {string} [tag]
 * @property {number} [ttl]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} BatchMessageCreateData
 * @property {boolean} [ai]
 * @property {string} content
 * @property {string} [deliveryreporturl]
 * @property {Array} destination
 * @property {string} [schedule]
 * @property {string} sender
 * @property {string} [tag]
 * @property {number} [ttl]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} BatchMessageRemoveMatch
 * @property {string} batchid
 */

/**
 * @typedef {Object} Credit
 */

/**
 * @typedef {Object} CreditLoadMatch
 */

/**
 * @typedef {Object} Flash
 */

/**
 * @typedef {Object} Message
 * @property {boolean} [ai]
 * @property {string} content
 * @property {number} [credit]
 * @property {string} [deliveryreporturl]
 * @property {string} destination
 * @property {string} [from]
 * @property {string} [keyword]
 * @property {number} [limit]
 * @property {Object} [metadata]
 * @property {Array} [responseemail]
 * @property {string} [schedule]
 * @property {string} sender
 * @property {number} [skip]
 * @property {string} [status]
 * @property {string} [tag]
 * @property {string} [to]
 * @property {number} [ttl]
 * @property {boolean} [unread]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} MessageLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} MessageCreateData
 * @property {boolean} [ai]
 * @property {string} content
 * @property {number} [credit]
 * @property {string} [deliveryreporturl]
 * @property {string} destination
 * @property {string} [from]
 * @property {string} [keyword]
 * @property {number} [limit]
 * @property {Object} [metadata]
 * @property {Array} [responseemail]
 * @property {string} [schedule]
 * @property {string} sender
 * @property {number} [skip]
 * @property {string} [status]
 * @property {string} [tag]
 * @property {string} [to]
 * @property {number} [ttl]
 * @property {boolean} [unread]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} MessageRemoveMatch
 * @property {string} [id]
 * @property {string} [messageid]
 */

/**
 * @typedef {Object} OneTimePassword
 * @property {string} [destination]
 * @property {Object} [length]
 * @property {Object} [metadata]
 * @property {string} [passcode]
 * @property {string} [sender]
 * @property {string} [template]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} OneTimePasswordLoadMatch
 * @property {string} messageid
 */

/**
 * @typedef {Object} OneTimePasswordCreateData
 * @property {string} [destination]
 * @property {Object} [length]
 * @property {Object} [metadata]
 * @property {string} [passcode]
 * @property {string} [sender]
 * @property {string} [template]
 * @property {number} [validity]
 */

/**
 * @typedef {Object} Schedule
 */

/**
 * @typedef {Object} Swagger
 */

/**
 * @typedef {Object} Util
 */

/**
 * @typedef {Object} UtilLoadMatch
 * @property {string} errorcode
 */

