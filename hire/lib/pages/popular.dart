import 'package:flutter/material.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/pages/textexpand.dart';

import '../normaluser/bigtext.dart';
import '../utils/app_icon.dart';
import '../utils/dimension.dart';
import '../widgets/icontext.dart';

class Popular extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String city;
  final String category;
  const Popular(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.city,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/plumber.jpg"),
              )),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => home()));
                    },
                    child: const AppIcons(
                      icon: Icons.arrow_back_ios,
                    ))
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 350,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: name,
                        size: 32,
                      ),
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
                              text: category,
                              color: Colors.black,
                              iconColor: Colors.amber),
                          icontext(
                              icon: Icons.mail,
                              text: email,
                              color: Colors.black,
                              iconColor: Colors.redAccent),
                          icontext(
                              icon: Icons.location_on,
                              text: city,
                              color: Colors.black,
                              iconColor: Colors.blue)
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "ABOUT ME"),
                          const Expanded(
                              child: SingleChildScrollView(
                                  child: ExpandableText(
                                      text:
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been centuries, but also the leap into electronic typesetting, remaining essentum.")))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 120,
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Color.fromARGB(255, 235, 235, 235)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    children: [Icon(Icons.phone, size: 50)],
                  )),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                child: BigText(
                  text: "Hire Me",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green),
              )
            ],
          )),
    );
  }
}
