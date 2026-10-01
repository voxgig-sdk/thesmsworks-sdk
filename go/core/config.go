package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "Thesmsworks",
			"slug": "thesmsworks",
			"version": "0.1.1",
			"target": "go",
		},
		"feature": map[string]any{
			"audit": map[string]any{
				"options": map[string]any{
					"active": false,
					"actor": "anonymous",
					"max": 1000,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"sink": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"cache": map[string]any{
				"options": map[string]any{
					"active": false,
					"max": 256,
					"methods": []any{
						"GET",
					},
					"ttl": 5000,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"clienttrack": map[string]any{
				"options": map[string]any{
					"active": false,
					"clientVersion": "0.0.1",
				},
				"optspec": map[string]any{
					"clientName": "`$STRING`",
					"clientVersion": "`$STRING`",
					"headers": "`$MAP`",
					"idgen": "`$FUNCTION`",
					"sessionId": "`$STRING`",
				},
				"strict": false,
				"transport": "none",
			},
			"cost": map[string]any{
				"options": map[string]any{
					"active": false,
					"budget": 0,
					"currency": "USD",
					"header": "",
					"onBudget": "warn",
					"path": "",
					"perUnit": 0,
					"rates": map[string]any{},
					"unit": 0,
				},
				"optspec": map[string]any{
					"actor": "`$STRING`",
					"sink": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"debug": map[string]any{
				"options": map[string]any{
					"active": false,
					"max": 100,
					"redact": []any{
						"authorization",
						"cookie",
						"set-cookie",
						"api-key",
						"apikey",
						"x-api-key",
						"idempotency-key",
					},
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"onEntry": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"idempotency": map[string]any{
				"options": map[string]any{
					"active": false,
					"header": "Idempotency-Key",
					"methods": []any{
						"POST",
						"PUT",
						"PATCH",
						"DELETE",
					},
					"ops": []any{
						"create",
						"update",
						"remove",
					},
				},
				"optspec": map[string]any{
					"keygen": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"log": map[string]any{
				"options": map[string]any{
					"active": true,
				},
				"optspec": map[string]any{
					"level": "`$STRING`",
					"logger": "`$ANY`",
				},
				"strict": false,
				"transport": "none",
			},
			"metrics": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"netsim": map[string]any{
				"options": map[string]any{
					"active": false,
					"errorTimes": 0,
					"failEvery": 0,
					"failRate": 0,
					"failStatus": 503,
					"failTimes": 0,
					"latency": 0,
					"offline": false,
					"rateLimitTimes": 0,
					"retryAfter": 0,
					"seed": 1,
				},
				"optspec": map[string]any{
					"latency": []any{
						"`$ONE`",
						"`$NUMBER`",
						"`$MAP`",
					},
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"paging": map[string]any{
				"options": map[string]any{
					"active": false,
					"afterVar": "after",
					"cursorParam": "cursor",
					"firstVar": "first",
					"limitParam": "limit",
					"pageParam": "page",
					"startPage": 1,
				},
				"optspec": map[string]any{
					"limit": "`$NUMBER`",
					"ops": "`$LIST`",
				},
				"strict": false,
				"transport": "none",
			},
			"proxy": map[string]any{
				"options": map[string]any{
					"active": false,
					"fromEnv": false,
					"noProxy": []any{},
					"url": "",
				},
				"optspec": map[string]any{
					"agent": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"ratelimit": map[string]any{
				"options": map[string]any{
					"active": false,
					"burst": 5,
					"rate": 5,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"rbac": map[string]any{
				"options": map[string]any{
					"active": false,
					"deny": false,
					"permissions": []any{},
					"rules": map[string]any{},
				},
				"optspec": map[string]any{},
				"strict": false,
				"transport": "none",
			},
			"retry": map[string]any{
				"options": map[string]any{
					"active": false,
					"factor": 2,
					"maxDelay": 2000,
					"minDelay": 50,
					"retries": 2,
					"statuses": []any{
						408,
						425,
						429,
						500,
						502,
						503,
						504,
					},
				},
				"optspec": map[string]any{
					"jitter": "`$BOOLEAN`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"secrets": map[string]any{
				"options": map[string]any{
					"active": false,
					"cache": true,
					"exchange": map[string]any{
						"active": false,
						"method": "POST",
						"path": "auth/token",
						"refresh": "",
						"request": "refresh_token",
						"response": "access_token",
						"retries": 1,
						"statuses": []any{
							401,
						},
					},
					"name": "apikey",
					"providers": []any{},
				},
				"optspec": map[string]any{},
				"strict": false,
				"transport": "wrap",
			},
			"streaming": map[string]any{
				"options": map[string]any{
					"active": false,
					"chunkDelay": 0,
					"chunkSize": 0,
				},
				"optspec": map[string]any{
					"ops": "`$LIST`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"telemetry": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"exporter": "`$FUNCTION`",
					"headers": "`$MAP`",
					"idgen": "`$FUNCTION`",
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"entity": "`$MAP`",
					"net": "`$MAP`",
				},
				"strict": false,
				"transport": "base",
			},
			"timeout": map[string]any{
				"options": map[string]any{
					"active": false,
					"ms": 30000,
				},
				"optspec": map[string]any{
					"clearTimer": "`$FUNCTION`",
					"setTimer": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"validate": map[string]any{
				"options": map[string]any{
					"active": false,
					"mode": "throw",
					"request": true,
					"response": false,
					"strict": false,
				},
				"optspec": map[string]any{
					"mode": []any{
						"`$ONE`",
						[]any{
							"`$EXACT`",
							"throw",
						},
						[]any{
							"`$EXACT`",
							"report",
						},
					},
					"onInvalid": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
		},
		"options": map[string]any{
			"base": "https://api.thesmsworks.co.uk/v1",
			"auth": map[string]any{
				"prefix": "",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"batch": map[string]any{},
				"batch_message": map[string]any{},
				"credit": map[string]any{},
				"message": map[string]any{},
				"one_time_password": map[string]any{},
				"util": map[string]any{},
			},
		},
		"entity": map[string]any{
			"batch": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "batch",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/batch/{batchid}",
								"segments": []any{
									map[string]any{
										"lit": "batch",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"batch",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"batchid": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "batchid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"batch_message": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "ai",
						"title": "Ai",
						"type": "`$BOOLEAN`",
						"short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.",
					},
					map[string]any{
						"name": "content",
						"title": "Content",
						"type": "`$STRING`",
						"req": true,
						"short": "Message to send to the recipient",
					},
					map[string]any{
						"name": "deliveryreporturl",
						"title": "Deliveryreporturl",
						"type": "`$STRING`",
						"short": "The url to which we should POST delivery reports to for this message.",
					},
					map[string]any{
						"name": "destinations",
						"title": "Destinations",
						"type": "`$ARRAY`",
						"req": true,
						"short": "Telephone numbers of each of the recipients",
					},
					map[string]any{
						"name": "schedule",
						"title": "Schedule",
						"type": "`$STRING`",
						"short": "Date-time at which to send the batch.",
					},
					map[string]any{
						"name": "sender",
						"title": "Sender",
						"type": "`$STRING`",
						"req": true,
						"short": "The sender of the message.",
					},
					map[string]any{
						"name": "tag",
						"title": "Tag",
						"type": "`$STRING`",
						"short": "An identifying label for the message, which you can use to filter and report on messages you've sent later.",
					},
					map[string]any{
						"name": "ttl",
						"title": "Ttl",
						"type": "`$NUMBER`",
						"short": "The number of minutes before the delivery report is deleted.",
					},
					map[string]any{
						"name": "validity",
						"title": "Validity",
						"type": "`$NUMBER`",
						"short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.",
					},
				},
				"name": "batch_message",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/batch/any",
								"segments": []any{
									map[string]any{
										"lit": "batch",
									},
									map[string]any{
										"lit": "any",
									},
								},
								"parts": []any{
									"batch",
									"any",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/batch/schedule",
								"segments": []any{
									map[string]any{
										"lit": "batch",
									},
									map[string]any{
										"lit": "schedule",
									},
								},
								"parts": []any{
									"batch",
									"schedule",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/batch/send",
								"segments": []any{
									map[string]any{
										"lit": "batch",
									},
									map[string]any{
										"lit": "send",
									},
								},
								"parts": []any{
									"batch",
									"send",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/batches/schedule/{batchid}",
								"segments": []any{
									map[string]any{
										"lit": "batches",
									},
									map[string]any{
										"lit": "schedule",
									},
									map[string]any{
										"var": "batchid",
									},
								},
								"parts": []any{
									"batches",
									"schedule",
									"{batchid}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "batchid",
											"orig": "batchid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"batchid",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"credit": map[string]any{
				"fields": []any{},
				"name": "credit",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/credits/balance",
								"segments": []any{
									map[string]any{
										"lit": "credits",
									},
									map[string]any{
										"lit": "balance",
									},
								},
								"parts": []any{
									"credits",
									"balance",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "balance",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"message": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "credits",
						"title": "Credits",
						"type": "`$NUMBER`",
						"short": "The number of credits used on the message.",
					},
					map[string]any{
						"name": "destination",
						"title": "Destination",
						"type": "`$STRING`",
						"short": "The phone number of the recipient.",
					},
					map[string]any{
						"name": "from",
						"title": "From",
						"type": "`$STRING`",
						"short": "The date-time from which you would like matching messages",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "keyword",
						"title": "Keyword",
						"type": "`$STRING`",
						"short": "The keyword used in the inbound message",
					},
					map[string]any{
						"name": "limit",
						"title": "Limit",
						"type": "`$NUMBER`",
						"short": "The maximum number of messages that you would like returned in this call.",
					},
					map[string]any{
						"name": "metadata",
						"title": "Metadata",
						"type": "`$OBJECT`",
						"short": "An array of objects containing metadata key/value pairs that have been saved on messages.",
					},
					map[string]any{
						"name": "sender",
						"title": "Sender",
						"type": "`$STRING`",
						"short": "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).",
					},
					map[string]any{
						"name": "skip",
						"title": "Skip",
						"type": "`$NUMBER`",
						"short": "The number of results you would like to ignore before returning messages.",
					},
					map[string]any{
						"name": "status",
						"title": "Status",
						"type": "`$STRING`",
						"short": "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')",
					},
					map[string]any{
						"name": "to",
						"title": "To",
						"type": "`$STRING`",
						"short": "The date-time to which you would like matching messages",
					},
					map[string]any{
						"name": "unread",
						"title": "Unread",
						"type": "`$BOOLEAN`",
						"short": "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "message",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/message/flash",
								"segments": []any{
									map[string]any{
										"lit": "message",
									},
									map[string]any{
										"lit": "flash",
									},
								},
								"parts": []any{
									"message",
									"flash",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "flash",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/message/schedule",
								"segments": []any{
									map[string]any{
										"lit": "message",
									},
									map[string]any{
										"lit": "schedule",
									},
								},
								"parts": []any{
									"message",
									"schedule",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "schedule",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/message/send",
								"segments": []any{
									map[string]any{
										"lit": "message",
									},
									map[string]any{
										"lit": "send",
									},
								},
								"parts": []any{
									"message",
									"send",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "send",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/messages",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
								},
								"parts": []any{
									"messages",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/messages/failed",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"lit": "failed",
									},
								},
								"parts": []any{
									"messages",
									"failed",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "failed",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/messages/inbox",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"lit": "inbox",
									},
								},
								"parts": []any{
									"messages",
									"inbox",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "inbox",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/messages/{messageid}",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"messages",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"messageid": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "messageid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/messages/schedule",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"lit": "schedule",
									},
								},
								"parts": []any{
									"messages",
									"schedule",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "schedule",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/messages/{messageid}",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"messages",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"messageid": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "messageid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/messages/schedule/{messageid}",
								"segments": []any{
									map[string]any{
										"lit": "messages",
									},
									map[string]any{
										"lit": "schedule",
									},
									map[string]any{
										"var": "messageid",
									},
								},
								"parts": []any{
									"messages",
									"schedule",
									"{messageid}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "messageid",
											"orig": "messageid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"messageid",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"one_time_password": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "destination",
						"title": "Destination",
						"type": "`$STRING`",
						"short": "The phone number of the recipient.",
					},
					map[string]any{
						"name": "length",
						"title": "Length",
						"type": "`$OBJECT`",
						"short": "The length of the generated passcode.",
					},
					map[string]any{
						"name": "metadata",
						"title": "Metadata",
						"type": "`$OBJECT`",
						"short": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.",
					},
					map[string]any{
						"name": "passcode",
						"title": "Passcode",
						"type": "`$STRING`",
						"short": "A passcode you supply for use in the message template.",
					},
					map[string]any{
						"name": "sender",
						"title": "Sender",
						"type": "`$STRING`",
						"short": "The sender of the message.",
					},
					map[string]any{
						"name": "template",
						"title": "Template",
						"type": "`$STRING`",
						"short": "A template to use as the content for the message.",
					},
					map[string]any{
						"name": "validity",
						"title": "Validity",
						"type": "`$NUMBER`",
						"short": "The length of time in seconds for which the generated passcode should be valid.",
					},
				},
				"name": "one_time_password",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/otp/send",
								"segments": []any{
									map[string]any{
										"lit": "otp",
									},
									map[string]any{
										"lit": "send",
									},
								},
								"parts": []any{
									"otp",
									"send",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/otp/verify",
								"segments": []any{
									map[string]any{
										"lit": "otp",
									},
									map[string]any{
										"lit": "verify",
									},
								},
								"parts": []any{
									"otp",
									"verify",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/otp/{messageid}",
								"segments": []any{
									map[string]any{
										"lit": "otp",
									},
									map[string]any{
										"var": "messageid",
									},
								},
								"parts": []any{
									"otp",
									"{messageid}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "messageid",
											"orig": "messageid",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"messageid",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"util": map[string]any{
				"fields": []any{},
				"name": "util",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/utils/errors/{errorcode}",
								"segments": []any{
									map[string]any{
										"lit": "utils",
									},
									map[string]any{
										"lit": "errors",
									},
									map[string]any{
										"var": "errorcode",
									},
								},
								"parts": []any{
									"utils",
									"errors",
									"{errorcode}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "errorcode",
											"orig": "errorcode",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"errorcode",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/utils/test",
								"segments": []any{
									map[string]any{
										"lit": "utils",
									},
									map[string]any{
										"lit": "test",
									},
								},
								"parts": []any{
									"utils",
									"test",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "test",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "audit":
		if NewAuditFeatureFunc != nil {
			return NewAuditFeatureFunc()
		}
	case "cache":
		if NewCacheFeatureFunc != nil {
			return NewCacheFeatureFunc()
		}
	case "clienttrack":
		if NewClienttrackFeatureFunc != nil {
			return NewClienttrackFeatureFunc()
		}
	case "cost":
		if NewCostFeatureFunc != nil {
			return NewCostFeatureFunc()
		}
	case "debug":
		if NewDebugFeatureFunc != nil {
			return NewDebugFeatureFunc()
		}
	case "idempotency":
		if NewIdempotencyFeatureFunc != nil {
			return NewIdempotencyFeatureFunc()
		}
	case "log":
		if NewLogFeatureFunc != nil {
			return NewLogFeatureFunc()
		}
	case "metrics":
		if NewMetricsFeatureFunc != nil {
			return NewMetricsFeatureFunc()
		}
	case "netsim":
		if NewNetsimFeatureFunc != nil {
			return NewNetsimFeatureFunc()
		}
	case "paging":
		if NewPagingFeatureFunc != nil {
			return NewPagingFeatureFunc()
		}
	case "proxy":
		if NewProxyFeatureFunc != nil {
			return NewProxyFeatureFunc()
		}
	case "ratelimit":
		if NewRatelimitFeatureFunc != nil {
			return NewRatelimitFeatureFunc()
		}
	case "rbac":
		if NewRbacFeatureFunc != nil {
			return NewRbacFeatureFunc()
		}
	case "retry":
		if NewRetryFeatureFunc != nil {
			return NewRetryFeatureFunc()
		}
	case "secrets":
		if NewSecretsFeatureFunc != nil {
			return NewSecretsFeatureFunc()
		}
	case "streaming":
		if NewStreamingFeatureFunc != nil {
			return NewStreamingFeatureFunc()
		}
	case "telemetry":
		if NewTelemetryFeatureFunc != nil {
			return NewTelemetryFeatureFunc()
		}
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	case "timeout":
		if NewTimeoutFeatureFunc != nil {
			return NewTimeoutFeatureFunc()
		}
	case "validate":
		if NewValidateFeatureFunc != nil {
			return NewValidateFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
