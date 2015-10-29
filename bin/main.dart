import '../lib/currency_cloud.dart';

import 'package:logging/logging.dart';

import '../config/config.dart';

main() async {
  setupLogging();

  var loginId = config.loginId;
  var apiKey = config.apiKey;

  var cc = CurrencyCloud.getInstance();
  await cc.authenticate(loginId, apiKey);
}

setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
