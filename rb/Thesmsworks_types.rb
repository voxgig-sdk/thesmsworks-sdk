# frozen_string_literal: true

# Typed models for the Thesmsworks SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Batch entity data model.
class Batch
end

# Request payload for Batch#load.
#
# @!attribute [rw] id
#   @return [String]
BatchLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# BatchMessage entity data model.
#
# @!attribute [rw] ai
#   @return [Boolean, nil]
#
# @!attribute [rw] content
#   @return [String]
#
# @!attribute [rw] deliveryreporturl
#   @return [String, nil]
#
# @!attribute [rw] destination
#   @return [Array]
#
# @!attribute [rw] schedule
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] tag
#   @return [String, nil]
#
# @!attribute [rw] ttl
#   @return [Float, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
BatchMessage = Struct.new(
  :ai,
  :content,
  :deliveryreporturl,
  :destination,
  :schedule,
  :sender,
  :tag,
  :ttl,
  :validity,
  keyword_init: true
)

# Request payload for BatchMessage#create.
#
# @!attribute [rw] ai
#   @return [Boolean, nil]
#
# @!attribute [rw] content
#   @return [String]
#
# @!attribute [rw] deliveryreporturl
#   @return [String, nil]
#
# @!attribute [rw] destination
#   @return [Array]
#
# @!attribute [rw] schedule
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] tag
#   @return [String, nil]
#
# @!attribute [rw] ttl
#   @return [Float, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
BatchMessageCreateData = Struct.new(
  :ai,
  :content,
  :deliveryreporturl,
  :destination,
  :schedule,
  :sender,
  :tag,
  :ttl,
  :validity,
  keyword_init: true
)

# Request payload for BatchMessage#remove.
#
# @!attribute [rw] batchid
#   @return [String]
BatchMessageRemoveMatch = Struct.new(
  :batchid,
  keyword_init: true
)

# Credit entity data model.
class Credit
end

# Request payload for Credit#load.
class CreditLoadMatch
end

# Flash entity data model.
class Flash
end

# Message entity data model.
#
# @!attribute [rw] ai
#   @return [Boolean, nil]
#
# @!attribute [rw] content
#   @return [String]
#
# @!attribute [rw] credit
#   @return [Float, nil]
#
# @!attribute [rw] deliveryreporturl
#   @return [String, nil]
#
# @!attribute [rw] destination
#   @return [String]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] keyword
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Float, nil]
#
# @!attribute [rw] metadata
#   @return [Hash, nil]
#
# @!attribute [rw] responseemail
#   @return [Array, nil]
#
# @!attribute [rw] schedule
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] skip
#   @return [Float, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] tag
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
#
# @!attribute [rw] ttl
#   @return [Float, nil]
#
# @!attribute [rw] unread
#   @return [Boolean, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
Message = Struct.new(
  :ai,
  :content,
  :credit,
  :deliveryreporturl,
  :destination,
  :from,
  :keyword,
  :limit,
  :metadata,
  :responseemail,
  :schedule,
  :sender,
  :skip,
  :status,
  :tag,
  :to,
  :ttl,
  :unread,
  :validity,
  keyword_init: true
)

# Request payload for Message#load.
#
# @!attribute [rw] id
#   @return [String]
MessageLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Message#create.
#
# @!attribute [rw] ai
#   @return [Boolean, nil]
#
# @!attribute [rw] content
#   @return [String]
#
# @!attribute [rw] credit
#   @return [Float, nil]
#
# @!attribute [rw] deliveryreporturl
#   @return [String, nil]
#
# @!attribute [rw] destination
#   @return [String]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] keyword
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Float, nil]
#
# @!attribute [rw] metadata
#   @return [Hash, nil]
#
# @!attribute [rw] responseemail
#   @return [Array, nil]
#
# @!attribute [rw] schedule
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] skip
#   @return [Float, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] tag
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
#
# @!attribute [rw] ttl
#   @return [Float, nil]
#
# @!attribute [rw] unread
#   @return [Boolean, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
MessageCreateData = Struct.new(
  :ai,
  :content,
  :credit,
  :deliveryreporturl,
  :destination,
  :from,
  :keyword,
  :limit,
  :metadata,
  :responseemail,
  :schedule,
  :sender,
  :skip,
  :status,
  :tag,
  :to,
  :ttl,
  :unread,
  :validity,
  keyword_init: true
)

# Request payload for Message#remove.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] messageid
#   @return [String, nil]
MessageRemoveMatch = Struct.new(
  :id,
  :messageid,
  keyword_init: true
)

# OneTimePassword entity data model.
#
# @!attribute [rw] destination
#   @return [String, nil]
#
# @!attribute [rw] length
#   @return [Hash, nil]
#
# @!attribute [rw] metadata
#   @return [Hash, nil]
#
# @!attribute [rw] passcode
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
OneTimePassword = Struct.new(
  :destination,
  :length,
  :metadata,
  :passcode,
  :sender,
  :template,
  :validity,
  keyword_init: true
)

# Request payload for OneTimePassword#load.
#
# @!attribute [rw] messageid
#   @return [String]
OneTimePasswordLoadMatch = Struct.new(
  :messageid,
  keyword_init: true
)

# Request payload for OneTimePassword#create.
#
# @!attribute [rw] destination
#   @return [String, nil]
#
# @!attribute [rw] length
#   @return [Hash, nil]
#
# @!attribute [rw] metadata
#   @return [Hash, nil]
#
# @!attribute [rw] passcode
#   @return [String, nil]
#
# @!attribute [rw] sender
#   @return [String, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
#
# @!attribute [rw] validity
#   @return [Float, nil]
OneTimePasswordCreateData = Struct.new(
  :destination,
  :length,
  :metadata,
  :passcode,
  :sender,
  :template,
  :validity,
  keyword_init: true
)

# Schedule entity data model.
class Schedule
end

# Swagger entity data model.
class Swagger
end

# Util entity data model.
class Util
end

# Request payload for Util#load.
#
# @!attribute [rw] errorcode
#   @return [String]
UtilLoadMatch = Struct.new(
  :errorcode,
  keyword_init: true
)

