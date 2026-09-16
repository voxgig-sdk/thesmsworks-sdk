# Typed models for the Thesmsworks SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Batch(TypedDict, total=False):
    id: str


class BatchLoadMatch(TypedDict):
    id: str


class BatchMessageRequired(TypedDict):
    content: str
    destinations: list
    sender: str


class BatchMessage(BatchMessageRequired, total=False):
    ai: bool
    deliveryreporturl: str
    schedule: str
    tag: str
    ttl: float
    validity: float


class BatchMessageCreateDataRequired(TypedDict):
    content: str
    destinations: list
    sender: str


class BatchMessageCreateData(BatchMessageCreateDataRequired, total=False):
    ai: bool
    deliveryreporturl: str
    schedule: str
    tag: str
    ttl: float
    validity: float


class BatchMessageRemoveMatch(TypedDict):
    batchid: str


class Credit(TypedDict):
    pass


class CreditLoadMatch(TypedDict):
    pass


class Flash(TypedDict):
    pass


class Message(TypedDict, total=False):
    credits: float
    destination: str
    id: str
    keyword: str
    limit: float
    metadata: dict
    sender: str
    skip: float
    status: str
    to: str
    unread: bool


class MessageLoadMatch(TypedDict):
    id: str


class MessageCreateData(TypedDict, total=False):
    credits: float
    destination: str
    id: str
    keyword: str
    limit: float
    metadata: dict
    sender: str
    skip: float
    status: str
    to: str
    unread: bool


class MessageRemoveMatch(TypedDict):
    id: str


class OneTimePassword(TypedDict, total=False):
    destination: str
    length: dict
    metadata: dict
    passcode: str
    sender: str
    template: str
    validity: float


class OneTimePasswordLoadMatch(TypedDict):
    messageid: str


class OneTimePasswordCreateData(TypedDict, total=False):
    destination: str
    length: dict
    metadata: dict
    passcode: str
    sender: str
    template: str
    validity: float


class Schedule(TypedDict):
    pass


class Swagger(TypedDict):
    pass


class Util(TypedDict):
    pass


class UtilLoadMatch(TypedDict):
    errorcode: str
