import '../a_table_holder.dart';
import '../table_holder.dart';
import 'table_source_data.dart';

class TableExample {
  TableExample() {
    initTable();
  }

  void initTable() {
    print('`\n          TableExample.initTable() ');

    final table = TableFormat.table.getValue(tableSource) ?? {};
    tableHolder = TableHolder.fromMap(map: table);

    print(tableHolder.toTree());

    ARow? row = tableHolder.body.firstChild;
    while (row != null) {
      row.printRow();
      row = row.nextSibling as ARow?;
    }
  }

  late final TableHolder tableHolder;
}
