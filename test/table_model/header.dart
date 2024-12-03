import 'a_table_holder.dart';
import 'table_holder.dart';

class TableHeader extends ATable {
  TableHeader({required super.parent});

  factory TableHeader.fromMap({
    required TableHolder parent,
    required Map<String, dynamic> map,
  }) {
    final result = TableHeader(parent: parent);
    final rows = TableFormat.rows.getValue(map) as List? ?? [];
    for (var i = 0; i < rows.length; i++) {
      HeaderRow.fromMap(parent: result, map: rows[i]);
    }
    return result;
  }
}

class HeaderRow extends ARow {
  HeaderRow({required super.parent});

  factory HeaderRow.fromMap({
    required TableHeader parent,
    required Map<String, dynamic> map,
  }) {
    final row = HeaderRow(parent: parent);
    final cells = TableFormat.cells.getValue(map) as List? ?? [];
    for (var i = 0; i < cells.length; i++) {
      HeaderCell.fromMap(parent: row, cell: cells[i]);
    }
    return row;
  }
}

class HeaderCell extends ACell {
  HeaderCell({
    required super.parent,
    required super.id,
    required super.value,
  });

  factory HeaderCell.fromMap({
    required HeaderRow parent,
    required Map<String, dynamic> cell,
  }) {
    final id = cell[TableFormat.id.name];
    final value = cell[TableFormat.value.name];
    return HeaderCell(parent: parent, id: id, value: value);
  }
}
