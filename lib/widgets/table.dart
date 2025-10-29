import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constant.dart';
import '../utils/currency_format.dart';
import '../utils/utils.dart';

Widget buildTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    color: SECONDARY_COLOR.withOpacity(0.9),
    child: const Row(
      children: [
        Expanded(flex: 2, child: Text('Txn Date', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Txn ID', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Type', style: _headerStyle)),
        Expanded(flex: 1, child: Text('Staff ID', style: _headerStyle)),
        Expanded(flex: 1, child: Text('Amount', style: _headerStyle)),
      ],
    ),
  );
}

const TextStyle _headerStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 11,
);

Widget buildTableRow(Map<String, dynamic> data, int index) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    decoration: BoxDecoration(
      color: index.isEven ? Colors.grey[100] : Colors.white,
      border:
      const Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            formattedDateTime(data['createDate']),
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            data['transactionId'] ?? '-',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            data["transactionType"] ?? '-',
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            data["staffID"] ?? '-',
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            Currency().format('${data["transactionAmount"] ?? 0.0}'),
            style: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    ),
  ).animate().fade(duration: 200.ms).scale(delay: 50.ms * index);
}