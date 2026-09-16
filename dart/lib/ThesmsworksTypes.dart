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
  /// STRING
  String? id;

  Batch({
    this.id,
  });

  factory Batch.fromMap(Map<String, dynamic> m) => Batch(
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
  List<dynamic>? destinations;
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
    this.destinations,
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
        destinations: m['destinations'] is List<dynamic> ? m['destinations'] : null,
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
    if (null != destinations) {
      m['destinations'] = destinations;
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
  List<dynamic>? destinations;
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
    this.destinations,
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
        destinations: m['destinations'] is List<dynamic> ? m['destinations'] : null,
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
    if (null != destinations) {
      m['destinations'] = destinations;
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
  /// NUMBER
  num? credits;
  /// STRING
  String? destination;
  /// STRING
  String? from;
  /// STRING
  String? id;
  /// STRING
  String? keyword;
  /// NUMBER
  num? limit;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// STRING
  String? sender;
  /// NUMBER
  num? skip;
  /// STRING
  String? status;
  /// STRING
  String? to;
  /// BOOLEAN
  bool? unread;

  Message({
    this.credits,
    this.destination,
    this.from,
    this.id,
    this.keyword,
    this.limit,
    this.metadata,
    this.sender,
    this.skip,
    this.status,
    this.to,
    this.unread,
  });

  factory Message.fromMap(Map<String, dynamic> m) => Message(
        credits: m['credits'] is num ? m['credits'] : null,
        destination: m['destination'] is String ? m['destination'] : null,
        from: m['from'] is String ? m['from'] : null,
        id: m['id'] is String ? m['id'] : null,
        keyword: m['keyword'] is String ? m['keyword'] : null,
        limit: m['limit'] is num ? m['limit'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        skip: m['skip'] is num ? m['skip'] : null,
        status: m['status'] is String ? m['status'] : null,
        to: m['to'] is String ? m['to'] : null,
        unread: m['unread'] is bool ? m['unread'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != credits) {
      m['credits'] = credits;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != from) {
      m['from'] = from;
    }
    if (null != id) {
      m['id'] = id;
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
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != skip) {
      m['skip'] = skip;
    }
    if (null != status) {
      m['status'] = status;
    }
    if (null != to) {
      m['to'] = to;
    }
    if (null != unread) {
      m['unread'] = unread;
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
  /// NUMBER
  num? credits;
  /// STRING
  String? destination;
  /// STRING
  String? from;
  /// STRING
  String? id;
  /// STRING
  String? keyword;
  /// NUMBER
  num? limit;
  /// OBJECT
  Map<String, dynamic>? metadata;
  /// STRING
  String? sender;
  /// NUMBER
  num? skip;
  /// STRING
  String? status;
  /// STRING
  String? to;
  /// BOOLEAN
  bool? unread;

  MessageCreateData({
    this.credits,
    this.destination,
    this.from,
    this.id,
    this.keyword,
    this.limit,
    this.metadata,
    this.sender,
    this.skip,
    this.status,
    this.to,
    this.unread,
  });

  factory MessageCreateData.fromMap(Map<String, dynamic> m) => MessageCreateData(
        credits: m['credits'] is num ? m['credits'] : null,
        destination: m['destination'] is String ? m['destination'] : null,
        from: m['from'] is String ? m['from'] : null,
        id: m['id'] is String ? m['id'] : null,
        keyword: m['keyword'] is String ? m['keyword'] : null,
        limit: m['limit'] is num ? m['limit'] : null,
        metadata: m['metadata'] is Map<String, dynamic> ? m['metadata'] : null,
        sender: m['sender'] is String ? m['sender'] : null,
        skip: m['skip'] is num ? m['skip'] : null,
        status: m['status'] is String ? m['status'] : null,
        to: m['to'] is String ? m['to'] : null,
        unread: m['unread'] is bool ? m['unread'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != credits) {
      m['credits'] = credits;
    }
    if (null != destination) {
      m['destination'] = destination;
    }
    if (null != from) {
      m['from'] = from;
    }
    if (null != id) {
      m['id'] = id;
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
    if (null != sender) {
      m['sender'] = sender;
    }
    if (null != skip) {
      m['skip'] = skip;
    }
    if (null != status) {
      m['status'] = status;
    }
    if (null != to) {
      m['to'] = to;
    }
    if (null != unread) {
      m['unread'] = unread;
    }
    return m;
  }
}

class MessageRemoveMatch {
  /// STRING (required at the API)
  String? id;

  MessageRemoveMatch({
    this.id,
  });

  factory MessageRemoveMatch.fromMap(Map<String, dynamic> m) => MessageRemoveMatch(
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

