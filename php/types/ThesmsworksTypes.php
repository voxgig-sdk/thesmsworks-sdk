<?php
declare(strict_types=1);

// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Batch entity data model. */
class Batch
{
}

/** Request payload for Batch#load. */
class BatchLoadMatch
{
    public string $id;
}

/** BatchMessage entity data model. */
class BatchMessage
{
    public ?bool $ai = null;
    public string $content;
    public ?string $deliveryreporturl = null;
    public array $destination;
    public ?string $schedule = null;
    public string $sender;
    public ?string $tag = null;
    public ?float $ttl = null;
    public ?float $validity = null;
}

/** Request payload for BatchMessage#create. */
class BatchMessageCreateData
{
    public ?bool $ai = null;
    public string $content;
    public ?string $deliveryreporturl = null;
    public array $destination;
    public ?string $schedule = null;
    public string $sender;
    public ?string $tag = null;
    public ?float $ttl = null;
    public ?float $validity = null;
}

/** Request payload for BatchMessage#remove. */
class BatchMessageRemoveMatch
{
    public string $batchid;
}

/** Credit entity data model. */
class Credit
{
}

/** Request payload for Credit#load. */
class CreditLoadMatch
{
}

/** Flash entity data model. */
class Flash
{
}

/** Message entity data model. */
class Message
{
    public ?bool $ai = null;
    public string $content;
    public ?float $credit = null;
    public ?string $deliveryreporturl = null;
    public string $destination;
    public ?string $from = null;
    public ?string $keyword = null;
    public ?float $limit = null;
    public ?array $metadata = null;
    public ?array $responseemail = null;
    public ?string $schedule = null;
    public string $sender;
    public ?float $skip = null;
    public ?string $status = null;
    public ?string $tag = null;
    public ?string $to = null;
    public ?float $ttl = null;
    public ?bool $unread = null;
    public ?float $validity = null;
}

/** Request payload for Message#load. */
class MessageLoadMatch
{
    public string $id;
}

/** Request payload for Message#create. */
class MessageCreateData
{
    public ?bool $ai = null;
    public string $content;
    public ?float $credit = null;
    public ?string $deliveryreporturl = null;
    public string $destination;
    public ?string $from = null;
    public ?string $keyword = null;
    public ?float $limit = null;
    public ?array $metadata = null;
    public ?array $responseemail = null;
    public ?string $schedule = null;
    public string $sender;
    public ?float $skip = null;
    public ?string $status = null;
    public ?string $tag = null;
    public ?string $to = null;
    public ?float $ttl = null;
    public ?bool $unread = null;
    public ?float $validity = null;
}

/** Request payload for Message#remove. */
class MessageRemoveMatch
{
    public ?string $id = null;
    public ?string $messageid = null;
}

/** OneTimePassword entity data model. */
class OneTimePassword
{
    public ?string $destination = null;
    public ?array $length = null;
    public ?array $metadata = null;
    public ?string $passcode = null;
    public ?string $sender = null;
    public ?string $template = null;
    public ?float $validity = null;
}

/** Request payload for OneTimePassword#load. */
class OneTimePasswordLoadMatch
{
    public string $messageid;
}

/** Request payload for OneTimePassword#create. */
class OneTimePasswordCreateData
{
    public ?string $destination = null;
    public ?array $length = null;
    public ?array $metadata = null;
    public ?string $passcode = null;
    public ?string $sender = null;
    public ?string $template = null;
    public ?float $validity = null;
}

/** Schedule entity data model. */
class Schedule
{
}

/** Swagger entity data model. */
class Swagger
{
}

/** Util entity data model. */
class Util
{
}

/** Request payload for Util#load. */
class UtilLoadMatch
{
    public string $errorcode;
}

