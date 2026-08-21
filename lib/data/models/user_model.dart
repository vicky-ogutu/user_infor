import '../../domain/entities/users.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.website,
    required super.address,
    required super.company,
  });

  // ---- fromJson ----
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      // Address is nullable, so pass null if missing
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      // Company is non‑nullable; provide a fallback if missing
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : Company(name: 'Unknown'),
    );
  }

  // ---- fromMap ----
  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      address: map['address'] != null
          ? Address.fromMap(map['address'])
          : null,
      company: map['company'] != null
          ? Company.fromMap(map['company'])
          : Company(name: 'Unknown'),
    );
  }

  // ---- toMap ----
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address?.toMap(),   // null‑safe
      'company': company.toMap(),
    };
  }

  // ---- toJson ----
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address?.toJson(),  // null‑safe
      'company': company.toJson(),
    };
  }
}