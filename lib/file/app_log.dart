import 'dart:io';
import 'dart:developer' as dev;

import 'package:path_provider/path_provider.dart';

class AppLog {
  static Future<void> log(String message) async {
    try {
      final dir = await getApplicationSupportDirectory(); // Safe directory
      final file = File('${dir.path}/fa_simulator_log.txt');
      file.writeAsStringSync('$message\n', mode: FileMode.append);
      dev.log(message, name: 'fa_simulator');
    } on Exception catch (e) {
      throw Exception('Failed to log message: $e');
    }
  }
}
