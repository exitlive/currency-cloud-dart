library currency_cloud.test;

import 'package:currency_cloud/currency_cloud.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../config/config.dart';
import 'src/mock_client.dart';
import 'dart:async';
import 'package:logging/logging.dart';

part 'src/authenticate_api_test.dart';
part 'src/rates_api_test.dart';
part 'src/conversion_api_test.dart';
part 'src/integration_test.dart';

void main() {
  authenticate_api_test();
  rates_api_test();
  conversion_api_test();

  integration_test();
}
