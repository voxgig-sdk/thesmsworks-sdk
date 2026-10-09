# The SMS Works API

The SMS Works provides a low-cost, reliable SMS API for developers. Pay only for delivered texts, all failed UK messages are refunded.

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 8 entities and 21 HTTP routes. There are 13 SDK targets and 3 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### Batch

Results: Success.

SDK operations: `load`.

### BatchMessage

Results: Success.

SDK operations: `create`.

Key fields to recognise:

- `ai`: Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.
- `content`: Message to send to the recipient
- `deliveryreporturl`: The url to which we should POST delivery reports to for this message.
- `destinations`: Telephone numbers of each of the recipients
- `schedule`: Date-time at which to send the batch.

### Credit

Results: Success.

SDK operations: `load`.

### Message

Results: Success.

SDK operations: `create`, `load`, `remove`.

Key fields to recognise:

- `credits`: The number of remaining credits on your SMS Works account. Floating point number.
- `destination`: The phone number of the recipient.
- `from`: The date-time from which you would like matching messages
- `keyword`: The keyword used in the inbound message
- `limit`: The maximum number of messages that you would like returned in this call.

### MessageSchedule

Results: Success.

SDK operations: `load`, `remove`.

Key fields to recognise:

- `id`: The scheduled message ID

### OneTimePassword

Results: Success.

SDK operations: `create`, `load`.

Key fields to recognise:

- `destination`: The mobile number that the OTP was sent to
- `length`: The length of the generated passcode.
- `metadata`: A JSON object storing data supplied when this passcode was generated, for use in your application.
- `passcode`: The passcode used.
- `sender`: The sender of the message.

### Schedule

Results: Success.

SDK operations: `remove`.

### Util

Results: Success.

SDK operations: `load`.

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| Batch | `load` | `GET /batch/{batchid}` | Required |
| BatchMessage | `create` | `POST /batch/any` | Required |
| BatchMessage | `create` | `POST /batch/schedule` | Required |
| BatchMessage | `create` | `POST /batch/send` | Required |
| Credit | `load` | `GET /credits/balance` | Required |
| Message | `create` | `POST /message/flash` | Required |
| Message | `create` | `POST /message/schedule` | Required |
| Message | `create` | `POST /message/send` | Required |
| Message | `create` | `POST /messages` | Required |
| Message | `create` | `POST /messages/failed` | Required |
| Message | `create` | `POST /messages/inbox` | Required |
| Message | `load` | `GET /messages/{messageid}` | Required |
| Message | `remove` | `DELETE /messages/{messageid}` | Required |
| MessageSchedule | `load` | `GET /messages/schedule` | Required |
| MessageSchedule | `remove` | `DELETE /messages/schedule/{messageid}` | Required |
| OneTimePassword | `create` | `POST /otp/send` | Required |
| OneTimePassword | `create` | `POST /otp/verify` | Required |
| OneTimePassword | `load` | `GET /otp/{messageid}` | Required |
| Schedule | `remove` | `DELETE /batches/schedule/{batchid}` | Required |
| Util | `load` | `GET /utils/errors/{errorcode}` | Required |
| Util | `load` | `GET /utils/test` | Required |

## Connect to the API

- API server: `https://api.thesmsworks.co.uk/v1`

The default credential is sent in the `Authorization` header.

Check authentication for the route you plan to call. A route that declares no authentication can be used without credentials; this does not change the requirements of other routes. Keep credentials in environment variables or a configured secret provider, and keep them out of source control and logs.

## Make a first request

1. Choose the API server and an operation that matches your task.
2. Check the operation’s required input and authentication. Use values valid for your account and environment.
3. Send one request and inspect the returned data before adding retries, concurrency, or a larger batch.

For an SDK call, install or build the chosen client, create a client instance with its documented configuration, and call the required entity operation. Language references describe the argument shape, asynchronous behaviour, and returned values.

## Choose an SDK

Choose the language already used by your application or service. The clients represent the same API model, while package setup, naming, and return types follow each language. Check the selected client’s reference and tests before integrating it into an existing application.

| Client | Repository directory | Distribution |
| --- | --- | --- |
| Clojure | `clojure/` | Build from source |
| C++ | `cpp/` | Build from source |
| Golang | `go/` | Build from source |
| Java | `java/` | Build from source |
| JavaScript | `js/` | Build from source |
| Kotlin | `kotlin/` | Build from source |
| Lua | `lua/` | Build from source |
| OCaml | `ocaml/` | Build from source |
| Python | `py/` | Build from source |
| Ruby | `rb/` | Build from source |
| Swift | `swift/` | Build from source |
| TypeScript | `ts/` | Build from source |
| Zig | `zig/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### Go CLI

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### Go MCP server

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `thesmsworks_list`: List records for an entity. No active entity supports this operation.
- `thesmsworks_load`: Load one record for an entity. Supported entities: `batch`, `credit`, `message`, `message_schedule`, `one_time_password`, `util`.

### Python Data

Use the data integration for analysis and notebook workflows.

Repository directory: `py-data/`. Not published. Build from the py-data directory.


## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- `audit`: Structured audit trail of operations
- `cache`: Response caching for safe read requests
- `clienttrack`: Client identity and per-request correlation headers
- `cost`: Cost tracking and spend budget for API calls
- `debug`: Request/response capture ring buffer for debugging
- `idempotency`: Idempotency keys for safe retries of mutating operations
- `log`: Structured request and response logging
- `metrics`: Statistics capture: per-operation counters and latency
- `netsim`: Network behaviour simulation for offline testing (latency, failures, outages)
- `paging`: Pagination signals for list operations
- `proxy`: Outbound HTTP(S) proxy routing
- `ratelimit`: Client-side rate limiting via a token bucket
- `rbac`: Client-side role/permission enforcement
- `retry`: Automatic retry of transient failures with exponential backoff
- `secrets`: Secret access: resolve the API credential through a provider chain, and exchange a refresh token for short-lived access tokens
- `streaming`: Incremental streaming of list results via async iteration
- `telemetry`: Distributed tracing spans with W3C trace-context propagation
- `test`: In-memory mock transport for testing without a live server
- `timeout`: Per-request timeout with transport abort
- `validate`: Payload validation against the model&#39;s own field types

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the first-call guide for the setup sequence.
- Read the authentication guide before using protected routes.
- Use the API reference for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

