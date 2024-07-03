import 'dart:convert';

class User{                   //class named user
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User({                     //constructor for above class
    required this.id, 
    required this.name, 
    required this.email,
    required this.password, 
    required this.address, 
    required this.type, 
    required this.token
  });

  Map<String, dynamic> toMap(){         //defines a function named toMap which returns a Map with String keys and dynamic values
    return {                            //Convert the User instance into a format that can be easily converted to JSON.
      'id':id,
      'name':name,
      'email':email,
      'password':password,
      'address':address,
      'type':type,
      'token':token,
    };
  }

  factory User.fromMap(Map<String, dynamic>map){    //defines a factory constructor named fromMap, which takes input of a map with String keys and dynamic values
    return User(
      id: map['_id'] ?? '', 
      name:  map['name'] ?? '', 
      email:  map['email'] ?? '', 
      password:  map['password'] ?? '', 
      address:  map['address'] ?? '', 
      type:  map['type'] ?? '', 
      token:  map['token'] ?? '',
      );
  }

  String toJson() => json.encode(toMap());    //equivalent to writing { return json.encode(toMap()); }.  
      //convert to map using toMap then convert to json string
  
  //defines a factory constructor called fromJson within the User class
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  //fromJson factory constructor is used to create a User object from a JSON string. 
  //the json string is decoded and then converted to 'user' object
}