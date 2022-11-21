class LoginModelMessage {
  String? token;
  String? tokenType;
  String? experiesAt;
  String? success;

  LoginModelMessage({
    this.token,
    this.tokenType,
    this.experiesAt,
    this.success,
  });
  LoginModelMessage.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
    tokenType = json['token_type']?.toString();
    experiesAt = json['experies_at']?.toString();
    success = json['success']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = tokenType;
    data['experies_at'] = experiesAt;
    data['success'] = success;
    return data;
  }
}

class LoginModel {
  LoginModelMessage? message;

  LoginModel({
    this.message,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    message = (json['message'] != null)
        ? LoginModelMessage.fromJson(json['message'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}
