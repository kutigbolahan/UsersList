class UserDetails {
  String id;
  String phone;
  String email;
  String title;
  String firstName;
  String registerDate;
  String gender;
  Location location;
  String dateOfBirth;
  String lastName;
  String picture;

  UserDetails(
      {this.id,
      this.phone,
      this.email,
      this.title,
      this.firstName,
      this.registerDate,
      this.gender,
      this.location,
      this.dateOfBirth,
      this.lastName,
      this.picture});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    title = json['title'];
    firstName = json['firstName'];
    registerDate = json['registerDate'];
    gender = json['gender'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    dateOfBirth = json['dateOfBirth'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['registerDate'] = this.registerDate;
    data['gender'] = this.gender;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['dateOfBirth'] = this.dateOfBirth;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}

class Location {
  String street;
  String timezone;
  String country;
  String state;
  String city;

  Location({this.street, this.timezone, this.country, this.state, this.city});

  Location.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    timezone = json['timezone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['timezone'] = this.timezone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
