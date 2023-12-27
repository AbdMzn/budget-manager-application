import 'package:flutter/material.dart';

List<DataColumn> buildHeaders(List<String> headers) {
  return headers.map((header) => DataColumn(label: Text(header))).toList();
}

List<DataRow> buildRows(List<List<String>> trows) {
  List<List<String>> rows = List.generate(
    trows[0].length,
    (index) => trows.map((row) => row[index]).toList(),
  );
  return rows.map((row) {
    return DataRow(
      cells: row.map((data) {
        return DataCell(
          Container(
            decoration: BoxDecoration(),
            child: Text(data),
          ),
        );
      }).toList(),
    );
  }).toList();
}
