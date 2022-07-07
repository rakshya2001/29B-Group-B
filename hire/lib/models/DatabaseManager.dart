import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference profileList =
    FirebaseFirestore.instance.collection("users");

Future getUserList() async {
  List itemList = [];
  try {
    await profileList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            itemList.add(element.data);
          })
        });
    return itemList;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
