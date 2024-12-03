enum TableFormat {
  table,
  header,
  body,
  footer,
  rows,
  cells,
  id,
  value;

  dynamic getValue(Map<String, dynamic> map) => map[name];
}
