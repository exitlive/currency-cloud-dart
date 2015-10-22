import '../lib/currency_cloud.dart';

import 'package:logging/logging.dart';

main() async {
  setupLogging();


  var cc = CurrencyCloud.getInstance();
  await cc.authenticate(loginId, apiKey);
}

setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
