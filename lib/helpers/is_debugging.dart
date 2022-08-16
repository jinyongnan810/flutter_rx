import 'package:flutter/foundation.dart' show kDebugMode;

extension IsDebugging on String {
  String? get isDebugging => kDebugMode ? this : null;
}
