import 'package:flutter/material.dart';

statCrad(String label, int value) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 7,
    child: Container(
      height: 140,
      width: 300,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 12.0, left: 18),
            child: Text(
              label,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey[500],
          )
        ],
      ),
    ),
  );
}


