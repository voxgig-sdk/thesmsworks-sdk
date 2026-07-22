// Thesmsworks SDK test suite entry. GENERATED — do not edit.

import 'dart:io';

import 'harness.dart' as harness;

import 'exists_test.dart' as exists_test;
import 'struct_test.dart' as struct_test;
import 'primary_test.dart' as primary_test;
import 'pipeline_test.dart' as pipeline_test;
import 'feature_test.dart' as feature_test;
import 'netsim_test.dart' as netsim_test;
import 'custom_test.dart' as custom_test;
import 'readme_examples_test.dart' as readme_examples_test;
import 'entity/batch/BatchEntity_test.dart' as batch_entity_test;
import 'entity/batch/BatchDirect_test.dart' as batch_direct_test;
import 'entity/batch_message/BatchMessageEntity_test.dart' as batch_message_entity_test;
import 'entity/credit/CreditEntity_test.dart' as credit_entity_test;
import 'entity/credit/CreditDirect_test.dart' as credit_direct_test;
import 'entity/flash/FlashEntity_test.dart' as flash_entity_test;
import 'entity/message/MessageEntity_test.dart' as message_entity_test;
import 'entity/message/MessageDirect_test.dart' as message_direct_test;
import 'entity/one_time_password/OneTimePasswordEntity_test.dart' as one_time_password_entity_test;
import 'entity/one_time_password/OneTimePasswordDirect_test.dart' as one_time_password_direct_test;
import 'entity/schedule/ScheduleEntity_test.dart' as schedule_entity_test;
import 'entity/swagger/SwaggerEntity_test.dart' as swagger_entity_test;
import 'entity/util/UtilEntity_test.dart' as util_entity_test;
import 'entity/util/UtilDirect_test.dart' as util_direct_test;

Future<void> main() async {
  exists_test.tests();
  struct_test.tests();
  primary_test.tests();
  pipeline_test.tests();
  feature_test.tests();
  netsim_test.tests();
  custom_test.tests();
  readme_examples_test.tests();
  batch_entity_test.tests();
  batch_direct_test.tests();
  batch_message_entity_test.tests();
  credit_entity_test.tests();
  credit_direct_test.tests();
  flash_entity_test.tests();
  message_entity_test.tests();
  message_direct_test.tests();
  one_time_password_entity_test.tests();
  one_time_password_direct_test.tests();
  schedule_entity_test.tests();
  swagger_entity_test.tests();
  util_entity_test.tests();
  util_direct_test.tests();

  final failed = await harness.runAll();
  if (0 < failed) {
    exitCode = 1;
  }
}
