import 'package:flutter/material.dart';
import 'package:invoice/UI/form_screen.dart';
import 'package:invoice/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Column(
          children: [
            SizedBox(height: 45),
            Container(
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              child: Transform.scale(
                  scale: 1.25,
                  child: Image.asset('assets/splash.png', fit: BoxFit.contain)),
            ),
            SizedBox(height: 12),
            Text(
              'Sales Invoice App',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Select the purpose",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FormScreen()));
                  },
                  child: Material(
                    elevation: 4,
                    color: Constants.buttonColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Constants.buttonColor1),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      child: Center(
                        child: Text(
                          "Generate Form",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
