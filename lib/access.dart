import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/home.dart';
import 'package:untitled/main.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() {
    return AccessPageState();
  }
}

class AccessPageState extends State<AccessPage> {
  @override
  void initState() {
    super.initState();
    }
  // Request location permission
  PermissionStatus status = Permission.location.request() as PermissionStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login As",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: "User",
                  color: const Color.fromARGB(255, 63, 181, 120),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
                CustomButton(
                  text: "Admin",
                  color: const Color.fromARGB(255, 63, 181, 120),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "Sign Up As",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: "User",
                  color: const Color.fromARGB(255, 63, 181, 120),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage(role: "User")),
                    );
                  },
                ),
                CustomButton(
                  text: "Admin",
                  color: const Color.fromARGB(255, 63, 181, 120),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const SignUpPage(role: "Admin")),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisasterHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 181, 120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              ),
              child: const Text(
                "Guest",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(
      {super.key, required this.text, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: color),
      ),
    );
  }
}
