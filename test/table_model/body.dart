import 'a_table_holder.dart';
import 'table_holder.dart';

class TableBody extends ATable {
  TableBody({required super.parent});

  factory TableBody.fromMap({
    required TableHolder parent,
    required Map<String, dynamic> map,
  }) {
    final result = TableBody(parent: parent);
    final rows = TableFormat.rows.getValue(map) as List? ?? [];
    for (var i = 0; i < rows.length; i++) {
      BodyRow.fromMap(parent: result, map: rows[i]);
    }
    return result;
  }

  double get averageAge {
    int counter = 0;
    double sum = 0;
    for (var i = 0; i < children.length; i++) {
      final row = children[i];
      final ageCell = row.getById('age');
      if (ageCell != null) {
        double age = double.tryParse('${ageCell.value}') ?? 0.0;
        if (age > 0) {
          counter++;
          sum += age;
        }
      }
    }
    if (counter == 0) return 0;
    return sum / counter;
  }
}

class BodyRow extends ARow {
  BodyRow({required super.parent});

  factory BodyRow.fromMap({
    required TableBody parent,
    required Map<String, Object> map,
  }) {
    final row = BodyRow(parent: parent);
    final cells = TableFormat.cells.getValue(map) as List? ?? [];
    for (var i = 0; i < cells.length; i++) {
      BodyCell.fromMap(parent: row, map: cells[i]);
    }
    return row;
  }
}

class BodyCell extends ACell {
  BodyCell({
    required super.parent,
    required super.id,
    required super.value,
  });

  factory BodyCell.fromMap({
    required BodyRow parent,
    required Map<String, dynamic> map,
  }) {
    final id = TableFormat.id.getValue(map);
    final value = TableFormat.value.getValue(map);
    return BodyCell(parent: parent, id: id, value: value);
  }
}
