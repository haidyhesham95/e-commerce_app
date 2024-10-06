/// message : "success"
/// pass: haidy@123
/// user : {"name":"haidyhesham","email":"haidyhesham@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZDRjYzRlNzczMjRiZjVmZTQxYzAwMyIsIm5hbWUiOiJoYWlkeWhlc2hhbSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzI1MjIxOTY3LCJleHAiOjE3MzI5OTc5Njd9.SnCGhgxKDrUdlPjKSvDfmHMgpfCCCtjLMHoANPmE1r8"

class AuthModel {

  String? message;
  User? user;
  String? token;
  String? statusMsg;
  Error? error;
  AuthModel({
      this.message, 
      this.user, 
      this.token,
      this.statusMsg,
      this.error


  });

  AuthModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
    error = json['errors'] != null ? Error.fromJson(json['errors']) : null;
  }





  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }

    map['token'] = token;
    map['statusMsg'] = statusMsg;
    if (error != null) {
      map['errors'] = error?.toJson();
    }
    return map;
  }

}

/// name : "haidyhesham"
/// email : "haidyhesham@gmail.com"
/// role : "user"

class User {
  String? name;
  String? email;
  String? role;


  User({
    this.name,
    this.email,
    this.role,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    return map;
  }
}

  class Error {
    String? msge;
    String? parem;
     String? value;

    Error({
      this.msge,
      this.parem,
      this.value,
    });

    Map<String, dynamic> toJson() {
      final map = <String, dynamic>{};
      map['msge'] = msge;
      map['parem'] = parem;
      map['value'] = value;
      return map;
    }

    Error.fromJson(Map<String, dynamic> json) {
      msge = json['msge'];
      parem = json['parem'];
      value = json['value'];
    }


}