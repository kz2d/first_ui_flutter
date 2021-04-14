import 'package:flutter/material.dart';

import '../constants.dart';
import '../test_data.dart';

class Itemcard extends StatefulWidget {
  Itemcard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ItemcardState createState() => _ItemcardState();
}

class _ItemcardState extends State<Itemcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Icon(Icons.upload_file),
            SizedBox(
              width: 15,
            ),
            Icon(Icons.more_vert_rounded),
            SizedBox(
              width: 8,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DetailScreen()),
                  );
                },
                child: SizedBox(
                  child: Image.asset(
                    getPhoto(0),
                    fit: BoxFit.cover,
                  ),
                  height: MediaQuery.of(context).size.height - 90,
                ),
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: kDefaultPadding),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(getPhoto(1)),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Marta Filipczyk",
                                style: Theme.of(context).textTheme.headline2,
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
                                    "68",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                                    "68",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: kDefaultPadding),
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Icon(
                          Icons.bookmark_border_outlined,
                          color: Colors.white,
                          size: 22,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("Download".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            color: Colors.white, fontSize: 10)),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '2.9k',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 7),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                                primary: kPrimaryOposite,
                                backgroundColor: kPrimary,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(kDefaultPadding / 2),
                                elevation: 0,
                                minimumSize: Size(110, 50),
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
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                                primary: kPrimary,
                                backgroundColor: kPrimaryOposite,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(kDefaultPadding / 2),
                                elevation: 0,
                                minimumSize: Size(110, 50),
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
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '699,9k',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              'Views',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '08 apr. `21',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              'Published On',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '16',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              'Likes',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
            child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  getPhoto(0),
                  fit: BoxFit.contain,
                ))),
      ),
    );
  }
}
