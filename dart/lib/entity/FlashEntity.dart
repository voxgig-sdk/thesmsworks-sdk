
// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import '../ThesmsworksEntityBase.dart';
import '../utility/ErrUtility.dart';

// Typed models: see ../ThesmsworksTypes.dart (Flash and the per-op request/match types).
class FlashEntity extends ThesmsworksEntityBase {
  FlashEntity(dynamic client, dynamic entopts) : super(client, entopts) {
    name = 'flash';
    name_ = 'flash';
    Name = 'Flash';
  }

  FlashEntity make() {
    return FlashEntity(client, entopts());
  }





}
