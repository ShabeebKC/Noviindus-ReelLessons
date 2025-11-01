class LoginResponse {
  bool? status;
  bool? privilege;
  Token? token;
  String? phone;

  LoginResponse({this.status, this.privilege, this.token, this.phone});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    privilege = json['privilage'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['privilage'] = privilege;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    data['phone'] = phone;
    return data;
  }
}

class Token {
  String? refresh;
  String? access;

  Token({this.refresh, this.access});

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}