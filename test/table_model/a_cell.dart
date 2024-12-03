import 'a_table_holder.dart';

abstract class ACell extends AChild<ARow> {
  ACell({
    required super.parent,
    required this.id,
    required this.value,
  });

  final String id;
  final dynamic value;

  @override
  Map<String, dynamic> toJson() {
    return {
      TreeFormat.type.key: '$runtimeType',
      TableFormat.id.name: id,
      TableFormat.value.name: value
    };
  }
}
