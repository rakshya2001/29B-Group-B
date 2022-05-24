class UserModel {
  String? uid;
  String? firstname;
  String? lastname;

  String? email;
  String? password;
  String? confirmpassword;
  String? street;
  String? city;
  String? phone;
  String? role;
  UserModel(
      {this.uid,
      this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.confirmpassword,
      this.street,
      this.city,
      this.phone,
      this.role
      });

  //data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        email: map['email'],
        password: map['password'],
        confirmpassword: map['confirmpassword'],
        street: map['street'],
        city: map['city'],
        phone: map['phone'],
        role:map['role']);
  }

  //sending data to  the server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'confirmpassword': confirmpassword,
      'street': street,
      'city': city,
      'phone': phone,
      'role' : role
    };
  }
}
