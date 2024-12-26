import 'package:intl/intl.dart';

class HumanFormats {
  static String Humanformats(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      locale: 'en',
      symbol: '',
    ).format(number);

    return formattedNumber;
  }
}
