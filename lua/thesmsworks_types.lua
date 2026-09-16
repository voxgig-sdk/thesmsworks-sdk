-- Typed models for the Thesmsworks SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Batch
---@field id? string

---@class BatchLoadMatch
---@field id string

---@class BatchMessage
---@field ai? boolean
---@field content string
---@field deliveryreporturl? string
---@field destinations table
---@field schedule? string
---@field sender string
---@field tag? string
---@field ttl? number
---@field validity? number

---@class BatchMessageCreateData
---@field ai? boolean
---@field content string
---@field deliveryreporturl? string
---@field destinations table
---@field schedule? string
---@field sender string
---@field tag? string
---@field ttl? number
---@field validity? number

---@class BatchMessageRemoveMatch
---@field batchid string

---@class Credit

---@class CreditLoadMatch

---@class Flash

---@class Message
---@field credits? number
---@field destination? string
---@field from? string
---@field id? string
---@field keyword? string
---@field limit? number
---@field metadata? table
---@field sender? string
---@field skip? number
---@field status? string
---@field to? string
---@field unread? boolean

---@class MessageLoadMatch
---@field id string

---@class MessageCreateData
---@field credits? number
---@field destination? string
---@field from? string
---@field id? string
---@field keyword? string
---@field limit? number
---@field metadata? table
---@field sender? string
---@field skip? number
---@field status? string
---@field to? string
---@field unread? boolean

---@class MessageRemoveMatch
---@field id string

---@class OneTimePassword
---@field destination? string
---@field length? table
---@field metadata? table
---@field passcode? string
---@field sender? string
---@field template? string
---@field validity? number

---@class OneTimePasswordLoadMatch
---@field messageid string

---@class OneTimePasswordCreateData
---@field destination? string
---@field length? table
---@field metadata? table
---@field passcode? string
---@field sender? string
---@field template? string
---@field validity? number

---@class Schedule

---@class Swagger

---@class Util

---@class UtilLoadMatch
---@field errorcode string

local M = {}

return M
