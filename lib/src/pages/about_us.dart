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
        body: Center(
          child: Column(
            children: [
              Text("RESTAURANT"),
              ListView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset('assets/images/restaurant.jpeg'),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset('assets/images/restaurant.jpeg'),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset('assets/images/restaurant.jpeg'),
                      ),
                    ],
                  )
                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}
