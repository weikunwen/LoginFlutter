import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(),);
int getCurrentTimeSecond(){
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}


