import 'address_model.dart';
import 'company_model.dart';

class UserData {
  int id;
  String name;
  String userName;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  UserData({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json["name"],
      userName: json["username"],
      email: json["email"],
      address: Address.fromJson(json["address"]),
      phone: json["phone"],
      website: json["website"],
      company: Company.fromJson(json["company"]),
    );
  }
}


