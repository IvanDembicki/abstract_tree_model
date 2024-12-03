import 'package:flutter_test/flutter_test.dart';

import 'table_model/a_table_holder.dart';
import 'table_model/body.dart';
import 'table_model/footer.dart';
import 'table_model/header.dart';
import 'table_model/table_holder.dart';
import 'table_model/usage/table_example.dart';

void main() {
  // Test Abstract Tree model
  // Also see the output
  final example = TableExample();
  final holder = example.tableHolder;
  final header = holder.header;
  final body = holder.body;
  final footer = holder.footer;

  // Data Model Tree typed access
  test('Holder - root of the table tree', () {
    expect(holder is ATreeMember, true);
    expect(holder is ANode, false);
    expect(holder is AParent, true);
    expect(holder is AChild, false);
    expect(holder is ATableHolder, true);
    expect(holder is TableHolder, true);
  });

  test('Header of the table', () {
    expect(header is ATreeMember, true);
    expect(header is ANode, true);
    expect(header is AParent, true);
    expect(header is AChild, true);
    expect(header is ATable, true);
    expect(header is TableHeader, true);
  });

  test('Body of the table', () {
    expect(body is ATreeMember, true);
    expect(body is ANode, true);
    expect(body is AParent, true);
    expect(body is AChild, true);
    expect(body is ATable, true);
    expect(body is TableBody, true);
  });

  test('Footer of the table', () {
    expect(footer is ATreeMember, true);
    expect(footer is ANode, true);
    expect(footer is AParent, true);
    expect(footer is AChild, true);
    expect(footer is ATable, true);
    expect(footer is TableFooter, true);
  });

  test('Type of the children of the HeaderRow', () {
    expect(header.firstChild is ATreeMember, true);
    expect(header.firstChild is ANode, true);
    expect(header.firstChild is AChild, true);
    expect(header.firstChild is AParent, true);
    expect(header.firstChild is ARow, true);
    expect(header.firstChild is HeaderRow, true);
  });

  test('Type of the children of the BodyRow', () {
    // The ancestors of ARow are the same as in HeaderRow test
    expect(body.firstChild is ARow, true);
    expect(body.firstChild is BodyRow, true);
  });

  test('Type of the children of the FooterRow', () {
    // The ancestors of ARow are the same as in HeaderRow test
    expect(footer.firstChild is ARow, true);
    expect(footer.firstChild is FooterRow, true);
  });

  test('XXX', () {

  });

}
