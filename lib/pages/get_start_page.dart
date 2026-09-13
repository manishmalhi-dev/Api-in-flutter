import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4Y0gi55HZHJ_9Tqz9Za1lSjwwoYuNknsLv6snN2eO7w&s=10",
            ),

            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(),
              SizedBox(),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width /1.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0,100,150,1),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.push('/HomePage');
                      },
                      child: Text(
                        "Get Start Page ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width /2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.push('/AllUsrData');
                      },
                      child: Text(
                        "Second API ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan.shade300,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.push('/WeatherAppHome');
                      },
                      child: Text(
                        "Weather app with API ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
