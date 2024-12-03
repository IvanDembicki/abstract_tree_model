import 'a_table_holder.dart';
import 'table_holder.dart';

class TableFooter extends ATable {
  TableFooter({required super.parent});

  factory TableFooter.fromMap({
    required TableHolder parent,
    required Map<String, dynamic> map,
  }) {
    final result = TableFooter(parent: parent);
    final rows = TableFormat.rows.getValue(map) as List? ?? [];
    for (var i = 0; i < rows.length; i++) {
      FooterRow.fromMap(parent: result, map: rows[i]);
    }
    return result;
  }
}

class FooterRow extends ARow {
  FooterRow({required super.parent});

  factory FooterRow.fromMap({
    required TableFooter parent,
    required Map<String, Object> map,
  }) {
    final row = FooterRow(parent: parent);
    final cells = TableFormat.cells.getValue(map) as List? ?? [];
    for (var i = 0; i < cells.length; i++) {
      final cell = cells[i] as Map<String, dynamic>;
      FooterCell.fromMap(parent: row, map: cell);
    }
    return row;
  }

  double get averageAge => getAncestor<TableHolder>()!.averageAge;
}

class FooterCell extends ACell {
  FooterCell({
    required super.parent,
    required super.id,
    required super.value,
  });

  factory FooterCell.fromMap({
    required FooterRow parent,
    required Map<String, dynamic> map,
  }) {
    final id = '${TableFormat.id.getValue(map)}';
    String age = '';
    if (id == 'age') {
      double averageAge = parent.averageAge;
      age = averageAge.toStringAsFixed(1);
      print('FooterCell.fromMap() average age: $age ');
    }
    return FooterCell(parent: parent, id: id, value: age);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      TreeFormat.type.key: '$runtimeType',
      TableFormat.id.name: id,
      TableFormat.value.name: value
    };
  }
}
