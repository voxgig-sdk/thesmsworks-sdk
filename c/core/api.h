// Thesmsworks SDK public API (generated).

#ifndef THESMSWORKS_API_H
#define THESMSWORKS_API_H

#include "sdk.h"

// Batch entity.
Entity* batch_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_batch(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* batch_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// BatchMessage entity.
Entity* batch_message_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_batch_message(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* batch_message_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Credit entity.
Entity* credit_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_credit(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* credit_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Flash entity.
Entity* flash_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_flash(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* flash_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Message entity.
Entity* message_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_message(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* message_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// OneTimePassword entity.
Entity* one_time_password_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_one_time_password(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* one_time_password_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Schedule entity.
Entity* schedule_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_schedule(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* schedule_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Swagger entity.
Entity* swagger_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_swagger(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* swagger_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Util entity.
Entity* util_entity_new(ThesmsworksSDK* client, voxgig_value* entopts);
Entity* thesmsworks_util(ThesmsworksSDK* client, voxgig_value* entopts);
voxgig_value* util_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // THESMSWORKS_API_H
