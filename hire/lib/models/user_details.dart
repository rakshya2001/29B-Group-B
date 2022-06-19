class Userdetails {
  String? displayName;
  String? email;
  String? photoUrl;

  //constructor

  Userdetails({this.displayName, this.photoUrl, this.email});
  // we need a map

  Userdetails.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    photoUrl = json["photoUrl"];
    email = json['email'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['photoUrl'] = this.photoUrl;
    data['email'] = this.email;
    return data;
  }
  
}
