import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/category_model.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../models/food_model.dart';
import '../../scoped-model/main_model.dart';
import '../../widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../widgets/show_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodItem extends StatefulWidget {
  final Food food;
  final Category cat;
  AddFoodItem({this.food, this.cat});

  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String title;
  String category;
  String catId;
  String imagePath;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  File _image;
  final picker = ImagePicker();

  Category dropdownValue;

  Future getImage() async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 28);
    // final compressedImage = await FlutterImageCompress.compressAndGetFile(image.path, image.path, quality: 30);

    setState(() {
      // _image = compressedImage;
      _image = File(image.path);
    });
    print(_image.lengthSync());
  }

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      imagePath = widget.food.imagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldStateKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              widget.food != null ? "Update Food Item" : "Add Food Item",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Form(
                key: _foodItemFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170.0,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: GestureDetector(
                        child: _image != null
                            ? Image.file(_image)
                            : widget.food != null
                                ? Image.network("${widget.food.imagePath}")
                                : Image.asset("assets/images/noimage.png"),
                        onTap: () {
                          getImage();
                        },
                      ),
                    ),
                    // RaisedButton(
                    //   elevation: 3,
                    //   color: Colors.blue,
                    //   child: Icon(Icons.add_to_drive,color: Colors.white,),
                    //   onPressed: () async{
                    //     FirebaseStorage fs = FirebaseStorage.instance;
                    //     Reference reference = fs.ref().child("foods/${_image.path.split('/').last}"); //gets the original filename from the whole path & set as filename in storage
                    //     // Reference reference = fs.ref().child("foods/${widget.food.name}"); //sets the filename as the name of food
                    //     await reference.putFile(_image);
                    //     imagePath = (await reference.getDownloadURL()).toString();
                    //     // print(imagePath);
                    //   },
                    // ),
                    _buildTextFormField("Food Title"),
                    // _buildTextFormField("Category"), //text field
                    _buildCategoryFormField("Category"),
                    _buildTextFormField("Description", maxLine: 5),
                    _buildTextFormField("Price"),
                    _buildTextFormField("Discount"),
                    SizedBox(height: 70.0),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return GestureDetector(
                          child: Button(
                            btnText: widget.food != null
                                ? "Update Food Item"
                                : "Add Food Item",
                          ),
                          onTap: () {
                            onSubmit(model.addFood, model.updateFood);
                            if (model.isLoading) {
                              //show loading progress indicator
                              showLoadingIndicator(
                                  context,
                                  widget.food != null
                                      ? "Updating Food..."
                                      : "Adding Food...");
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      if (_image != null) {
        FirebaseStorage fs = FirebaseStorage.instance;
        Reference reference = fs.ref().child(
            "foods/${_image.path.split('/').last}"); //gets the original filename from the whole path & set as filename in storage
        // Reference reference = fs.ref().child("foods/${widget.food.name}"); //sets the filename as the name of food
        await reference.putFile(_image);
        imagePath = (await reference.getDownloadURL()).toString();
        // print(imagePath);
      }

      if (widget.food != null) {
        //i want to update the food item
        Map<String, dynamic> updatedFoodItem = {
          "title": title,
          "catId": catId,
          "imagePath": imagePath,
          "description": description,
          "price": double.parse(price),
          "discount": discount != null ? double.parse(discount) : 0.0,
        };
        final bool response = await updateFood(updatedFoodItem, widget.food.id);
        print(response);
        if (response) {
          Navigator.of(context).pop(); // to remove the alert dialog
          Navigator.of(context).pop(response); //to the previous page
        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to update food item.",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.food == null) {
        //i want to add new food item
        final Food food = Food(
          name: title,
          catId: catId,
          imagePath: imagePath,
          description: description,
          price: double.parse(price),
          discount: double.parse(discount),
        );
        bool value = await addFood(food);
        if (value) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            content: Text("Food item successfully added."),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        } else if (!value) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            content: Text("Failed to add food item."),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Title"
          ? widget.food.name
          : widget.food != null && hint == "Description"
              ? widget.food.description
              // : widget.food != null && hint == "Category"
              //     ? widget.food.category
              : widget.food != null && hint == "Price"
                  ? widget.food.price.toString()
                  : widget.food != null && hint == "Discount"
                      ? widget.food.discount.toString()
                      : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        // String error
        if (value.isEmpty && hint == "Food Title") {
          return "Food Title is required";
        }
        if (value.isEmpty && hint == "Description") {
          return "Description is required";
        }
        // if (value.isEmpty && hint == "Category") {
        //   return "Category is required";
        // }
        if (value.isEmpty && hint == "Price") {
          return "Price is required";
        }
        // return "";
      },
      onSaved: (String value) {
        if (hint == "Food Title") {
          title = value;
        }
        // if (hint == "Category") {
        //   category = value;
        // }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }

  Widget _buildCategoryFormField(String hint) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model){
          if(widget.food != null){
            for(int j=0;j<model.categoryLength;j++){
              if(model.categories[j].catId == widget.food.catId){
                dropdownValue = model.categories[j];
              }
            }
          }
          return  Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonFormField<Category>(
              //     widget.food != null && hint == "Category"
              // ? widget.food.category :
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              dropdownColor: Colors.grey.shade200,
              elevation: 20,
              style: const TextStyle(color: Colors.black),
              onChanged: (value) async {
                setState(() {
                  dropdownValue = value;
                });
              },
              onSaved: (Category value) {
                catId = value.catId;
              },
              hint: Text("$hint"),
              items: model.categories.map<DropdownMenuItem<Category>>((Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Text(value.categoryName),
                );
              }).toList(),
              validator: (Category value) {
                // String error
                if (value.categoryName.isEmpty && hint == "Category") {
                  return "Category is required";
                }
                // return "";
              },
            ),
          );
        }
    );
  }
}
