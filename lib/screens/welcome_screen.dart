import 'package:flutter/material.dart';
import 'package:freelance_app/screens/user/login_screen.dart';
import 'package:freelance_app/screens/user/role.dart';

import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          /*
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
          ),

          */
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 300,
              //width: 180,
              child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.fill),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: "Login",
              buttonColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
            ),
            CustomButton(
              buttonText: "Register",
              buttonColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChooseRoleScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "We make design easier for everyone!",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
