import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hire/controllers/databasevalue.dart';
import 'package:hire/normaluser/NavBar.dart';
import 'package:hire/normaluser/bigtext.dart';
import 'package:hire/utils/dimension.dart';
import 'package:hire/widgets/icontext.dart';

import '../models/user_model.dart';
import '../pages/popular.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key, this.firstName, this.lastName, this.email})
      : super(key: key);
  String? firstName;
  String? lastName;
  String? email;
  @override
  State<dashboard> createState() => _dashboardState(firstName, lastName, email);
}

class _dashboardState extends State<dashboard> {
  

  String? firstName;
  String? lastName;
  String? email;

  _dashboardState(this.firstName, this.lastName, this.email);

  PageController pageController = PageController(viewportFraction: 0.85);
  var currentpagevalue = 0.0;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    // pageController.addListener(() {
    //   setState(() {
    //     currentpagevalue = pageController.page!;
        
    //   });
    // });

    // @override
    // void dispose() {
    //   pageController.dispose();
    // }
  }

List UserProfileList = [];
  fetchDatabaseList() async {
    List resultant =  await DatabaseManager().getUserlist();
    if(resultant == null){
      print("unable");
    }else{
      setState(() {
        UserProfileList = resultant;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Navbar(
        //   firstName: firstName,
        //   lastName: lastName,
        //   email: email,
        // ),
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: Dimensions.pageview,
              child: PageView.builder(
                controller: pageController,
                itemCount: UserProfileList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                },
              )),
          DotsIndicator(
            dotsCount: 5,
            position: currentpagevalue,
            // ignore: prefer_const_constructors
            decorator: DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: Colors.redAccent,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              BigText(text: "Popular "),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Professionals ",
                style: TextStyle(color: Colors.black26, fontSize: 12),
              )
            ]),
          ),
          Container(
            height: 700,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: UserProfileList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/electrician.jpg"))),
                        ),
                        Container(
                          height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "Testing in progress "),
                                icontext(
                                    icon: Icons.phone,
                                    text: "98xxxxxxxx",
                                    color: Colors.grey,
                                    iconColor: Colors.grey),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    icontext(
                                        icon: Icons.work,
                                        text: "Plumber",
                                        color: Colors.black,
                                        iconColor: Colors.amber),
                                    icontext(
                                        icon: Icons.location_on,
                                        text: "Kathmandu",
                                        color: Colors.black,
                                        iconColor: Colors.blue)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currentpagevalue.floor()) {
      var currScale = 1 - (currentpagevalue - index) * (1 - _scaleFactor);
      var currtrans = Dimensions.pageViewContainer * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currentpagevalue.floor() + 1) {
      var currScale =
          _scaleFactor + (currentpagevalue - index + 1) * (1 - _scaleFactor);
      var currtrans = Dimensions.pageViewContainer * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currentpagevalue.floor() - 1) {
      var currScale = 1 - (currentpagevalue - index) * (1 - _scaleFactor);
      var currtrans = Dimensions.pageViewContainer * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
            1, Dimensions.pageViewContainer * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Popular(
                        name: UserProfileList[index]["firstname"],
                        category:  UserProfileList[index]["category"],
                        city:  UserProfileList[index]["city"],
                        email:  UserProfileList[index]["email"],
                        phone:  UserProfileList[index]["phone"],
                      )));
            }),
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/plumber.jpg"),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text:UserProfileList[index]["firstname"].toString() ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(children: [
                      Wrap(
                          children: List.generate(
                              5,
                              (index) => const Icon(Icons.star,
                                  color: Colors.amber, size: 15)))
                    ]),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        icontext(
                            icon: Icons.work,
                            text:UserProfileList[index]["category"],
                            color: Colors.black,
                            iconColor: Colors.amber),
                        icontext(
                            icon: Icons.location_on,
                            text: UserProfileList[index]["city"],
                            color: Colors.black,
                            iconColor: Colors.blue)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
