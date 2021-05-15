import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart';
import 'package:crypto/crypto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_ui/components/bottom_upload.dart';
import 'package:flutter/material.dart' as fl;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

Future<void> uploadImage(fl.BuildContext context) async {
  File file = await showBarModalBottomSheet(
      expand: true,
      context: context,
      builder: (fl.BuildContext context) => BottomSheetForPicImage());

  Image imageOrig = decodeImage(new File(file.path).readAsBytesSync());
  String md5Value = md5.convert(imageOrig.data).toString();

  var data =
      await FirebaseFirestore.instance.collection('images').doc(md5Value).get();
  if (data.exists) {
    print('thsAlreadyExist');
    return;
  }

  Image imageSmall = copyResize(imageOrig, width: 400, height: 600);
  Image imageBig = copyResize(imageOrig, width: 1080, height: 1680);

  String colorr =
      copyResize(imageSmall, width: 1, height: 1).getPixel(0, 0).toString();
  print(md5Value);

  await FirebaseStorage.instance
      .ref('posted_images/$md5Value/original.jpg')
      .putFile(file);

  await FirebaseStorage.instance
      .ref('posted_images/$md5Value/1080.jpg')
      .putData(encodeJpg(imageBig));

  await FirebaseStorage.instance
      .ref('posted_images/$md5Value/400.jpg')
      .putData(encodeJpg(imageSmall));


  FirebaseFirestore.instance.collection('first').doc(md5Value).set({
    'smallResURL':
        await FirebaseStorage.instance
        .ref('posted_images/$md5Value/400.jpg').getDownloadURL(),
    'bigResURL':
        await FirebaseStorage.instance
        .ref('posted_images/$md5Value/1080.jpg').getDownloadURL(),
    'originalURL':
        await FirebaseStorage.instance
        .ref('posted_images/$md5Value/original.jpg').getDownloadURL(),
    'color': colorr,
    'creator': FirebaseFirestore.instance
        .collection('users')
        .doc('Oxc8ntPjl9wDkfDCxHBk'),
    'downloads': 0,
    'likes': 0,
    'published at': FieldValue.serverTimestamp(),
    'views': 0,
    'md5': md5Value
  });
}
