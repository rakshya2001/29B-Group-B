class chatModel {
  String? id;
  String? firstname;
  String? lastname;
  

  String? message;

  String? time;

  chatModel({
    this.id,
    this.firstname,
    this.lastname,
   
    this.message,
    this.time,
  });

  //data from server

  factory chatModel.fromMap(map) {
    return chatModel(
      id: map['uid'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      
      message: map['message'],
      time: map['time'],
    );
  }

  //sending data to  the server

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      
      'message': message,
      'time': time,
    };
  }

  Map<String, dynamic> toJson() => {
        'uid': id,
        'firstname': firstname,
        'lastname': lastname,
        
        'message': message,
        'time': time,
      };
}
