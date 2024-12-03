import 'a_table_holder.dart';
import 'body.dart';
import 'footer.dart';
import 'header.dart';

class TableHolder extends ATableHolder {
  static TableHolder fromMap({
    required Map<String, dynamic> map,
  }) {
    final holder = TableHolder();

    final headerMap = TableFormat.header.getValue(map) as Map<String, dynamic>? ?? {};
    final bodyMap = TableFormat.body.getValue(map) as Map<String, dynamic>? ?? {};
    final footerMap = TableFormat.footer.getValue(map) as Map<String, dynamic>? ?? {};

    holder.header = TableHeader.fromMap(parent: holder, map: headerMap);
    holder.body = TableBody.fromMap(parent: holder, map: bodyMap);
    holder.footer = TableFooter.fromMap(parent: holder, map: footerMap);
    return holder;
  }

  late final TableHeader header;
  late final TableFooter footer;
  late final TableBody body;

  double get averageAge => body.averageAge;
}