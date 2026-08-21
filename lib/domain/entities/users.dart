
class Geo {
  String lat;
  String lng;

  Geo({required this.lat, required this.lng});
  Geo.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] ?? '0.0',
        lng = json['lng'] ?? '0.0';

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo? geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geo, // optional
  });

  Address.fromJson(Map<String, dynamic> json)
      : street = json['street'] ?? '',
        suite = json['suite'] ?? '',
        city = json['city'] ?? '',
        zipcode = json['zipcode'] ?? '',
        geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
    };
    if (geo != null) {
      data['geo'] = geo!.toJson();
    }
    return data;
  }
}

// ===================== Company =====================
class Company {
  String name;
  String? catchPhrase; // optional
  String? bs;          // optional

  Company({
    required this.name,
    this.catchPhrase,
    this.bs,
  });

  Company.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        catchPhrase = json['catchPhrase'],
        bs = json['bs'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
    };
    if (catchPhrase != null) {
      data['catchPhrase'] = catchPhrase;
    }
    if (bs != null) {
      data['bs'] = bs;
    }
    return data;
  }
}

// ===================== User =====================
class User {
  int id;
  String name;
  String username;
  String email;
  Address? address; // optional
  String phone;
  String website;
  Company company; // required (always present)

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address, // no 'required' because it can be null
    required this.phone,
    required this.website,
    required this.company,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        username = json['username'] ?? '',
        email = json['email'] ?? '',
        address = json['address'] != null ? Address.fromJson(json['address']) : null,
        phone = json['phone'] ?? '',
        website = json['website'] ?? '',
        company = json['company'] != null
            ? Company.fromJson(json['company'])
            : Company(name: 'Unknown'); // fallback if company is missing

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company.toJson(),
    };
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}