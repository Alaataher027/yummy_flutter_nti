import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Spacer(flex: 20),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ClipOval(
                child: Image.asset(
                  "assets/profile_pics/person_stef.jpeg",
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 12),

              const Text("Stef", style: TextStyle(fontSize: 14)),
              const SizedBox(height: 6),

              const Text("Flutteristas"),
              const SizedBox(height: 6),

              const Text("100 points"),
            ],
          ),
        ),
        const Spacer(flex: 5),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("View Kodeco", style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Text("Log out", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const Spacer(flex: 50),
      ],
    );
  }
}
