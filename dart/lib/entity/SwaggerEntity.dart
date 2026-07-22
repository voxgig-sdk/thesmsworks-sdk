
// ignore_for_file: non_constant_identifier_names

import '../ThesmsworksEntityBase.dart';

// Typed models: see ../ThesmsworksTypes.dart (Swagger and the per-op request/match types).
class SwaggerEntity extends ThesmsworksEntityBase {
  SwaggerEntity(dynamic client, dynamic entopts) : super(client, entopts) {
    name = 'swagger';
    name_ = 'swagger';
    Name = 'Swagger';
  }

  SwaggerEntity make() {
    return SwaggerEntity(client, entopts());
  }





}
