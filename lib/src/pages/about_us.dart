import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("About Us",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            SizedBox(height: 20,),
            Text(
              "RESTAURANT",
              style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                viewportFraction: 0.8,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //3rd Image of Slider
                Container(
                  margin: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //4th Image of Slider
                Container(
                  margin: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //5th Image of Slider
                Container(
                  margin: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text(
              "History",
              style: TextStyle(color: Colors.grey.shade900,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15,),
            Text(
              '''RESTAURANT is one of the most popular restaurants and leading in the market since last 10 years. We have a chain of more than 40 branches spread across the country. We provide the customers with the atmost satisfactory service and food.''',
              style: TextStyle(color: Colors.grey.shade600,fontSize: 16,),
            ),
          ]
        ),
      )
    );
  }
}
