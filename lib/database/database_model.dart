class UserDetail {
  int id;
  String name;
  String phone;
  String token;

  UserDetail({this.id, this.name, this.phone, this.token});

  factory UserDetail.fromDatabaseJson(Map<String, dynamic> data) {
    return UserDetail(id: data['id'], name: data['name'], phone: data['phone'], token: data['token']);
  }

  Map<String, dynamic> toDatabaseJson() {
    return {"id": this.id, "name": this.name, "phone" : this.phone, "token": this.token};
  }
}
