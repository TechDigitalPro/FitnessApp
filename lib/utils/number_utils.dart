import 'package:intl/intl.dart';

String formattedNumberKm (double numberToFormat){
  var formattedNumber = NumberFormat.decimalPattern().format(numberToFormat);
  return formattedNumber;
}