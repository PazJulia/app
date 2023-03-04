class Access {
  String detail = '';
  String access = '';

  Access({required this.detail, required this.access});

  Access.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['detail'] = detail;
    data['access'] = access;
    return data;
  }
}
