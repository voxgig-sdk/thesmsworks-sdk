// Typed models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON).
// Do not edit by hand.
//
// The operation pipeline passes plain maps; these classes are the typed,
// convertible view: `Thesmsworks.fromMap(ent.data())` / `model.toMap()`.

class Batch {
  Batch();

  factory Batch.fromMap(Map<String, dynamic> m) => Batch();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class BatchLoadMatch {
  /// STRING (required at the API)
  String? id;

  BatchLoadMatch({
    this.id,
  });

  factory BatchLoadMatch.fromMap(Map<String, dynamic> m) => BatchLoadMatch(
        id: m['id'] is String ? m['id'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != id) {
      m['id'] = id;
    }
    return m;
  }
}

class BatchMessage {
  /// BOOLEAN
  bool? ai;
  /// STRING (required at the API)
  String? content;
  /// STRING
  String? deliveryreporturl;
  /// ARRAY (required at the API)
  List<dynamic>? destination;
  /// STRING
  String? schedule;
  /// STRING (required at the API)
  String? sender;
  /// STRING
  String? tag;
  /// NUMBER
  num? ttl;
  /// NUMBER
  num? validity;

  BatchMessage({
    this.ai,
    this.content,
    this.deliveryreporturl,
    this.destination,
    this.schedule,
    this.sender,
    this.tag,
    this.ttl,
    this.validity,
  });

  factory BatchMessage.fromMap(Map<String, dynamic> m) => BatchMessage(
        ai: m['ai'] is bool ? m['ai'] : null,
        content: m['content'] is String ? m['content'] : null,
        deliveryreporturl: m['deliveryreporturl'] is String ? m['deliveryreporturl'] : null,
        destination: m['destination'] is List<dynamic> ? m['destination'] : null,
        schedule: m['schedule'] is String ? m['schedule'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        tag: m['tag'] is String ? m['tag'] : null,
        ttl: m['ttl'] is num ? m['ttl'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != ai) {
      m['ai'] = ai;
    }
    if (null != content) {
      m['content'] = content;
    }
    if (null != deliveryreporturl) {
      m['deliveryreporturl'] = deliveryreporturl;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != schedule) {
      m['schedule'] = schedule;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != tag) {
      m['tag'] = tag;
    }
    if (null != ttl) {
      m['ttl'] = ttl;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class BatchMessageCreateData {
  /// BOOLEAN
  bool? ai;
  /// STRING (required at the API)
  String? content;
  /// STRING
  String? deliveryreporturl;
  /// ARRAY (required at the API)
  List<dynamic>? destination;
  /// STRING
  String? schedule;
  /// STRING (required at the API)
  String? sender;
  /// STRING
  String? tag;
  /// NUMBER
  num? ttl;
  /// NUMBER
  num? validity;

  BatchMessageCreateData({
    this.ai,
    this.content,
    this.deliveryreporturl,
    this.destination,
    this.schedule,
    this.sender,
    this.tag,
    this.ttl,
    this.validity,
  });

  factory BatchMessageCreateData.fromMap(Map<String, dynamic> m) => BatchMessageCreateData(
        ai: m['ai'] is bool ? m['ai'] : null,
        content: m['content'] is String ? m['content'] : null,
        deliveryreporturl: m['deliveryreporturl'] is String ? m['deliveryreporturl'] : null,
        destination: m['destination'] is List<dynamic> ? m['destination'] : null,
        schedule: m['schedule'] is String ? m['schedule'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        tag: m['tag'] is String ? m['tag'] : null,
        ttl: m['ttl'] is num ? m['ttl'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != ai) {
      m['ai'] = ai;
    }
    if (null != content) {
      m['content'] = content;
    }
    if (null != deliveryreporturl) {
      m['deliveryreporturl'] = deliveryreporturl;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != schedule) {
      m['schedule'] = schedule;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != tag) {
      m['tag'] = tag;
    }
    if (null != ttl) {
      m['ttl'] = ttl;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class BatchMessageRemoveMatch {
  /// STRING (required at the API)
  String? batchid;

  BatchMessageRemoveMatch({
    this.batchid,
  });

  factory BatchMessageRemoveMatch.fromMap(Map<String, dynamic> m) => BatchMessageRemoveMatch(
        batchid: m['batchid'] is String ? m['batchid'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batchid) {
      m['batchid'] = batchid;
    }
    return m;
  }
}

class Credit {
  Credit();

  factory Credit.fromMap(Map<String, dynamic> m) => Credit();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class CreditLoadMatch {
  CreditLoadMatch();

  factory CreditLoadMatch.fromMap(Map<String, dynamic> m) => CreditLoadMatch();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class Flash {
  Flash();

  factory Flash.fromMap(Map<String, dynamic> m) => Flash();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class Message {
  /// BOOLEAN
  bool? ai;
  /// STRING (required at the API)
  String? content;
  /// NUMBER
  num? credit;
  /// STRING
  String? deliveryreporturl;
  /// STRING (required at the API)
  String? destination;
  /// STRING
  String? from;
  /// STRING
  String? keyword;
  /// NUMBER
  num? limit;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// ARRAY
  List<dynamic>? responseemail;
  /// STRING
  String? schedule;
  /// STRING (required at the API)
  String? sender;
  /// NUMBER
  num? skip;
  /// STRING
  String? status;
  /// STRING
  String? tag;
  /// STRING
  String? to;
  /// NUMBER
  num? ttl;
  /// BOOLEAN
  bool? unread;
  /// NUMBER
  num? validity;

  Message({
    this.ai,
    this.content,
    this.credit,
    this.deliveryreporturl,
    this.destination,
    this.from,
    this.keyword,
    this.limit,
    this.metadata,
    this.responseemail,
    this.schedule,
    this.sender,
    this.skip,
    this.status,
    this.tag,
    this.to,
    this.ttl,
    this.unread,
    this.validity,
  });

  factory Message.fromMap(Map<String, dynamic> m) => Message(
        ai: m['ai'] is bool ? m['ai'] : null,
        content: m['content'] is String ? m['content'] : null,
        credit: m['credit'] is num ? m['credit'] : null,
        deliveryreporturl: m['deliveryreporturl'] is String ? m['deliveryreporturl'] : null,
        destination: m['destination'] is String ? m['destination'] : null,
        from: m['from'] is String ? m['from'] : null,
        keyword: m['keyword'] is String ? m['keyword'] : null,
        limit: m['limit'] is num ? m['limit'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        responseemail: m['responseemail'] is List<dynamic> ? m['responseemail'] : null,
        schedule: m['schedule'] is String ? m['schedule'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        skip: m['skip'] is num ? m['skip'] : null,
        status: m['status'] is String ? m['status'] : null,
        tag: m['tag'] is String ? m['tag'] : null,
        to: m['to'] is String ? m['to'] : null,
        ttl: m['ttl'] is num ? m['ttl'] : null,
        unread: m['unread'] is bool ? m['unread'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != ai) {
      m['ai'] = ai;
    }
    if (null != content) {
      m['content'] = content;
    }
    if (null != credit) {
      m['credit'] = credit;
    }
    if (null != deliveryreporturl) {
      m['deliveryreporturl'] = deliveryreporturl;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != from) {
      m['from'] = from;
    }
    if (null != keyword) {
      m['keyword'] = keyword;
    }
    if (null != limit) {
      m['limit'] = limit;
    }
    if (null != metadata) {
      m['metadata'] = metadata;
    }
    if (null != responseemail) {
      m['responseemail'] = responseemail;
    }
    if (null != schedule) {
      m['schedule'] = schedule;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != skip) {
      m['skip'] = skip;
    }
    if (null != status) {
      m['status'] = status;
    }
    if (null != tag) {
      m['tag'] = tag;
    }
    if (null != to) {
      m['to'] = to;
    }
    if (null != ttl) {
      m['ttl'] = ttl;
    }
    if (null != unread) {
      m['unread'] = unread;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class MessageLoadMatch {
  /// STRING (required at the API)
  String? id;

  MessageLoadMatch({
    this.id,
  });

  factory MessageLoadMatch.fromMap(Map<String, dynamic> m) => MessageLoadMatch(
        id: m['id'] is String ? m['id'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != id) {
      m['id'] = id;
    }
    return m;
  }
}

class MessageCreateData {
  /// BOOLEAN
  bool? ai;
  /// STRING (required at the API)
  String? content;
  /// NUMBER
  num? credit;
  /// STRING
  String? deliveryreporturl;
  /// STRING (required at the API)
  String? destination;
  /// STRING
  String? from;
  /// STRING
  String? keyword;
  /// NUMBER
  num? limit;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// ARRAY
  List<dynamic>? responseemail;
  /// STRING
  String? schedule;
  /// STRING (required at the API)
  String? sender;
  /// NUMBER
  num? skip;
  /// STRING
  String? status;
  /// STRING
  String? tag;
  /// STRING
  String? to;
  /// NUMBER
  num? ttl;
  /// BOOLEAN
  bool? unread;
  /// NUMBER
  num? validity;

  MessageCreateData({
    this.ai,
    this.content,
    this.credit,
    this.deliveryreporturl,
    this.destination,
    this.from,
    this.keyword,
    this.limit,
    this.metadata,
    this.responseemail,
    this.schedule,
    this.sender,
    this.skip,
    this.status,
    this.tag,
    this.to,
    this.ttl,
    this.unread,
    this.validity,
  });

  factory MessageCreateData.fromMap(Map<String, dynamic> m) => MessageCreateData(
        ai: m['ai'] is bool ? m['ai'] : null,
        content: m['content'] is String ? m['content'] : null,
        credit: m['credit'] is num ? m['credit'] : null,
        deliveryreporturl: m['deliveryreporturl'] is String ? m['deliveryreporturl'] : null,
        destination: m['destination'] is String ? m['destination'] : null,
        from: m['from'] is String ? m['from'] : null,
        keyword: m['keyword'] is String ? m['keyword'] : null,
        limit: m['limit'] is num ? m['limit'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        responseemail: m['responseemail'] is List<dynamic> ? m['responseemail'] : null,
        schedule: m['schedule'] is String ? m['schedule'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        skip: m['skip'] is num ? m['skip'] : null,
        status: m['status'] is String ? m['status'] : null,
        tag: m['tag'] is String ? m['tag'] : null,
        to: m['to'] is String ? m['to'] : null,
        ttl: m['ttl'] is num ? m['ttl'] : null,
        unread: m['unread'] is bool ? m['unread'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != ai) {
      m['ai'] = ai;
    }
    if (null != content) {
      m['content'] = content;
    }
    if (null != credit) {
      m['credit'] = credit;
    }
    if (null != deliveryreporturl) {
      m['deliveryreporturl'] = deliveryreporturl;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != from) {
      m['from'] = from;
    }
    if (null != keyword) {
      m['keyword'] = keyword;
    }
    if (null != limit) {
      m['limit'] = limit;
    }
    if (null != metadata) {
      m['metadata'] = metadata;
    }
    if (null != responseemail) {
      m['responseemail'] = responseemail;
    }
    if (null != schedule) {
      m['schedule'] = schedule;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != skip) {
      m['skip'] = skip;
    }
    if (null != status) {
      m['status'] = status;
    }
    if (null != tag) {
      m['tag'] = tag;
    }
    if (null != to) {
      m['to'] = to;
    }
    if (null != ttl) {
      m['ttl'] = ttl;
    }
    if (null != unread) {
      m['unread'] = unread;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class MessageRemoveMatch {
  /// STRING
  String? id;
  /// STRING
  String? messageid;

  MessageRemoveMatch({
    this.id,
    this.messageid,
  });

  factory MessageRemoveMatch.fromMap(Map<String, dynamic> m) => MessageRemoveMatch(
        id: m['id'] is String ? m['id'] : null,
        messageid: m['messageid'] is String ? m['messageid'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != id) {
      m['id'] = id;
    }
    if (null != messageid) {
      m['messageid'] = messageid;
    }
    return m;
  }
}

class OneTimePassword {
  /// STRING
  String? destination;
  /// OBJECT
  Map<String, dynamic>? length;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// STRING
  String? passcode;
  /// STRING
  String? sender;
  /// STRING
  String? template;
  /// NUMBER
  num? validity;

  OneTimePassword({
    this.destination,
    this.length,
    this.metadata,
    this.passcode,
    this.sender,
    this.template,
    this.validity,
  });

  factory OneTimePassword.fromMap(Map<String, dynamic> m) => OneTimePassword(
        destination: m['destination'] is String ? m['destination'] : null,
        length: m['length'] is Map<String, dynamic> ? m['length'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        passcode: m['passcode'] is String ? m['passcode'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        template: m['template'] is String ? m['template'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != length) {
      m['length'] = length;
    }
    if (null != metadata) {
      m['metadata'] = metadata;
    }
    if (null != passcode) {
      m['passcode'] = passcode;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != template) {
      m['template'] = template;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class OneTimePasswordLoadMatch {
  /// STRING (required at the API)
  String? messageid;

  OneTimePasswordLoadMatch({
    this.messageid,
  });

  factory OneTimePasswordLoadMatch.fromMap(Map<String, dynamic> m) => OneTimePasswordLoadMatch(
        messageid: m['messageid'] is String ? m['messageid'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != messageid) {
      m['messageid'] = messageid;
    }
    return m;
  }
}

class OneTimePasswordCreateData {
  /// STRING
  String? destination;
  /// OBJECT
  Map<String, dynamic>? length;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// STRING
  String? passcode;
  /// STRING
  String? sender;
  /// STRING
  String? template;
  /// NUMBER
  num? validity;

  OneTimePasswordCreateData({
    this.destination,
    this.length,
    this.metadata,
    this.passcode,
    this.sender,
    this.template,
    this.validity,
  });

  factory OneTimePasswordCreateData.fromMap(Map<String, dynamic> m) => OneTimePasswordCreateData(
        destination: m['destination'] is String ? m['destination'] : null,
        length: m['length'] is Map<String, dynamic> ? m['length'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        passcode: m['passcode'] is String ? m['passcode'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        template: m['template'] is String ? m['template'] : null,
        validity: m['validity'] is num ? m['validity'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != length) {
      m['length'] = length;
    }
    if (null != metadata) {
      m['metadata'] = metadata;
    }
    if (null != passcode) {
      m['passcode'] = passcode;
    }
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != template) {
      m['template'] = template;
    }
    if (null != validity) {
      m['validity'] = validity;
    }
    return m;
  }
}

class Schedule {
  Schedule();

  factory Schedule.fromMap(Map<String, dynamic> m) => Schedule();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class Swagger {
  Swagger();

  factory Swagger.fromMap(Map<String, dynamic> m) => Swagger();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class Util {
  Util();

  factory Util.fromMap(Map<String, dynamic> m) => Util();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class UtilLoadMatch {
  /// STRING (required at the API)
  String? errorcode;

  UtilLoadMatch({
    this.errorcode,
  });

  factory UtilLoadMatch.fromMap(Map<String, dynamic> m) => UtilLoadMatch(
        errorcode: m['errorcode'] is String ? m['errorcode'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != errorcode) {
      m['errorcode'] = errorcode;
    }
    return m;
  }
}

