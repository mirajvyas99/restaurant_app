import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/category_model.dart';
import '../models/food_model.dart';
import '../scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/food_item_card.dart';
import 'food_details_page.dart';

class CategoryListPage extends StatefulWidget {
  final MainModel model;
  final Category catId;
  CategoryListPage({this.model,this.catId});
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  //scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      widget.model.fetchAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("${widget.catId.categoryName}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black),),
          centerTitle: true,
        ),
        key: _explorePageScaffoldKey,
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            // UserInfo userInfo = model.getUserDetails(PreferenceHelper.getId());
            List<Food> tempList = new List();

            for(int i=0;i<model.foodLength;i++){
              if(model.foods[i].catId == widget.catId.catId) {
                tempList.add(model.foods[i]);
              }
            }
            // for(var item in model.foods){
            //   if(item.catId == widget.catId.catId){
            //
            //   }
            // }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RefreshIndicator(
                onRefresh: model.fetchFoods,
                child: ListView.builder(
                  itemCount: tempList.length,
                  itemBuilder: (BuildContext lctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => FoodDetailsPage(
                            food: tempList[index],
                          ),
                        ));
                      },
                      child: FoodItemCard(
                        tempList[index].name,
                        tempList[index].description,
                        tempList[index].imagePath,
                        tempList[index].price.toString(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
