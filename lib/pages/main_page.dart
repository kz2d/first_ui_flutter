import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../test_data.dart';
import 'Item_card.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin, RestorationMixin {
  final RestorableInt tabIndex = RestorableInt(0);
  TabController _tabController;
  final AnimatorKey animatorKey = AnimatorKey<dynamic>();
  final AnimatorKey animatorKeyy = AnimatorKey<dynamic>();
  Map animationInfo = {"isShown": true};

  @override
  void initState() {
    log('lll');
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(
        children: [
          TabBar(
            tabs: [
              Container(
                  alignment: Alignment.center, height: 90, child: Text('Main')),
              Container(
                  alignment: Alignment.center,
                  height: 90,
                  child: Text('Galery')),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  print(animatorKey.animation.status);
                  log('printed');
                  if (scrollNotification.scrollDelta < 0 &&
                      !animationInfo["isShown"]) {
                    ScrollUp();
                  } else if (scrollNotification.scrollDelta > 0 &&
                      animationInfo["isShown"]) {
                    ScrollDown();
                  }
                }
                return false;
              },
              child: TabBarView(controller: _tabController, children: [
                GridView.builder(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: kDefaultPadding,
                      mainAxisSpacing: kDefaultPadding,
                      childAspectRatio: 9 / 16),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => Itemcard()),);},
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            getPhoto(index),
                            fit: BoxFit.cover,
                          ),
                      ),
                    );
                  },
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: kDefaultPadding,
                      mainAxisSpacing: kDefaultPadding,
                      childAspectRatio: 16 / 12),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Image.asset(
                              getPhoto(index),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('patient',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.white)),
                                Text(
                                  '7 Photos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                            left: 10,
                            bottom: 13,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Animator(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 60)),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        triggerOnInit: false,
        cycles: 1,
        animatorKey: animatorKey,
        builder: (_, animatorState, __) => Transform(
          transform: Matrix4.translationValues(
              animatorState.value.dx, animatorState.value.dy, 0),
          child: BottomAppBar(
            color: Colors.black,
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 210,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(height: 199,
                                    color: Colors.black,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.seven_k,color: Colors.white,),
                                            title: Text(
                                                'Upgrade to Walldrobe Pro'),
                                          ),ListTile(
                                            leading: Icon(Icons.settings,color: Colors.white),
                                            title: Text(
                                                'Settins'),
                                          ),ListTile(
                                            leading: Icon(Icons.info_outline,color: Colors.white),
                                            title: Text(
                                                'About'),
                                          )
                                        ],
                                      ),
                                    );
                              });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScrollUp();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 26,
                      ),
                      Icon(
                        Icons.note_add_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        child: Animator(
          duration: Duration(milliseconds: 300),
          cycles: 1,
          animatorKey: animatorKeyy,
          triggerOnInit: true,
          builder: (_, animationState, __) => SizeTransition(
            sizeFactor: animationState.animation,
            axisAlignment: 1.0,
            child: FloatingActionButton(
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  @override
  void restoreState(RestorationBucket old, bool ini) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  String get restorationId => 'tab_scrollable_demo';

  void ScrollDown() {
    if (!animatorKey.animation.isCompleted &&
        animatorKey.animation.status == AnimationStatus.dismissed) {
      animationInfo["isShown"] = false;
      animatorKey.triggerAnimation();
      animatorKeyy.triggerAnimation();
    }
  }

  void ScrollUp() {
    if (animatorKey.animation.isCompleted &&
        animatorKey.animation.status == AnimationStatus.completed) {
      animationInfo["isShown"] = true;
      animatorKey.triggerAnimation();
      animatorKeyy.triggerAnimation();
    }
  }
}