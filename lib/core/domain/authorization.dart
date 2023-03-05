class Authorization {
  String authorization = '';

  Authorization({required this.authorization});

  Authorization.fromJson(Map<String, dynamic> json) {
    authorization = json['authorization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['authorization'] = authorization;
    return data;
  }
}
