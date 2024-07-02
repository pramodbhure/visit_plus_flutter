import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visitplusapp/authentication-widgets/signin_screen.dart';
import 'package:visitplusapp/reusable_widget/CustomSmoothPageIndicator.dart';
import 'package:visitplusapp/reusable_widget/app_theme.dart';
import 'package:visitplusapp/welcome-widgets/welcomeScreen1.dart';
import 'package:visitplusapp/welcome-widgets/welcomeScreen2.dart';
import 'package:visitplusapp/welcome-widgets/welcomeScreen3.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check platform
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      name: 'visit-plus-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme, // Use the custom theme
      home: const IntroPages(),
    );
  }
}

class IntroPages extends StatefulWidget {
  const IntroPages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IntroPagesState createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final PageController _controller = PageController();
  bool _isLastPage = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isLastPage = _controller.page?.round() == 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const <Widget>[
              WelcomeScreen1(),
              WelcomeScreen2(),
              WelcomeScreen3(),
              SignInScreen(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: CustomPageIndicator(
                controller: _controller,
                count: 3,
                isVisible: !_isLastPage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
