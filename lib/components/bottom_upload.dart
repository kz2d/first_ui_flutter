import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_manager/photo_manager.dart';

import '../constants.dart';

class BottomSheetForPicImage extends StatefulWidget {
  const BottomSheetForPicImage({Key key}) : super(key: key);

  @override
  _BottomSheetForPicImageState createState() => _BottomSheetForPicImageState();
}

class _BottomSheetForPicImageState extends State<BottomSheetForPicImage> {
  List<Widget> _mediaList = [];
  int currentPage = 0;
  int lastPage;

@override
  initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(currentPage, 60);
      List<Widget> temp = [];
      for (var asset in media) {
        if (asset.type != AssetType.image) continue;
        temp.add(
          FutureBuilder(
            future: asset.thumbDataWithSize(200, 200),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return GestureDetector(
                  onTap: () async {
                    print(await asset.file);
                    Navigator.of(context).pop(await asset.file);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        color: Colors.black87,
                        child: Icon(Icons.image_outlined),
                      ),
                      Positioned.fill(
                        child: Image.memory(
                          snapshot.data,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );

              return Container(
                alignment: Alignment.center,
                color: Colors.grey,
                child: Icon(Icons.image_outlined),
              );
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
          backgroundColor: kSecondary,
            navigationBar: CupertinoNavigationBar(backgroundColor: kSecondary,
                leading: Container(), middle: Text('Modal Page')),
            child: SafeArea(
              bottom: false,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scroll) {
                  _handleScrollEvent(scroll);
                  return;
                },
                child: GridView.builder(
                  itemCount: _mediaList.length,
                  controller: ModalScrollController.of(context),
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1 / 1),
                  itemBuilder: (BuildContext context, int index) {
                    return _mediaList[index];
                  },
                ),
              ),
            )));
  }
}
