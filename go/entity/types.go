// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Batch is the typed data model for the batch entity.
type Batch struct {
}

// BatchLoadMatch is the typed request payload for Batch.LoadTyped.
type BatchLoadMatch struct {
	Id string `json:"id"`
}

// BatchMessage is the typed data model for the batch_message entity.
type BatchMessage struct {
	Ai *bool `json:"ai,omitempty"`
	Content string `json:"content"`
	Deliveryreporturl *string `json:"deliveryreporturl,omitempty"`
	Destination []any `json:"destination"`
	Schedule *string `json:"schedule,omitempty"`
	Sender string `json:"sender"`
	Tag *string `json:"tag,omitempty"`
	Ttl *float64 `json:"ttl,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// BatchMessageCreateData is the typed request payload for BatchMessage.CreateTyped.
type BatchMessageCreateData struct {
	Ai *bool `json:"ai,omitempty"`
	Content string `json:"content"`
	Deliveryreporturl *string `json:"deliveryreporturl,omitempty"`
	Destination []any `json:"destination"`
	Schedule *string `json:"schedule,omitempty"`
	Sender string `json:"sender"`
	Tag *string `json:"tag,omitempty"`
	Ttl *float64 `json:"ttl,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// BatchMessageRemoveMatch is the typed request payload for BatchMessage.RemoveTyped.
type BatchMessageRemoveMatch struct {
	Batchid string `json:"batchid"`
}

// Credit is the typed data model for the credit entity.
type Credit struct {
}

// CreditLoadMatch is the typed request payload for Credit.LoadTyped.
type CreditLoadMatch struct {
}

// Flash is the typed data model for the flash entity.
type Flash struct {
}

// Message is the typed data model for the message entity.
type Message struct {
	Ai *bool `json:"ai,omitempty"`
	Content string `json:"content"`
	Credit *float64 `json:"credit,omitempty"`
	Deliveryreporturl *string `json:"deliveryreporturl,omitempty"`
	Destination string `json:"destination"`
	From *string `json:"from,omitempty"`
	Keyword *string `json:"keyword,omitempty"`
	Limit *float64 `json:"limit,omitempty"`
	Metadata *map[string]any `json:"metadata,omitempty"`
	Responseemail *[]any `json:"responseemail,omitempty"`
	Schedule *string `json:"schedule,omitempty"`
	Sender string `json:"sender"`
	Skip *float64 `json:"skip,omitempty"`
	Status *string `json:"status,omitempty"`
	Tag *string `json:"tag,omitempty"`
	To *string `json:"to,omitempty"`
	Ttl *float64 `json:"ttl,omitempty"`
	Unread *bool `json:"unread,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// MessageLoadMatch is the typed request payload for Message.LoadTyped.
type MessageLoadMatch struct {
	Id string `json:"id"`
}

// MessageCreateData is the typed request payload for Message.CreateTyped.
type MessageCreateData struct {
	Ai *bool `json:"ai,omitempty"`
	Content string `json:"content"`
	Credit *float64 `json:"credit,omitempty"`
	Deliveryreporturl *string `json:"deliveryreporturl,omitempty"`
	Destination string `json:"destination"`
	From *string `json:"from,omitempty"`
	Keyword *string `json:"keyword,omitempty"`
	Limit *float64 `json:"limit,omitempty"`
	Metadata *map[string]any `json:"metadata,omitempty"`
	Responseemail *[]any `json:"responseemail,omitempty"`
	Schedule *string `json:"schedule,omitempty"`
	Sender string `json:"sender"`
	Skip *float64 `json:"skip,omitempty"`
	Status *string `json:"status,omitempty"`
	Tag *string `json:"tag,omitempty"`
	To *string `json:"to,omitempty"`
	Ttl *float64 `json:"ttl,omitempty"`
	Unread *bool `json:"unread,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// MessageRemoveMatch is the typed request payload for Message.RemoveTyped.
type MessageRemoveMatch struct {
	Id *string `json:"id,omitempty"`
	Messageid *string `json:"messageid,omitempty"`
}

// OneTimePassword is the typed data model for the one_time_password entity.
type OneTimePassword struct {
	Destination *string `json:"destination,omitempty"`
	Length *map[string]any `json:"length,omitempty"`
	Metadata *map[string]any `json:"metadata,omitempty"`
	Passcode *string `json:"passcode,omitempty"`
	Sender *string `json:"sender,omitempty"`
	Template *string `json:"template,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// OneTimePasswordLoadMatch is the typed request payload for OneTimePassword.LoadTyped.
type OneTimePasswordLoadMatch struct {
	Messageid string `json:"messageid"`
}

// OneTimePasswordCreateData is the typed request payload for OneTimePassword.CreateTyped.
type OneTimePasswordCreateData struct {
	Destination *string `json:"destination,omitempty"`
	Length *map[string]any `json:"length,omitempty"`
	Metadata *map[string]any `json:"metadata,omitempty"`
	Passcode *string `json:"passcode,omitempty"`
	Sender *string `json:"sender,omitempty"`
	Template *string `json:"template,omitempty"`
	Validity *float64 `json:"validity,omitempty"`
}

// Schedule is the typed data model for the schedule entity.
type Schedule struct {
}

// Swagger is the typed data model for the swagger entity.
type Swagger struct {
}

// Util is the typed data model for the util entity.
type Util struct {
}

// UtilLoadMatch is the typed request payload for Util.LoadTyped.
type UtilLoadMatch struct {
	Errorcode string `json:"errorcode"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
