"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_test_1 = require("node:test");
const __1 = require("..");
const definition_runner_1 = require("./definition-runner");
const utility_1 = require("./utility");
// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN = [
    {
        "entity": "batch",
        "accessor": "Batch",
        "op": "load",
        "method": "GET",
        "path": "/batch/{batchid}",
        "args": [
            {
                "name": "id",
                "wire": "batchid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": [
            {
                "identifier": "7777777777",
                "created": "Wed Jul 19 2017 20:53:46 GMT+0100 (BST)",
                "destination": 447777777777,
                "messageid": "123456789",
                "batchid": "2586749",
                "deliveryreporturl": "https://your.domain.com/delivery/report/path",
                "content": "My super awesome message",
                "schedule": "Wed Jul 19 2017 20:53:45 GMT+0100 (BST)",
                "sender": "YourCompany",
                "customerid": "0fca8c3c-6cbc-11e7-8154-a6006ad3dba0",
                "modified": "Wed Jul 19 2017 20:53:49 GMT+0100 (BST)",
                "failurereason": {
                    "code": 34,
                    "permanent": false,
                    "details": "Handset error"
                },
                "id": "123456789",
                "tag": "campaign2",
                "keyword": "CALRISSIAN",
                "status": "DELIVERED"
            }
        ],
        "idField": "id"
    },
    {
        "entity": "batch_message",
        "accessor": "BatchMessage",
        "op": "remove",
        "method": "DELETE",
        "path": "/batches/schedule/{batchid}",
        "args": [
            {
                "name": "batchid",
                "wire": "batchid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "messageid": "5620320",
            "status": "CANCELLED"
        },
        "idField": "id"
    },
    {
        "entity": "credit",
        "accessor": "Credit",
        "op": "load",
        "method": "GET",
        "path": "/credits/balance",
        "action": "balance",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "credits": 180
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/message/flash",
        "action": "flash",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 201,
        "sample": {
            "credits": 180,
            "messageid": "123456789",
            "status": "SENT",
            "creditsUsed": 2
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/message/schedule",
        "action": "schedule",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": [
            {
                "messageid": "123456789",
                "status": "SCHEDULED"
            }
        ],
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/message/send",
        "action": "send",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 201,
        "sample": {
            "credits": 180,
            "messageid": "123456789",
            "status": "SENT",
            "creditsUsed": 2
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/messages",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": [
            {
                "identifier": "7777777777",
                "created": "Wed Jul 19 2017 20:53:46 GMT+0100 (BST)",
                "destination": 447777777777,
                "messageid": "123456789",
                "batchid": "2586749",
                "deliveryreporturl": "https://your.domain.com/delivery/report/path",
                "content": "My super awesome message",
                "schedule": "Wed Jul 19 2017 20:53:45 GMT+0100 (BST)",
                "sender": "YourCompany",
                "customerid": "0fca8c3c-6cbc-11e7-8154-a6006ad3dba0",
                "modified": "Wed Jul 19 2017 20:53:49 GMT+0100 (BST)",
                "failurereason": {
                    "code": 34,
                    "permanent": false,
                    "details": "Handset error"
                },
                "id": "123456789",
                "tag": "campaign2",
                "keyword": "CALRISSIAN",
                "status": "DELIVERED"
            }
        ],
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/messages/failed",
        "action": "failed",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": [
            {
                "identifier": "7777777777",
                "created": "Wed Jul 19 2017 20:53:46 GMT+0100 (BST)",
                "destination": 447777777777,
                "messageid": "123456789",
                "batchid": "2586749",
                "deliveryreporturl": "https://your.domain.com/delivery/report/path",
                "content": "My super awesome message",
                "schedule": "Wed Jul 19 2017 20:53:45 GMT+0100 (BST)",
                "sender": "YourCompany",
                "customerid": "0fca8c3c-6cbc-11e7-8154-a6006ad3dba0",
                "modified": "Wed Jul 19 2017 20:53:49 GMT+0100 (BST)",
                "failurereason": {
                    "code": 34,
                    "permanent": false,
                    "details": "Handset error"
                },
                "id": "123456789",
                "tag": "campaign2",
                "keyword": "CALRISSIAN",
                "status": "DELIVERED"
            }
        ],
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "create",
        "method": "POST",
        "path": "/messages/inbox",
        "action": "inbox",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": [
            {
                "identifier": "7777777777",
                "created": "Wed Jul 19 2017 20:53:46 GMT+0100 (BST)",
                "destination": 447777777777,
                "messageid": "123456789",
                "batchid": "2586749",
                "deliveryreporturl": "https://your.domain.com/delivery/report/path",
                "content": "My super awesome message",
                "schedule": "Wed Jul 19 2017 20:53:45 GMT+0100 (BST)",
                "sender": "YourCompany",
                "customerid": "0fca8c3c-6cbc-11e7-8154-a6006ad3dba0",
                "modified": "Wed Jul 19 2017 20:53:49 GMT+0100 (BST)",
                "failurereason": {
                    "code": 34,
                    "permanent": false,
                    "details": "Handset error"
                },
                "id": "123456789",
                "tag": "campaign2",
                "keyword": "CALRISSIAN",
                "status": "DELIVERED"
            }
        ],
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "load",
        "method": "GET",
        "path": "/messages/{messageid}",
        "args": [
            {
                "name": "id",
                "wire": "messageid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "identifier": "7777777777",
            "created": "Wed Jul 19 2017 20:53:46 GMT+0100 (BST)",
            "destination": 447777777777,
            "messageid": "123456789",
            "batchid": "2586749",
            "deliveryreporturl": "https://your.domain.com/delivery/report/path",
            "content": "My super awesome message",
            "schedule": "Wed Jul 19 2017 20:53:45 GMT+0100 (BST)",
            "sender": "YourCompany",
            "customerid": "0fca8c3c-6cbc-11e7-8154-a6006ad3dba0",
            "modified": "Wed Jul 19 2017 20:53:49 GMT+0100 (BST)",
            "failurereason": {
                "code": 34,
                "permanent": false,
                "details": "Handset error"
            },
            "id": "123456789",
            "tag": "campaign2",
            "keyword": "CALRISSIAN",
            "status": "DELIVERED"
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "load",
        "method": "GET",
        "path": "/messages/schedule",
        "action": "schedule",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "batch": true,
            "id": "1910600",
            "message": {
                "sender": "MyCompany",
                "destination": "07777777777",
                "content": "Greetings on schedule!",
                "schedule": "2021-10-28T13:10:00.000Z"
            },
            "status": "PROCESSED"
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "remove",
        "method": "DELETE",
        "path": "/messages/{messageid}",
        "args": [
            {
                "name": "id",
                "wire": "messageid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "messageid": "5620320",
            "status": "DELETED"
        },
        "idField": "id"
    },
    {
        "entity": "message",
        "accessor": "Message",
        "op": "remove",
        "method": "DELETE",
        "path": "/messages/schedule/{messageid}",
        "args": [
            {
                "name": "messageid",
                "wire": "messageid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "messageid": "5620320",
            "status": "CANCELLED"
        },
        "idField": "id"
    },
    {
        "entity": "one_time_password",
        "accessor": "OneTimePassword",
        "op": "load",
        "method": "GET",
        "path": "/otp/{messageid}",
        "args": [
            {
                "name": "messageid",
                "wire": "messageid",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "metadata": {
                "customer_id": "ABC123",
                "cart_id": "XYZ789"
            },
            "expires": "Tue Apr 25 2023 16:57:00 GMT+0100 (British Summer Time)",
            "created": "Tue Apr 25 2023 16:47:00 GMT+0100 (British Summer Time)",
            "destination": "447777000000",
            "modified": "Tue Apr 25 2023 16:49:20 GMT+0100 (British Summer Time)",
            "validity": 300,
            "passcode": 123456,
            "status": "VERIFIED"
        },
        "idField": "id"
    },
    {
        "entity": "util",
        "accessor": "Util",
        "op": "load",
        "method": "GET",
        "path": "/utils/errors/{errorcode}",
        "args": [
            {
                "name": "errorcode",
                "wire": "errorcode",
                "value": "p1"
            }
        ],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": null,
        "idField": "id"
    },
    {
        "entity": "util",
        "accessor": "Util",
        "op": "load",
        "method": "GET",
        "path": "/utils/test",
        "action": "test",
        "args": [],
        "select": {},
        "headers": [],
        "query": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "message": "message"
        },
        "idField": "id"
    }
];
(0, node_test_1.describe)('definition', () => {
    for (const point of PLAN) {
        (0, node_test_1.test)(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
            const control = (0, utility_1.isControlSkipped)('entityOp', point.entity + '.' + point.op, 'definition');
            if (control.skip) {
                t.skip(control.reason || 'skipped via sdk-test-control.json');
                return;
            }
            await (0, definition_runner_1.runDefinitionPoint)(__1.SDK, point);
        });
    }
});
//# sourceMappingURL=definition.test.js.map