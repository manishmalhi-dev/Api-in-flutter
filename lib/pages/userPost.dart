import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_apis/api%20link/api_link.dart';
import 'package:http/http.dart' as http;
import '../model class/user_data_model.dart';
import 'comments_bottom_sheet.dart';

class UserPost extends StatefulWidget {
  final int data;
  const UserPost({super.key, required this.data});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {

  @override
  void initState() {
    super.initState();
    userPost();
  }

  bool isLoading = false;
  UserPostDataModel? post;

  Future<void> userPost() async {
    setState(() {
      isLoading = true;
    });
    String newLink = "${ApiLink.postUrl}/${widget.data}";
    try {
      final response = await http.get(Uri.parse(newLink));
      if (response.statusCode == 200) {
        var task = jsonDecode(response.body);
        // print(task);
        setState(() {
          post = UserPostDataModel.fromJson(task);
        });
      } else {
        print("API can't be call properly ");
      }
      setState(() {
        isLoading = false;
      });
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
        centerTitle: true,
        title: Text("Post Detail ${widget.data}"),
      ),
      body: isLoading == true
      ? Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  newTextStyle("id","${post!.id}"),
                  Divider(),
                  newTextStyle("title", post!.title),
                  Divider(),
                  newTextStyle("body", post!.body),

                  Align(alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.comment),
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CommentsBottomSheet(id: post!.id,);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

Widget newTextStyle(String name, String data) {
  return Row(
    spacing: 20,
    children: [
      Text(
        "$name :",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Flexible(child: Text(data)),
    ],
  );
}
