import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api link/api_link.dart';
import '../model class/comments_model.dart';

class CommentsBottomSheet extends StatefulWidget {

  int id ;
   CommentsBottomSheet({super.key,required this.id});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postComments();
  }

  bool isLoading = false;

  List<CommentsModel> commentsModel = [];
  Future<void> postComments() async {
    setState(() {
      isLoading = false;
    });
    String newLink = "${ApiLink.postUrl}/${widget.id}/comments";
    try {
      final commentsResponse = await http.get(Uri.parse(newLink));
      if (commentsResponse.statusCode == 200) {
        List<Map<String, dynamic>> newCommentsResponse =
        List<Map<String, dynamic>>.from(jsonDecode(commentsResponse.body));

        setState(() {
          commentsModel = newCommentsResponse
              .map((item) => CommentsModel.fromJson(item))
              .toList();
        });
        setState(() {
          isLoading = true;
        });
      } else {
        print("data can't be get in api");
      }
    } catch (e) {
      print("API can't be call properly\n $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading==false?Center(child: CircularProgressIndicator()):SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments : ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: commentsModel.length,
                itemBuilder: (context, index) {
                  var newCommentsList = commentsModel[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0,),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Text(
                                  newCommentsList.email[0].toUpperCase(),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(newCommentsList.email,style: TextStyle(fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),
                          Text(newCommentsList.body,),
                        ],
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
