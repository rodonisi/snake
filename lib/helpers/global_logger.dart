// -----------------------------------------------------------------------------
// - Packages
// -----------------------------------------------------------------------------
import 'package:logger/logger.dart';

// -----------------------------------------------------------------------------
// - Logger Declaration
// -----------------------------------------------------------------------------
/// Global logger.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    printEmojis: true,
    printTime: true,
    lineLength: 120,
    colors: true,
  ),
);
