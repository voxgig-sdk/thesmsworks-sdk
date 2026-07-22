# Typed models for the Thesmsworks SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels. The SDK carries data as string-keyed struct value
# nodes, so each alias is an open string-keyed map; the @typedoc member lists
# document the concrete shapes. Do not edit by hand.

defmodule Thesmsworks.Types do
  @moduledoc """
  Documented shapes for the Thesmsworks SDK entities and operation payloads.

  Every alias resolves to an open string-keyed map because the SDK carries
  data as string-keyed struct value nodes; consult each type's member list for
  the concrete field/param types.
  """

  @typedoc """
  Batch entity data model.
  """
  @type batch :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Batch load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type batch_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  BatchMessage entity data model.

  Members:
    * `"ai"` — boolean() (optional)
    * `"content"` — String.t() (required)
    * `"deliveryreporturl"` — String.t() (optional)
    * `"destination"` — list() (required)
    * `"schedule"` — String.t() (optional)
    * `"sender"` — String.t() (required)
    * `"tag"` — String.t() (optional)
    * `"ttl"` — float() (optional)
    * `"validity"` — float() (optional)
  """
  @type batch_message :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for BatchMessage create.

  Members:
    * `"ai"` — boolean() (optional)
    * `"content"` — String.t() (required)
    * `"deliveryreporturl"` — String.t() (optional)
    * `"destination"` — list() (required)
    * `"schedule"` — String.t() (optional)
    * `"sender"` — String.t() (required)
    * `"tag"` — String.t() (optional)
    * `"ttl"` — float() (optional)
    * `"validity"` — float() (optional)
  """
  @type batch_message_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for BatchMessage remove.

  Members:
    * `"batchid"` — String.t() (required)
  """
  @type batch_message_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Credit entity data model.
  """
  @type credit :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Credit load.
  """
  @type credit_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Flash entity data model.
  """
  @type flash :: %{optional(String.t()) => any()}

  @typedoc """
  Message entity data model.

  Members:
    * `"ai"` — boolean() (optional)
    * `"content"` — String.t() (required)
    * `"credit"` — float() (optional)
    * `"deliveryreporturl"` — String.t() (optional)
    * `"destination"` — String.t() (required)
    * `"from"` — String.t() (optional)
    * `"keyword"` — String.t() (optional)
    * `"limit"` — float() (optional)
    * `"metadata"` — map() (optional)
    * `"responseemail"` — list() (optional)
    * `"schedule"` — String.t() (optional)
    * `"sender"` — String.t() (required)
    * `"skip"` — float() (optional)
    * `"status"` — String.t() (optional)
    * `"tag"` — String.t() (optional)
    * `"to"` — String.t() (optional)
    * `"ttl"` — float() (optional)
    * `"unread"` — boolean() (optional)
    * `"validity"` — float() (optional)
  """
  @type message :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Message load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type message_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Message create.

  Members:
    * `"ai"` — boolean() (optional)
    * `"content"` — String.t() (required)
    * `"credit"` — float() (optional)
    * `"deliveryreporturl"` — String.t() (optional)
    * `"destination"` — String.t() (required)
    * `"from"` — String.t() (optional)
    * `"keyword"` — String.t() (optional)
    * `"limit"` — float() (optional)
    * `"metadata"` — map() (optional)
    * `"responseemail"` — list() (optional)
    * `"schedule"` — String.t() (optional)
    * `"sender"` — String.t() (required)
    * `"skip"` — float() (optional)
    * `"status"` — String.t() (optional)
    * `"tag"` — String.t() (optional)
    * `"to"` — String.t() (optional)
    * `"ttl"` — float() (optional)
    * `"unread"` — boolean() (optional)
    * `"validity"` — float() (optional)
  """
  @type message_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Message remove.

  Members:
    * `"id"` — String.t() (optional)
    * `"messageid"` — String.t() (optional)
  """
  @type message_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  OneTimePassword entity data model.

  Members:
    * `"destination"` — String.t() (optional)
    * `"length"` — map() (optional)
    * `"metadata"` — map() (optional)
    * `"passcode"` — String.t() (optional)
    * `"sender"` — String.t() (optional)
    * `"template"` — String.t() (optional)
    * `"validity"` — float() (optional)
  """
  @type one_time_password :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OneTimePassword load.

  Members:
    * `"messageid"` — String.t() (required)
  """
  @type one_time_password_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OneTimePassword create.

  Members:
    * `"destination"` — String.t() (optional)
    * `"length"` — map() (optional)
    * `"metadata"` — map() (optional)
    * `"passcode"` — String.t() (optional)
    * `"sender"` — String.t() (optional)
    * `"template"` — String.t() (optional)
    * `"validity"` — float() (optional)
  """
  @type one_time_password_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Schedule entity data model.
  """
  @type schedule :: %{optional(String.t()) => any()}

  @typedoc """
  Swagger entity data model.
  """
  @type swagger :: %{optional(String.t()) => any()}

  @typedoc """
  Util entity data model.
  """
  @type util :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Util load.

  Members:
    * `"errorcode"` — String.t() (required)
  """
  @type util_load_match :: %{optional(String.t()) => any()}

end
