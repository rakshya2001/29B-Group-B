import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Our Team "),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        children: [
         
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/aashutosh.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Ashutosh",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Front End Developer", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/prasid.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Prasid",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Front End Developer", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  ), SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/prince.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Prince",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Front End Developer", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  ), SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/shiv.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Shivam",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Front End Developer", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  ), SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/sanjog.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Sanjog",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Back End Developer", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  ), SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset("assets/rakshya.jpg",width: 64.0,),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Rakshya",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Tester", style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  ),)
                          ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
