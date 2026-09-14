import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apis/api%20link/api_link.dart';
import 'package:flutter_apis/model%20class/user_data_model.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_apis/provider/theme_provider.dart';

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
      List data = jsonDecode(responseIs.body);

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
        actions: [
          IconButton(onPressed: (){
            context.read<ThemeProvider>().toggleTheme();
          }, icon: Icon(Icons.sunny)),
          Builder(
            builder: (context) {
              return IconButton(onPressed: (){
                Scaffold.of(context).openEndDrawer();
              }, icon: Icon(Icons.menu));
            }
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text("about"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),

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