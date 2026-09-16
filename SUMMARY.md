# The SMS Works API

The SMS Works provides a low-cost, reliable SMS API for developers. Pay only for delivered texts, all failed UK messages are refunded.

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 9 entities and 21 HTTP routes. There are 23 SDK targets and 2 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### [Batch](docs/api/batch.html)

Results: Success.

SDK operations: `load`.

### [BatchMessage](docs/api/batch_message.html)

Results: Success.

SDK operations: `create`, `remove`.

Key fields to recognise:

- `ai`: Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.
- `content`: Message to send to the recipient
- `deliveryreporturl`: The url to which we should POST delivery reports to for this message.
- `destinations`: Telephone numbers of each of the recipients
- `schedule`: Date-time at which to send the batch.

### [Credit](docs/api/credit.html)

Results: Success.

SDK operations: `load`.

### [Flash](docs/api/flash.html)

SDK operations: .

### [Message](docs/api/message.html)

Results: Success.

SDK operations: `create`, `load`, `remove`.

Key fields to recognise:

- `credits`: The number of remaining credits on your SMS Works account. Floating point number.
- `destination`: For single scheduled messages, the mobile number of the recipient
- `from`: The date-time from which you would like matching messages
- `keyword`: The keyword used in the inbound message
- `limit`: The maximum number of messages that you would like returned in this call.

### [OneTimePassword](docs/api/one_time_password.html)

Results: Success.

SDK operations: `create`, `load`.

Key fields to recognise:

- `destination`: The mobile number that the OTP was sent to
- `length`: The length of the generated passcode.
- `metadata`: A JSON object storing data supplied when this passcode was generated, for use in your application.
- `passcode`: The passcode used.
- `sender`: The sender of the message.

### [Schedule](docs/api/schedule.html)

SDK operations: .

### [Swagger](docs/api/swagger.html)

SDK operations: .

### [Util](docs/api/util.html)

Results: Success.

SDK operations: `load`.

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| [Batch](docs/api/batch.html) | `load` | `GET /batch/{batchid}` | Required |
| [BatchMessage](docs/api/batch_message.html) | `create` | `POST /batch/any` | Required |
| [BatchMessage](docs/api/batch_message.html) | `create` | `POST /batch/schedule` | Required |
| [BatchMessage](docs/api/batch_message.html) | `create` | `POST /batch/send` | Required |
| [BatchMessage](docs/api/batch_message.html) | `remove` | `DELETE /batches/schedule/{batchid}` | Required |
| [Credit](docs/api/credit.html) | `load` | `GET /credits/balance` | Required |
| [Message](docs/api/message.html) | `create` | `POST /message/flash` | Required |
| [Message](docs/api/message.html) | `create` | `POST /message/schedule` | Required |
| [Message](docs/api/message.html) | `create` | `POST /message/send` | Required |
| [Message](docs/api/message.html) | `create` | `POST /messages` | Required |
| [Message](docs/api/message.html) | `create` | `POST /messages/failed` | Required |
| [Message](docs/api/message.html) | `create` | `POST /messages/inbox` | Required |
| [Message](docs/api/message.html) | `load` | `GET /messages/{messageid}` | Required |
| [Message](docs/api/message.html) | `load` | `GET /messages/schedule` | Required |
| [Message](docs/api/message.html) | `remove` | `DELETE /messages/{messageid}` | Required |
| [Message](docs/api/message.html) | `remove` | `DELETE /messages/schedule/{messageid}` | Required |
| [OneTimePassword](docs/api/one_time_password.html) | `create` | `POST /otp/send` | Required |
| [OneTimePassword](docs/api/one_time_password.html) | `create` | `POST /otp/verify` | Required |
| [OneTimePassword](docs/api/one_time_password.html) | `load` | `GET /otp/{messageid}` | Required |
| [Util](docs/api/util.html) | `load` | `GET /utils/errors/{errorcode}` | Required |
| [Util](docs/api/util.html) | `load` | `GET /utils/test` | Required |

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
| [C](docs/sdks/c.html) | `c/` | Build from source |
| [Clojure](docs/sdks/clojure.html) | `clojure/` | Build from source |
| [C++](docs/sdks/cpp.html) | `cpp/` | Build from source |
| [C#](docs/sdks/csharp.html) | `csharp/` | Build from source |
| [Dart](docs/sdks/dart.html) | `dart/` | Build from source |
| [Elixir](docs/sdks/elixir.html) | `elixir/` | Build from source |
| [Golang](docs/sdks/go.html) | `go/` | Build from source |
| [Haskell](docs/sdks/haskell.html) | `haskell/` | Build from source |
| [Java](docs/sdks/java.html) | `java/` | Build from source |
| [JavaScript](docs/sdks/js.html) | `js/` | Build from source |
| [Kotlin](docs/sdks/kotlin.html) | `kotlin/` | Build from source |
| [Lean](docs/sdks/lean.html) | `lean/` | Build from source |
| [Lua](docs/sdks/lua.html) | `lua/` | Build from source |
| [OCaml](docs/sdks/ocaml.html) | `ocaml/` | Build from source |
| [Perl](docs/sdks/perl.html) | `perl/` | Build from source |
| [PHP](docs/sdks/php.html) | `php/` | Build from source |
| [Python](docs/sdks/py.html) | `py/` | Build from source |
| [Ruby](docs/sdks/rb.html) | `rb/` | Build from source |
| [Rust](docs/sdks/rust.html) | `rust/` | Build from source |
| [Scala](docs/sdks/scala.html) | `scala/` | Build from source |
| [Swift](docs/sdks/swift.html) | `swift/` | Build from source |
| [TypeScript](docs/sdks/ts.html) | `ts/` | Build from source |
| [Zig](docs/sdks/zig.html) | `zig/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### [Go CLI](docs/tools/go-cli.html)

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### [Go MCP server](docs/tools/go-mcp.html)

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `thesmsworks_list`: List records for an entity. No active entity supports this operation.
- `thesmsworks_load`: Load one record for an entity. Supported entities: `batch`, `credit`, `message`, `one_time_password`, `util`.

## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- [`debug`](docs/features/debug.html): Request/response capture ring buffer for debugging
- [`idempotency`](docs/features/idempotency.html): Idempotency keys for safe retries of mutating operations
- [`metrics`](docs/features/metrics.html): Statistics capture: per-operation counters and latency
- [`paging`](docs/features/paging.html): Pagination signals for list operations
- [`ratelimit`](docs/features/ratelimit.html): Client-side rate limiting via a token bucket
- [`retry`](docs/features/retry.html): Automatic retry of transient failures with exponential backoff
- [`test`](docs/features/test.html): In-memory mock transport for testing without a live server
- [`timeout`](docs/features/timeout.html): Per-request timeout with transport abort

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the [first-call guide](docs/guides/first-call.html) for the setup sequence.
- Read the [authentication guide](docs/guides/authentication.html) before using protected routes.
- Use the [API reference](docs/api/index.html) for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

