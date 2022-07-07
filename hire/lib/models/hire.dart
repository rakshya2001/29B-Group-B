class hireModel {
  String? id;
  String? firstname;
  String? lastname;

  String? email;


  String? phone;


  String? time;
 
  hireModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
 
    this.phone,

    this.time,
  });

  //data from server

  factory hireModel.fromMap(map) {
    return hireModel(
        id: map['uid'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        email: map['email'],
     
     
        phone: map['phone'],
      
      
        time: map['time'],
       
        );
  }

  //sending data to  the server

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,

    
   
      'phone': phone,
      
      'time': time,
    
  
    };
  }

  Map<String, dynamic> toJson() => {
        'uid': id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      
        'phone': phone,
     
        'time': time,
      
      };
}
