import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_ui/components/grid-2.dart';
import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  final List<QueryDocumentSnapshot> firebase_data;
  const Favorite({Key key, this.firebase_data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: GridWithTwo(
          firebase_data: firebase_data,
        ),
      ),
    );
  }
}
