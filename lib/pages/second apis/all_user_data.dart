import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api link/api_link.dart';
import '../../model class/second api user model/user_data.dart';

class AllUserData extends StatefulWidget {
  const AllUserData({super.key});

  @override
  State<AllUserData> createState() => _AllUserDataState();
}

class _AllUserDataState extends State<AllUserData> {
  List<UserData> userData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }
  bool isLoading = true;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(ApiLink.userUrl));
      if (response.statusCode == 200) {
        List newResponse = jsonDecode(response.body);
        setState(() {
          userData = newResponse
              .map((item) => UserData.fromJson(item))
              .toList();
        });
        setState(() {
          isLoading = false;
        });
      } else {
        print("api can't be call properly");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("UserData"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading==true? Center(child: CircularProgressIndicator(),):Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            child: Text("${userData[index].id}"),
                          ),
                        ),
                        dataText("name", userData[index].name),
                        dataText("username", userData[index].userName),
                        dataText("email", userData[index].email),
                        dataText("address", userData[index].address.street),
                        dataText("suite", userData[index].address.suite),
                        dataText("city", userData[index].address.city),
                        dataText("zipcode", userData[index].address.zipcode),
                        dataText("geo", userData[index].address.geo.lat),
                        dataText("geo", userData[index].address.geo.lng),
                        dataText("phone", userData[index].phone),
                        dataText("website", userData[index].website),
                        dataText("company", userData[index].company.name),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget dataText(String heading, String data) {
  return Row(
    spacing: 30,
    children: [
      Text(
        heading,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.blueAccent,
          fontSize: 20,
        ),
      ),
      Text(data, style: TextStyle(fontWeight: FontWeight.w500)),
    ],
  );
}
