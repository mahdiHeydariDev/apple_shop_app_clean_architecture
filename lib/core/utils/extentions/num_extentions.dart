import 'package:intl/intl.dart';

extension PriceFormater on num {
  String priceSeparator() {
    final NumberFormat formater = NumberFormat('###,###,###');
    String result = formater.format(this);
    return result;
  }
}
