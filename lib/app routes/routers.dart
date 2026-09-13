import 'package:flutter_apis/pages/get_start_page.dart';
import 'package:flutter_apis/pages/home_pages.dart';
import 'package:flutter_apis/pages/userPost.dart';
import 'package:go_router/go_router.dart';
import '../pages/second apis/all_user_data.dart';
import '../weather app/weather_app/weather_app_home.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/GetStartPage',
  routes: [
    GoRoute(path: '/GetStartPage', builder: (context, state) => GetStartPage()),
    GoRoute(path: '/HomePage', builder: (context, state) => HomePages()),
    GoRoute(path: '/PostDetail', builder: (context, state) {
      final int data = state.extra as int;
      return UserPost(data: data);
    }),
    GoRoute(path: '/AllUsrData', builder: (context, state)=> AllUserData()),
    GoRoute(path: "/WeatherAppHome", builder: (context, state)=> WeatherAppHome()),

  ],
);
