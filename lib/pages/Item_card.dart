import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_ui/function/formaters.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

import '../constants.dart';
import '../test_data.dart';

class Itemcard extends StatefulWidget {
  Itemcard({Key key, this.firebase_data, this.reference}) : super(key: key);

  final Map<String, dynamic> firebase_data;
  final DocumentReference reference;

  @override
  _ItemcardState createState() => _ItemcardState();
}

class _ItemcardState extends State<Itemcard> {
  bool scrolled = false;
  Map<String, dynamic> _user_data = Map();

  @override
  void initState() {
    super.initState();
    print(widget.firebase_data['creator']);
    widget.firebase_data['creator'].get().then((DocumentSnapshot value) {
      print(value.data());

      setState(() {
        _user_data = value.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Icon(Icons.upload_file),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.more_vert_rounded),
            SizedBox(
              width: 11,
            )
          ],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              setState(() {
                scrolled = true;
              });
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                bigResURL: widget.firebase_data['bigResURL'],
                                smallResURL:
                                    widget.firebase_data['smallResURL'],
                                color: widget.firebase_data['color'],
                              )),
                    );
                  },
                  child: SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: widget.firebase_data['bigResURL'],
                      fit: BoxFit.cover,
                      placeholder: (context, data) => CachedNetworkImage(
                        imageUrl: widget.firebase_data['smallResURL'],
                        fit: BoxFit.cover,
                        placeholder: (context, data) => Container(
                          alignment: Alignment.center,
                          color: Color(widget.firebase_data['color']),
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height - 95,
                  ),
                ),
                _user_data.isEmpty == false
                    ? Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        color: kPrimary,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: kDefaultPadding * 1.25),
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            _user_data['photoURL']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _user_data['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                color: kPrimaryOposite,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.image_outlined,
                                            color: kSecondary,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: kSecondaryPadding / 2,
                                          ),
                                          Text(
                                            _user_data['number of images']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          SizedBox(
                                            width: kSecondaryPadding,
                                          ),
                                          Icon(
                                            Icons.photo_library_outlined,
                                            color: kSecondary,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: kSecondaryPadding / 2,
                                          ),
                                          Text(
                                            _user_data['number of collections']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: kDefaultPadding),
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    color: kPrimaryOposite,
                                    size: 22,
                                  ),
                                ),
                                Icon(
                                  Icons.bookmark_border_outlined,
                                  color: kPrimaryOposite,
                                  size: 22,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                              child: Center(
                                child: scrolled
                                    ? Container()
                                    : Animator(
                                        cycles: 0,
                                        tween: Tween(
                                            begin: Offset(0, 0),
                                            end: Offset(0, 5)),
                                        duration: Duration(milliseconds: 500),
                                        builder: (_, animatorState, __) =>
                                            Transform.translate(
                                              offset: animatorState.value,
                                              child: Icon(
                                                Icons.keyboard_arrow_down_sharp,
                                                color: kPrimaryOposite,
                                              ),
                                            )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: kDefaultPadding,
                                  left: kDefaultPadding,
                                  bottom: kDefaultPadding * 2,
                                  top: kDefaultPadding * 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Text("Download".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                    color: kPrimaryOposite,
                                                    fontSize: 10)),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          NumberFormatter(widget
                                              .firebase_data['downloads']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  fontSize: 7,
                                                  letterSpacing: 3),
                                        )
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        primary: kPrimaryOposite,
                                        backgroundColor: kPrimary,
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 2),
                                        elevation: 0,
                                        minimumSize: Size(110, 45),
                                        side: BorderSide(
                                            color: kPrimaryOposite, width: 1)),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Text("wallpaper".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    color: kPrimary,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        primary: kPrimary,
                                        backgroundColor: kPrimaryOposite,
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 2),
                                        elevation: 0,
                                        minimumSize: Size(110, 45),
                                        side: BorderSide(
                                            color: kPrimaryOposite, width: 1)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        NumberFormatter(
                                            widget.firebase_data['views']),
                                        style:
                                            TextStyle(color: kPrimaryOposite),
                                      ),
                                    ),
                                    Text(
                                      'Views',
                                      style: TextStyle(color: kPrimaryOposite),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        DataFormatter(widget
                                            .firebase_data['published at']),
                                        style:
                                            TextStyle(color: kPrimaryOposite),
                                      ),
                                    ),
                                    Text(
                                      'Published On',
                                      style: TextStyle(color: kPrimaryOposite),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        widget.firebase_data['likes']
                                            .toString(),
                                        style:
                                            TextStyle(color: kPrimaryOposite),
                                      ),
                                    ),
                                    Text(
                                      'Likes',
                                      style: TextStyle(color: kPrimaryOposite),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  final String smallResURL;
  final String bigResURL;
  final int color;

  const DetailScreen({Key key, this.smallResURL, this.bigResURL, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: InteractiveViewer(
          child: Container(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: bigResURL,
                placeholder: (BuildContext, String) => CachedNetworkImage(
                  imageUrl: smallResURL,
                  placeholder: (BuildContext, String) => Container(
                    color: Color(color),
                  ),
                ),
              )),
        )));
  }
}
