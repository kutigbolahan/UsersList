class UserList {
  List<Data> data;
  int total;
  int page;
  int limit;
  int offset;

  UserList({this.data, this.total, this.page, this.limit, this.offset});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    return data;
  }
}

class Data {
  String id;
  String lastName;
  String firstName;
  String email;
  String title;
  String picture;

  Data(
      {this.id,
      this.lastName,
      this.firstName,
      this.email,
      this.title,
      this.picture});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    email = json['email'];
    title = json['title'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['title'] = this.title;
    data['picture'] = this.picture;
    return data;
  }
}
