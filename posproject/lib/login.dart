import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/database_helper.dart';
import 'package:posproject/homePage.dart'; // Ensure this import is correct
import 'package:posproject/signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 16, 54, 29),
            Color.fromARGB(255, 54, 244, 200),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Container(
          width: 300,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 10),
              const Text(
                'YU Hair & Beauty Spa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  fontFamily: 'Noto Sans',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _inputField("Username", usernameController, Icons.person),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, Icons.lock, isPassword: true),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _loginBtn(),
                  _signUpBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Image.asset(
      'assets/shoplogo.png',
      width: 200,
      height: 200,
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(icon, color: Colors.white),
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () async {
        String username = usernameController.text;
        String password = passwordController.text;

        // Validate user credentials
        final user = await _validateUser(username, password);

        if (user != null) {
          Get.offAll(HomePage(
            userName: username, // Pass username to HomePage constructor
            userEmail: user['email'], // Assuming user['email'] is the email field from database
          ));
        } else {
          // Show an error message
          Get.snackbar('Error', 'Invalid username or password', snackPosition: SnackPosition.BOTTOM);
        }
      },
      child: const Text(
        "Sign In",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  Future<Map<String, dynamic>?> _validateUser(String username, String password) async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Widget _signUpBtn() {
    return ElevatedButton(
      onPressed: () => Get.to(CreateAccountPage()),
      child: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 20, color: Colors.green),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
