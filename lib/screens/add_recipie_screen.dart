import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipie_app/database/recipie_database.dart';
import 'package:recipie_app/database/recipie_database_box.dart';
import 'package:recipie_app/utils/utils.dart';

class AddRecipieScreen extends StatefulWidget {
  const AddRecipieScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipieScreen> createState() => _AddRecipieScreenState();
}

class _AddRecipieScreenState extends State<AddRecipieScreen> {

  Box recipieBox=RecipieDatabaseBox.getRecipieData();

  final recipieNameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final recipieController = TextEditingController();

  final _formKey=GlobalKey<FormState>();

  Uint8List? _imageData;
  final ImagePicker _picker = ImagePicker();
  bool _isImageNotSelected=false;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // convert to Uint8List
        final imageByte = await pickedFile.readAsBytes();
        setState(() {
          _imageData = imageByte;
          _isImageNotSelected=false;
        });
      }
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }
  String? _validateImage() {
    if (_imageData == null) {
      return 'Please select an image';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Add Recipie'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: Center(
                    child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: _imageData == null
                            ? Center(
                                child: Text('uplaod an image'),
                              )
                            : Image.memory(
                                _imageData!,
                                height: 300,
                                width: 300,
                              )),
                  ),
                ),
                if (_isImageNotSelected)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Please select an image',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: recipieNameController,
                  decoration: InputDecoration(
                    hintText: 'enter Recipie name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'enter recipie name';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ingredientsController,
                  decoration: InputDecoration(
                    hintText: 'enter ingredients',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'enter ingredients';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  controller: recipieController,
                  decoration: InputDecoration(
                    hintText: 'enter recipie',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'enter recipie';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    String recipeName=recipieNameController.text.toString();
                    String recipeIngredients=ingredientsController.text.toString();
                    String recipe=recipieController.text.toString();

                    dynamic key=RecipieDatabaseBox.getNewKey().toString();
                    setState(() {
                      if (_imageData == null) {
                        _isImageNotSelected = true;
                      }
                    });


                    if(_formKey.currentState!.validate() && _imageData!=null){
                      RecipeDatabase rD=RecipeDatabase()
                        ..key=key
                        ..recipieName=recipeName
                        ..recipieIngredients=recipeIngredients
                        ..recipie=recipe
                        ..image=_imageData!;

                      recipieBox.put(key, rD).then((onValue){
                        Utils.toastMessage("Recipie added successfully...", Colors.green);
                      }).onError((e,StackTrace){
                        Utils.toastMessage(e.toString(), Colors.red);
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Add Recipie',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
