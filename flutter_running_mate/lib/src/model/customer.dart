// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  int id;
  String email;
  String phone;
  String name;
  String token;
  Customer({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.token,
  });

  // User({this.id, this.email, this.phone, this.name, this.token});

  factory Customer.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return Customer(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      token: json['token'],
    );

  }

  void printAttributes() {
    print("id: ${this.id}\n");
    print("email: ${this.email}\n");
    print("phone: ${this.phone}\n");
    print("name: ${this.name}\n");
    print("token: ${this.token}\n");
  }

}
