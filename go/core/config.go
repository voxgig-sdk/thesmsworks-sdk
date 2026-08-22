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
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
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
				"flash": map[string]any{},
				"message": map[string]any{},
				"one_time_password": map[string]any{},
				"schedule": map[string]any{},
				"swagger": map[string]any{},
				"util": map[string]any{},
			},
		},
		"entity": map[string]any{
			"batch": map[string]any{
				"fields": []any{},
				"name": "batch",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "batchid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/batch/{batchid}",
								"parts": []any{
									"batch",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"batchid": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
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
						"short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "content",
						"req": true,
						"short": "Message to send to the recipient",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "deliveryreporturl",
						"short": "The url to which we should POST delivery reports to for this message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "destinations",
						"req": true,
						"short": "Telephone numbers of each of the recipients",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "schedule",
						"short": "Date-time at which to send the batch.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sender",
						"req": true,
						"short": "The sender of the message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "tag",
						"short": "An identifying label for the message, which you can use to filter and report on messages you've sent later.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ttl",
						"short": "The number of minutes before the delivery report is deleted.",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "validity",
						"short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.",
						"type": "`$NUMBER`",
					},
				},
				"name": "batch_message",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/batch/any",
								"parts": []any{
									"batch",
									"any",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/batch/schedule",
								"parts": []any{
									"batch",
									"schedule",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/batch/send",
								"parts": []any{
									"batch",
									"send",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "batchid",
											"orig": "batchid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/batches/schedule/{batchid}",
								"parts": []any{
									"batches",
									"schedule",
									"{batchid}",
								},
								"select": map[string]any{
									"exist": []any{
										"batchid",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"schedule",
						},
					},
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
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/credits/balance",
								"parts": []any{
									"credits",
									"balance",
								},
								"select": map[string]any{
									"$action": "balance",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"flash": map[string]any{
				"fields": []any{},
				"name": "flash",
				"op": map[string]any{},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"message": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "ai",
						"short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "content",
						"req": true,
						"short": "Message to send to the recipient.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "credits",
						"short": "The number of credits used on the message.",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "deliveryreporturl",
						"short": "The url to which we should POST delivery reports to for this message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "destination",
						"op": map[string]any{
							"create": map[string]any{
								"type": "`$STRING`",
							},
						},
						"req": true,
						"short": "Telephone number of the recipient",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "from",
						"short": "The date-time from which you would like matching messages",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "keyword",
						"short": "The keyword used in the inbound message",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "limit",
						"short": "The maximum number of messages that you would like returned in this call.",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "metadata",
						"short": "An array of objects containing metadata key/value pairs that have been saved on messages.",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "responseemail",
						"short": "An optional list of email addresses to forward responses to this specific message to.",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "schedule",
						"short": "Date at which to send the message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sender",
						"op": map[string]any{
							"create": map[string]any{
								"type": "`$STRING`",
							},
						},
						"req": true,
						"short": "The sender of the message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "skip",
						"short": "The number of results you would like to ignore before returning messages.",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "status",
						"short": "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "tag",
						"short": "An identifying label for the message, which you can use to filter and report on messages you've sent later.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "to",
						"short": "The date-time to which you would like matching messages",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ttl",
						"short": "The optional number of minutes before the delivery report is deleted.",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "unread",
						"short": "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "validity",
						"short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.",
						"type": "`$NUMBER`",
					},
				},
				"name": "message",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/message/flash",
								"parts": []any{
									"message",
									"flash",
								},
								"select": map[string]any{
									"$action": "flash",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/message/schedule",
								"parts": []any{
									"message",
									"schedule",
								},
								"select": map[string]any{
									"$action": "schedule",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/message/send",
								"parts": []any{
									"message",
									"send",
								},
								"select": map[string]any{
									"$action": "send",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/messages",
								"parts": []any{
									"messages",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/messages/failed",
								"parts": []any{
									"messages",
									"failed",
								},
								"select": map[string]any{
									"$action": "failed",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/messages/inbox",
								"parts": []any{
									"messages",
									"inbox",
								},
								"select": map[string]any{
									"$action": "inbox",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "messageid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/messages/{messageid}",
								"parts": []any{
									"messages",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"messageid": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/messages/schedule",
								"parts": []any{
									"messages",
									"schedule",
								},
								"select": map[string]any{
									"$action": "schedule",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "messageid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/messages/{messageid}",
								"parts": []any{
									"messages",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"messageid": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "messageid",
											"orig": "messageid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "DELETE",
								"orig": "/messages/schedule/{messageid}",
								"parts": []any{
									"messages",
									"schedule",
									"{messageid}",
								},
								"select": map[string]any{
									"exist": []any{
										"messageid",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"schedule",
						},
					},
				},
			},
			"one_time_password": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "destination",
						"short": "The phone number of the recipient.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "length",
						"short": "The length of the generated passcode.",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "metadata",
						"short": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "passcode",
						"short": "A passcode you supply for use in the message template.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sender",
						"short": "The sender of the message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "template",
						"short": "A template to use as the content for the message.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "validity",
						"short": "The length of time in seconds for which the generated passcode should be valid.",
						"type": "`$NUMBER`",
					},
				},
				"name": "one_time_password",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/otp/send",
								"parts": []any{
									"otp",
									"send",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/otp/verify",
								"parts": []any{
									"otp",
									"verify",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "messageid",
											"orig": "messageid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/otp/{messageid}",
								"parts": []any{
									"otp",
									"{messageid}",
								},
								"select": map[string]any{
									"exist": []any{
										"messageid",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"otp",
						},
					},
				},
			},
			"schedule": map[string]any{
				"fields": []any{},
				"name": "schedule",
				"op": map[string]any{},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"swagger": map[string]any{
				"fields": []any{},
				"name": "swagger",
				"op": map[string]any{},
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
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "errorcode",
											"orig": "errorcode",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/utils/errors/{errorcode}",
								"parts": []any{
									"utils",
									"errors",
									"{errorcode}",
								},
								"select": map[string]any{
									"exist": []any{
										"errorcode",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/utils/test",
								"parts": []any{
									"utils",
									"test",
								},
								"select": map[string]any{
									"$action": "test",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"error",
						},
					},
				},
			},
		},
	}
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
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
