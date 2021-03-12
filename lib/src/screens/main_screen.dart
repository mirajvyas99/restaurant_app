import 'package:flutter/material.dart';
import 'package:restaurant_app/src/admin/pages/add_food_item.dart';
import 'package:restaurant_app/src/pages/about_us.dart';
import '../scoped-model/main_model.dart';

//Pages
import '../pages/home_page.dart';
import '../pages/order_page.dart';
import '../pages/explore_page.dart';
import '../pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;
  MainScreen({this.model});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  //Pages
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;

  @override
  void initState() {
    widget.model.fetchAll();

    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage(model: widget.model);
    profilePage = ProfilePage();
    pages = [homePage, favoritePage, orderPage, profilePage];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentTabIndex == 0
                ? "RESTAURANT"
                : currentTabIndex == 1
                    ? "All Food Items"
                    : currentTabIndex == 2 ? "Your Order" : "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                size: 30.0,
                color: Colors.lightBlueAccent,
              ),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset('assets/images/restaurant.jpeg'),
                  ),
                  SizedBox(height: 10,),
                  Text("RESTAURANT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddFoodItem(),
                  ));
                },
                leading: Icon(Icons.fastfood),
                title: Text(
                  "Add Food Item",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AboutUsPage(),
                  ));
                },
                leading: Icon(Icons.info_rounded),
                title: Text(
                  "About Us",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Orders"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),
        body: currentPage,
      ),
    );
  }
}
