import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hire/controllers/databasevalue.dart';
import 'package:hire/models/data.dart';
import 'package:hire/normaluser/NavBar.dart';
import 'package:hire/normaluser/bigtext.dart';
import 'package:hire/normaluser/viewdetails.dart';
import 'package:hire/pages/user.dart';
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
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference data =
      FirebaseFirestore.instance.collection("users");
  String? firstName;
  String? lastName;
  String? email;
  String cities = "";
  String categorys = "";
  String firstNames = "";
  String lastNames = "";
  String emails = "";
  UserModel userModel = UserModel();
  ViewUserdetail viewUserdetail = ViewUserdetail();

  List profiles = [];
  _dashboardState(this.firstName, this.lastName, this.email);

  PageController pageController = PageController(viewportFraction: 0.85);
  var currentpagevalue = 0.0;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    ref.get().then((value) {
      value.docs.forEach((element) {
        this.userModel = UserModel.fromMap(element.data());
        String? firstname;
        String? lastname;
        String? image = "";
        String? phone;
        String? city;
        String? category;
        print(
            "---------------------------- Doctor data ----------------------------");
        setState(() {
          firstName = "${userModel.firstname}";
          lastName = "${userModel.lastname}";
          print("Profile Pic..............");
          // if (doctor_data.profileImageDownloadURL != null) {
          //   imageURL = doctor_data.profileImageDownloadURL;
          // }
          // print(imageURL);
          phone = userModel.phone.toString();
          city = userModel.city.toString();
          category = userModel.category.toString();
          print(firstName);
        });
        this.viewUserdetail.detail.add(
            UserDetail(firstName!, lastName!, image, phone!, category!, city!));
      });
    });
  }

  List UserProfileList = [];
  fetchDatabaseList() async {
    List resultant = await DatabaseManager().getUserlist();
    if (resultant == null) {
      print("unable");
    } else {
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
                itemCount: 5,
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
                itemCount: viewUserdetail.detail.length,
                itemBuilder: (context, index) {
                  return Viewdetails(viewUserdetail.detail[index]);
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
                        firstname: profiles[index]["firstname"],
                        category: profiles[index]["category"],
                        city: profiles[index]["city"],
                        email: profiles[index]["email"],
                        phone: profiles[index]["phone"],
                        lastname: profiles[index]["lastname"],
                        time: UserProfileList[index]["time"],
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
                    BigText(text: "Tester test"),
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
                      children: [
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
            ),
          )
        ],
      ),
    );
  }
}
