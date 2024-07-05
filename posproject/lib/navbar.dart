import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/about.dart';
import 'package:posproject/customers.dart';
import 'package:posproject/login.dart';
import 'package:posproject/profile.dart';

class NavBar extends StatelessWidget {
 final String userName;
  final String userEmail;
  
  const NavBar({Key? key, required this.userName, required this.userEmail}) : super(key: key);
  @override  
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, 
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Name : "+ userName),
            accountEmail: Text("Email : "+ userEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/shoplogo.png'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.message_rounded),
            title: Text('Contact Us'),
             onTap: () {
              Get.to(profile());
            },
          ),
       
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Get.to(AboutPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Customer'),
             onTap: () {
              Get.to(Customers());
            },
          ),
         
          ListTile(
           leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              Get.to(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
