import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialSignInButtons extends StatelessWidget {
  final Future<User?> Function() onGoogleSignIn;

  const SocialSignInButtons({super.key, required this.onGoogleSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Or sign up with",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: onGoogleSignIn,
              child: Container(
                width: 75,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/Google.webp',
                  width: 40,
                  height: 30,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              width: 75,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  // Action for Facebook Sign In
                },
                icon: Image.asset(
                  'assets/facebook.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              width: 75,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  // Action for LinkedIn Sign In
                },
                icon: Image.asset(
                  'assets/linkedin.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
