package voxgig.thesmsworkssdk.core;

// Typed reference models for the Thesmsworks SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Map<String, Object> / Object) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a boxed (nullable)
// type, so an optional (req:false) key needs no distinct rendering.

import java.util.List;
import java.util.Map;

public final class ThesmsworksTypes {

  private ThesmsworksTypes() {}

  public record Batch() {}

  public record BatchLoadMatch(String id) {}

  public record BatchMessage(Boolean ai, String content, String deliveryreporturl, List<Object> destination, String schedule, String sender, String tag, Double ttl, Double validity) {}

  public record BatchMessageCreateData(Boolean ai, String content, String deliveryreporturl, List<Object> destination, String schedule, String sender, String tag, Double ttl, Double validity) {}

  public record BatchMessageRemoveMatch(String batchid) {}

  public record Credit() {}

  public record CreditLoadMatch() {}

  public record Flash() {}

  public record Message(Boolean ai, String content, Double credit, String deliveryreporturl, String destination, String from, String keyword, Double limit, Map<String, Object> metadata, List<Object> responseemail, String schedule, String sender, Double skip, String status, String tag, String to, Double ttl, Boolean unread, Double validity) {}

  public record MessageLoadMatch(String id) {}

  public record MessageCreateData(Boolean ai, String content, Double credit, String deliveryreporturl, String destination, String from, String keyword, Double limit, Map<String, Object> metadata, List<Object> responseemail, String schedule, String sender, Double skip, String status, String tag, String to, Double ttl, Boolean unread, Double validity) {}

  public record MessageRemoveMatch(String id, String messageid) {}

  public record OneTimePassword(String destination, Map<String, Object> length, Map<String, Object> metadata, String passcode, String sender, String template, Double validity) {}

  public record OneTimePasswordLoadMatch(String messageid) {}

  public record OneTimePasswordCreateData(String destination, Map<String, Object> length, Map<String, Object> metadata, String passcode, String sender, String template, Double validity) {}

  public record Schedule() {}

  public record Swagger() {}

  public record Util() {}

  public record UtilLoadMatch(String errorcode) {}

}
