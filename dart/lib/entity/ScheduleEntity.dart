
// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import '../ThesmsworksEntityBase.dart';
import '../utility/ErrUtility.dart';

// Typed models: see ../ThesmsworksTypes.dart (Schedule and the per-op request/match types).
class ScheduleEntity extends ThesmsworksEntityBase {
  ScheduleEntity(dynamic client, dynamic entopts) : super(client, entopts) {
    name = 'schedule';
    name_ = 'schedule';
    Name = 'Schedule';
  }

  ScheduleEntity make() {
    return ScheduleEntity(client, entopts());
  }





}
