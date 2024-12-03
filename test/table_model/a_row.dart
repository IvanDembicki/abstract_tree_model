import 'id_map.dart';
import 'a_table_holder.dart';

abstract class ARow extends ANode<ATable, ACell> with IdMap<ACell> {
  ARow({required super.parent});

  @override
  void addChild(ACell child) {
    registerId(child.id, child);
    super.addChild(child);
  }

  @override
  bool removeChild(ACell child) {
    removeId(child.id);
    return super.removeChild(child);
  }

  void printRow() {
    print('ARow.printRow() : $runtimeType');
  }
}
