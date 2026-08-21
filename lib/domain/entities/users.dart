// ===================== Geo =====================

class Geo {
  final String lat;
  final String lng;

  const Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat']?.toString() ?? '0.0',
      lng: json['lng']?.toString() ?? '0.0',
    );
  }

  factory Geo.fromMap(Map<dynamic, dynamic> map) {
    return Geo(
      lat: map['lat']?.toString() ?? '0.0',
      lng: map['lng']?.toString() ?? '0.0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}

// ===================== Address =====================

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo? geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      geo: json['geo'] != null
          ? Geo.fromJson(json['geo'])
          : null,
    );
  }

  factory Address.fromMap(Map<dynamic, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      suite: map['suite'] ?? '',
      city: map['city'] ?? '',
      zipcode: map['zipcode'] ?? '',
      geo: map['geo'] != null
          ? Geo.fromMap(map['geo'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
    };

    if (geo != null) {
      data['geo'] = geo!.toMap();
    }

    return data;
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}

// ===================== Company =====================

class Company {
  final String name;
  final String? catchPhrase;
  final String? bs;

  const Company({
    required this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] ?? '',
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  factory Company.fromMap(Map<dynamic, dynamic> map) {
    return Company(
      name: map['name'] ?? '',
      catchPhrase: map['catchPhrase'],
      bs: map['bs'],
    );
  }

  Map<String, dynamic> toMap() {
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

  Map<String, dynamic> toJson() {
    return toMap();
  }
}

// ===================== User =====================

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address? address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : const Company(name: 'Unknown'),
    );
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] != null
          ? Address.fromMap(map['address'])
          : null,
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      company: map['company'] != null
          ? Company.fromMap(map['company'])
          : const Company(name: 'Unknown'),
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company.toMap(),
    };

    if (address != null) {
      data['address'] = address!.toMap();
    }

    return data;
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}