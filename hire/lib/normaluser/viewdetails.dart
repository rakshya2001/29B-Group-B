import 'package:flutter/material.dart';
import 'package:hire/models/data.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/bigtext.dart';
import 'package:hire/pages/popular.dart';

import '../widgets/icontext.dart';

class Viewdetails extends StatelessWidget {
  final UserModel userDetail;
  Viewdetails(this.userDetail) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Popular(
                  firstname: userDetail.firstname!,
                  email: userDetail.email!,
                  phone: userDetail.phone!,
                  city: userDetail.city!,
                  category: userDetail.category!,
                  lastname: userDetail.lastname!,
                  time: userDetail.time!,
                  userModel: userDetail,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38,
                  image: userDetail.image != ""
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userDetail.image!))
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/aashutosh.jpg"))),
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
                    BigText(
                        text: "${userDetail.firstname} ${userDetail.lastname}"),
                    icontext(
                        icon: Icons.phone,
                        text: userDetail.phone!,
                        color: Colors.grey,
                        iconColor: Colors.grey),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        icontext(
                            icon: Icons.work,
                            text: userDetail.category!,
                            color: Colors.black,
                            iconColor: Colors.amber),
                        icontext(
                            icon: Icons.location_on,
                            text: userDetail.city!,
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
      ),
    );
  }
}
