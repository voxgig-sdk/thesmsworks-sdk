-- Typed models for the Thesmsworks SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Batch

---@class BatchLoadMatch
---@field id string

---@class BatchMessage
---@field ai? boolean
---@field content string
---@field deliveryreporturl? string
---@field destination table
---@field schedule? string
---@field sender string
---@field tag? string
---@field ttl? number
---@field validity? number

---@class BatchMessageCreateData
---@field ai? boolean
---@field content string
---@field deliveryreporturl? string
---@field destination table
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
---@field ai? boolean
---@field content string
---@field credit? number
---@field deliveryreporturl? string
---@field destination string
---@field from? string
---@field keyword? string
---@field limit? number
---@field metadata? table
---@field responseemail? table
---@field schedule? string
---@field sender string
---@field skip? number
---@field status? string
---@field tag? string
---@field to? string
---@field ttl? number
---@field unread? boolean
---@field validity? number

---@class MessageLoadMatch
---@field id string

---@class MessageCreateData
---@field ai? boolean
---@field content string
---@field credit? number
---@field deliveryreporturl? string
---@field destination string
---@field from? string
---@field keyword? string
---@field limit? number
---@field metadata? table
---@field responseemail? table
---@field schedule? string
---@field sender string
---@field skip? number
---@field status? string
---@field tag? string
---@field to? string
---@field ttl? number
---@field unread? boolean
---@field validity? number

---@class MessageRemoveMatch
---@field id? string
---@field messageid? string

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
