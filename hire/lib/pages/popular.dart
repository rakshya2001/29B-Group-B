import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/pages/textexpand.dart';

import '../normaluser/bigtext.dart';
import '../utils/app_icon.dart';
import '../utils/dimension.dart';
import '../widgets/icontext.dart';

class Popular extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String city;
  final String category;
  final String time;
  
  const Popular(
      {Key? key,
      required this.firstname,
      required this.email,
      required this.phone,
      required this.city,
      required this.category, required this.lastname, required this.time})
      : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  double rating = 0;
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
                      Row(
                        children:[
                          BigText(
                          text: widget.firstname,
                          size: 32,
                        ),
                        SizedBox(width: 10,),
                         BigText(
                          text: widget.lastname,
                          size: 32,
                        ),
                        ]
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
                              text: widget.category,
                              color: Colors.black,
                              iconColor: Colors.amber),
                          icontext(
                              icon: Icons.mail,
                              text: widget.email,
                              color: Colors.black,
                              iconColor: Colors.redAccent),
                          icontext(
                              icon: Icons.location_on,
                              text: widget.city,
                              color: Colors.black,
                              iconColor: Colors.blue)
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "ABOUT ME"),
                            SingleChildScrollView(
                              child: ExpandableText(
                                  text:
                                      "Hello I am ${widget.firstname} ${widget.lastname} from ${widget.city}. Currently I Prefer working as ${widget.time} as a ${widget.category}. You can reach me through here also can contact me on ${widget.phone} "),
                            ),
                            Row(
                              children: [
                                Text("Rating : $rating",
                                    style: const TextStyle(fontSize: 15)),
                                RatingBar.builder(
                                  minRating: 0,
                                  itemSize: 50,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  updateOnDrag: true,
                                  onRatingUpdate: (rating) => setState(() {
                                    this.rating = rating;
                                  }),
                                )
                              ],
                            ),
                          ],
                        ),
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
          height: 90,
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
                    children: [Icon(Icons.phone, size: 30)],
                  )),
              Container(
                height: 500,
                width: 100,
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 30, right: 10),
                child: BigText(
                  text: "Hire",
                  size: 50,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
              )
            ],
          )),
    );
  }
}
