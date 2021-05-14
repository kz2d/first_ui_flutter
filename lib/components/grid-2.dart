import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_ui/pages/Item_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GridWithTwo extends StatelessWidget {
  final List<QueryDocumentSnapshot> firebase_data;
  const GridWithTwo({Key key, this.firebase_data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: kDefaultPadding,
            mainAxisSpacing: kDefaultPadding,
            childAspectRatio: 9 / 14),
        itemCount: 90,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Itemcard(
                        firebase_data: firebase_data[index].data(),
                        reference: firebase_data[index].reference)),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: firebase_data[index].data()['smallResURL'],
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    color: Color(firebase_data[index].data()['color']),
                  ),
                  fit: BoxFit.cover,
                )),
          );
        });
  }
}
