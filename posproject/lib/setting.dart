import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/homePage.dart';
import 'package:posproject/login.dart';

class Setting extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();



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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Row(
              children: [
                Text('Enter Shop Phone Number'),
                TextField(
                  style: const TextStyle(color: Colors.white),
      
      decoration: InputDecoration(
      
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        hintStyle: const TextStyle(color: Colors.white),
       
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(Icons.phone, color: Colors.white),
                )
                )
              ],
             )
              
            ]
          ),
        ),
      ),
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
Widget _icon() {
    return Image.asset(
      'assets/shoplogo.png',
      width: 200,
      height: 200,
    );
  }
  Widget _createAccountBtn() {
    return ElevatedButton(
      onPressed: () {
        // Perform Account Creation Logic
        // After successful account creation, navigate to the home page
        //Get.offAll(homePage());
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
        // Perform Account Creation Logic
        // After successful account creation, navigate to the home page
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
