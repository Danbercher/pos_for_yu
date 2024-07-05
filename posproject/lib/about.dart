import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AboutPage extends StatelessWidget {
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
                  "${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
        body: Container(
          color: Color.fromARGB(255, 222, 235, 223),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/shoplogo.png'),
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                //SizedBox(height: 20),
                Text(
                  'Yu Hair & Beauty Spa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                  Container(
                  width: 1100, // Adjust the width as needed
                  height: 250, // Adjust the height as needed
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 5, 137, 9),
                        height: 1.7,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Hair Services: \n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Haircuts, styling, coloring, and treatments are commonly offered services. Trained stylists provide consultations to understand clients preferences and suggest suitable styles.\n'
                        ),
                        TextSpan(
                          text: 'Beauty Treatments:\n ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'This may include facials, skincare treatments, and makeup services. Beauty therapists often use traditional techniques alongside modern skincare products.\n',
                        ),
                        TextSpan(
                          text: 'Massage Therapy: \n ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Many spas offer traditional Myanmar massage therapy, which incorporates techniques from ancient Burmese practices. These massages are often known for their therapeutic benefits and can help with relaxation and stress relief.\n',
                        ),
                        TextSpan(
                          text: 'Nail Care: \n ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Manicures and pedicures are popular services in spas, providing nail care, shaping, and polish application.\n',
                        ),
                       
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
void main() {
  runApp(MaterialApp(
    home: AboutPage(),
  ));
}