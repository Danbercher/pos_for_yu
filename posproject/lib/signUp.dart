import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/database_helper.dart';
import 'package:posproject/homePage.dart';
import 'package:posproject/login.dart';

class CreateAccountPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          width: 350,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon(),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontFamily: 'Noto Sans',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _inputField("Username", usernameController, Icons.person),
                const SizedBox(height: 10),
                _inputField("Email", emailController, Icons.email, isEmail: true),
                const SizedBox(height: 10),
                _inputField("Password", passwordController, Icons.lock, isPassword: true),
                const SizedBox(height: 10),
                _inputField("Phone", phoneController, Icons.phone, isPhone: true),
                const SizedBox(height: 20),
                Row(children: [
                  const SizedBox(width: 20),
                  _createAccountBtn(),
                  const SizedBox(width: 20),
                  _cancelButton(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, IconData icon, {bool isPassword = false, bool isEmail = false, bool isPhone = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextFormField(
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
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        if (isEmail) {
          bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
          if (!emailValid) {
            return 'Please enter a valid email address';
          }
        }
        if (isPhone) {
          bool phoneValid = RegExp(r'^\d+$').hasMatch(value);
          if (!phoneValid) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
    );
  }

  Widget _icon() {
    return Image.asset(
      'assets/shoplogo.png',
      width: 200,
      height: 200,
    );
  }

  Widget _createAccountBtn() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String username = usernameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          String phone = phoneController.text;

          // Insert user data into the database
          Map<String, dynamic> user = {
            'username': username,
            'email': email,
            'password': password,
            'phone': phone
          };

          int id = await DatabaseHelper().insertUser(user);

          if (id != null) {
            Get.offAll(HomePage(
              userName: username, // Pass username to HomePage constructor
              userEmail: user['email'], // Assuming user['email'] is the email field from database
            )); // Navigate to HomePage after successful account creation
          } else {
            // Show an error message
            Get.snackbar('Error', 'Failed to create account', snackPosition: SnackPosition.BOTTOM);
          }
        }
      },
      child: const Text(
        "Create Account",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        Get.offAll(LoginPage());
      },
      child: const Text(
        "Cancel",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
