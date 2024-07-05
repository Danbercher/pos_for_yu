import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posproject/about.dart';
import 'package:posproject/customers.dart';
import 'package:posproject/navbar.dart';
import 'package:posproject/pos.dart';
import 'package:posproject/services.dart';
import 'package:posproject/staff.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const HomePage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YU Hair & Beauty Spa"),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 5),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: NavBar(userName: userName, userEmail: userEmail),
      ),
      body: ListView(
        children: [
          AllWidget(),
        ],
      ),
    );
  }
}
class AllWidget extends StatelessWidget {
  const AllWidget({super.key});

  @override
  Widget build(BuildContext context) { 
    return Container( 
      color: Color.fromARGB(255, 197, 220, 152),         
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,         
        child: Padding(          
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              /*Image.asset(
              "assets/shoplogo.png",             
              width: 100,//MediaQuery.of(context).size.width,
              height: 100,
              fit: BoxFit.cover,
            ),*/
          
              //About
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 1250,
                  height:140,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Color.fromARGB(255, 3, 46, 3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('assets/yu.png'),
                        width: 200,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),                      
                      Expanded(
                        child: Text(
                          'ABOUT \n YU Hair & Beauty Spa is a sanctuary dedicated to beauty and relaxation, offering a range of cosmetic treatments and services. Here, professionals provide haircuts, styling, facials, and nail care, all designed to enhance one appearance and foster a sense of well-being. It is a haven for self-care and rejuvenation.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       SizedBox(width: 20), 
                      ElevatedButton(
                        onPressed: () => Get.to(AboutPage()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 106, 183, 80)),
                        ),
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

              //POS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 1250,
                  height:140,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Color.fromARGB(255, 3, 46, 3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('assets/pos.gif'),
                        width: 200,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),                      
                      Expanded(
                        child: Text(
                          'POS \n YU Hair And Beauty Spa is a sanctuary dedicated to beauty and relaxation, offering a range of cosmetic treatments and services. Here, professionals provide haircuts, styling, facials, and nail care, all designed to enhance one appearance and foster a sense of well-being. It is a haven for self-care and rejuvenation.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       SizedBox(width: 20), 
                      ElevatedButton(
                        onPressed: () => Get.to(MyPos()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 106, 183, 80)),
                        ),
                        child: Text(
                          "GO",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

            //SERVICES
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 1250,
                  height:140,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                   color: Colors.white,
                    //border: Border.all(color: Color.fromARGB(255, 3, 46, 3), width: 2),
                  ),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage('assets/massage.gif'),
                        width: 150,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),                      
                      const Expanded(
                        child: Text(
                          'SERVICES \n Indulge in a rejuvenating experience at our serene spa, where tranquility meets luxury. At Yu Hair & Beauty Spa, we offer an array of exquisite services tailored to pamper your senses and revitalize your body and mind. Treat yourself to a bespoke haircut by our skilled stylists, who will craft the perfect look to complement your unique style. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       SizedBox(width: 20), 
                      ElevatedButton(
                        onPressed: () => Get.to(Services()),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 106, 183, 80)),
                        ),
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

            //CUSTOMERS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 1250,
                  height:140,
                  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                   color: Colors.white,
                    //border: Border.all(color: Color.fromARGB(255, 3, 46, 3), width: 2),
                  ),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage('assets/customer1.png'),
                        width: 200,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),                      
                      const Expanded(
                        child: Text(
                          'CUSTOMERS \n About Our customers detail and We Record Our Real Customers.This data is Our Treasure!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       SizedBox(width: 20), 
                      ElevatedButton(
                        onPressed: () => Get.to(Customers()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 106, 183, 80)),
                        ),
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

              //STAFFS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 1250,
                  height:140,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                   color: Colors.white,
                    //border: Border.all(color: Color.fromARGB(255, 3, 46, 3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('assets/yuEmployee.jpg'),
                        width: 200,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),                      
                      Expanded(
                        child: Text(
                          'STAFFS \n Meet our exceptional team at Yu Hair and Beauty Spa. Each member is carefully selected for their expertise, professionalism, and dedication to providing unparalleled service. From our skilled therapists to our friendly receptionists, every staff member is committed to ensuring your visit is nothing short of extraordinary. Relax and rejuvenate with confidence, knowing you are in the caring hands of our experienced team.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       SizedBox(width: 20), 
                      ElevatedButton(
                        onPressed: () => Get.to(Staff()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 106, 183, 80)),
                        ),
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
