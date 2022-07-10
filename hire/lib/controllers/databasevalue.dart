
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference data =
      FirebaseFirestore.instance.collection("users");

  Future<void> CreateUserData(String firstname, String lastname, String number,
      String email, String phonenumber, String uid) async {
    return await data.doc(uid).set({
      "firstname": firstname,
      "lastname": lastname,
      "number": number,
      "email": email
    });
  }

// this is the google auth system for authentication between login and registration

  Future getUserlist() async {
    List itemsList = [];
    try {
      await data.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          itemsList.add(element.data); 
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
