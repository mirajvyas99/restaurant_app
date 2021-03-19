import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/user_info_model.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:restaurant_app/src/utils/preference_helper.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/custom_list_tile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnLocation = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      UserInfo userInfo = model.getUserDetails(PreferenceHelper.getId());
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/tablelogo.jpg"),
                              fit: BoxFit.contain),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(60.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              offset: Offset(0, 4.0),
                              color: Colors.black38,
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userInfo.username}",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${userInfo.email}",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // Container(
                        //   height: 25.0,
                        //   width: 60.0,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.blue),
                        //       borderRadius: BorderRadius.circular(20.0)),
                        //   child: Center(
                        //     child: Text(
                        //       "Edit",
                        //       style:
                        //       TextStyle(color: Colors.blue, fontSize: 16.0),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Account',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomListTile(
                          icon: Icons.location_on,
                          text: "Location",
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        CustomListTile(
                          icon: Icons.payment,
                          text: "Payment",
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        CustomListTile(
                          icon: Icons.arrow_forward,
                          text: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
