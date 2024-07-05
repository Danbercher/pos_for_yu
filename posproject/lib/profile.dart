import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:posproject/homePage.dart';
import 'package:url_launcher/url_launcher.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 235, 223),
        appBar: AppBar(
          title: Text('Our Social Platform'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 246, 247), // Container color
              borderRadius: BorderRadius.circular(20.0), // Round border radius
              border: Border.all(
                color: Colors.white, // Border color
                width: 2.0, // Border width
              ),
            ),
            width: 400,
            height: 600,

              
            child: Column(
              children: [

                SizedBox(height: 20,),
                Text("Yu Hair & Beauty Spa"),
                
                Image(
                  image: AssetImage('assets/facebook.jpg'),
                  width: 150,
                  height: 300,
                  
                ),
                
                
                Container(
                  child: InkWell(
                    child: Text(
                      'Click here to open our Faebook Page',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () => _launchURL(
                        'https://www.facebook.com/profile.php?id=100089562964747&mibextid=kFxxJD'),
                  ),
                ),

                SizedBox(height: 30,),
                 Icon(Icons.location_on),
               
                Row(
                  children: const [

                    SizedBox(width: 10,),
                     //Text('Address', style: TextStyle(fontWeight: FontWeight.w800)),
               // Icon(Icons.location_on),
                   SizedBox(width: 50,),
                    Text(
                      'အေးမြသာယာ \n လမ်းသွယ် ၁ ရွှေလမ်းမကြီး သံလမ်းထောင့် \n မြစ်ကြီးနား မြို့',
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),//အေးမြသာယာ လမ်းသွယ် ၁ ရွှေလမ်းမကြီး သံလမ်းထောင့် မြစ်ကြီးနား မြို့
                 
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
