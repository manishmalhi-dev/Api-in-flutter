import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apis/api%20link/api_link.dart';
import 'package:flutter_apis/model%20class/user_data_model.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<UserPostDataModel> userPostData = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void postData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(Uri.parse(ApiLink.baseUrl),
        body: {
          "title": 'foo',
          "body": 'bar',
          "userId": "1",
        }
      );
      if (response.statusCode == 201 || response.statusCode == 200)  {
        print("Data successfully inserted ${response.body}");
      }else {
        print("Data Not inserted api error");
      }
      setState(() {
        isLoading = false;
      });

    } catch (e){
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void getData() async {
    userPostData.clear();
    setState(() {
      isLoading = true;
    });
    try {
      final responseIs = await http.get(Uri.parse(ApiLink.postUrl));
      // List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(responseIs.body));
      List data = jsonDecode(responseIs.body);
      // print(data[0]["title"]);

      // for (int a = 0; a < data.length; a++) {
      //   UserDetailClass newOne = UserDetailClass(
      //     userId: data[a]["userId"],
      //     id: data[a]["id"],
      //     title: data[a]["title"],
      //     body: data[a]["body"],
      //   );
      //   userModel.add(newOne);
      // }

      userPostData = data.map((item) => UserPostDataModel.fromJson(item)).toList();

    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text("User Post"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      endDrawer: Drawer(),

      body: Center(
        child: isLoading == true
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width/3,
                            child: Divider(height: 1,));
                      },
                      itemCount: userPostData.length,
                      itemBuilder: (context, index) {
                        final newList = userPostData[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              context.push('/PostDetail', extra: newList.id);
                            },

                            child: Card(
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        spacing: 20,
                                        children: [
                                          textStyling("id"),
                                          CircleAvatar(child: Text("${newList.id}")),
                                        ],
                                      ),
                                      Row(
                                        spacing: 20,
                                        children: [
                                          textStyling("title"),
                                          Expanded(child: Text(newList.title)),
                                        ],
                                      ),
                                      Row(
                                        spacing: 20,
                                        children: [
                                          textStyling("body"),
                                          Expanded(child: Text(newList.body)),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget textStyling(String text){
  return
    Text("$text :", style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w700),);

}