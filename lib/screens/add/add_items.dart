import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import '../../exports.dart';
import 'package:path/path.dart' as path; // Import the path package
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  // final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
   TextEditingController selectedItemIdController = TextEditingController();
  
  List<Map<String, dynamic>> categories = [];
  String? selectedItemId = 'Choose One';

  String selectedItem = '';
  List<File?> selectedImages = [];

  Dio dio = Dio(); // Initialize Dio for networking

  void _selectImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.length >= 2) {
      setState(() {
        selectedImages = images.map((image) => File(image.path)).toList();
      });
    } else {
      
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text("Select 2 pictures"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Closes the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
      }
  }

  void _submitForm() async {
        if (_formKey.currentState!.validate() && selectedImages.length >= 2) {

String keywordsInput = keywordsController.text.trim();
    List<String> keywords = keywordsInput.split(",");
      FormData formData = FormData.fromMap({
  //  "images": await MultipartFile.fromFileSync(selectedImages[0]!.path),
  //     "images": await MultipartFile.fromFileSync(selectedImages[1]!.path),

        "name": nameController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "category": selectedItemId,
        "brand": brandController.text,
        "quantity": quantityController.text,
        "keywords": keywords,
      });
      for (File? item in selectedImages) {
        formData.files.addAll([
            MapEntry("images", await MultipartFile.fromFile(item!.path)),
          ]);
      }


      try {
        Response response = await dio.post('${Constants.uri}/admin/addProduct', data: formData);
        if (response.statusCode == 200) {
          // Product added successfully
          // You can show a success message or navigate to another screen here
          showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text("Added Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Closes the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
        } else {
          showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text("Failed to add"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Closes the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
          // Handle server errors
        }
      } catch (e) {
        // Handle Dio errors
        print(e);
      }
    } else {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text("Fill All Fields"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Closes the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
      // Handle form validation errors or image selection errors
    }
  }
  

@override
  void initState() {
    super.initState();
    fetchCategoriesFromDatabase();
     selectedItemId = 'Choose One';
  }


  Future<void> fetchCategoriesFromDatabase() async {
  final db = await _openDatabase();
  List<Map<String, dynamic>> fetchedCategories = await db.query('categories',
      where: 'status = ?', whereArgs: ['active'], columns: ['id', 'name']);
  setState(() {
    categories = fetchedCategories;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product price';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: categoryController,
              //   decoration: InputDecoration(labelText: 'Category'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a product category';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: brandController,
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product brand';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product quantity';
                  }
                  return null;
                },
              ),
         DropdownButtonFormField<String>(
          value: selectedItemId,
          items: _buildDropdownItems(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItemIdController.text = newValue as String;
              selectedItemId = newValue;
            });
          },
          decoration: InputDecoration(labelText: 'Select Category'),
        ),
        TextFormField(
                controller: keywordsController,
                decoration: InputDecoration(labelText: 'Keywords'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product keywords';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectImages,
                child: Text('Select Images'),
              ),
              SizedBox(height: 10),
              if (selectedImages.length >= 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: selectedImages
                      .map((image) => Image.file(image!))
                      .toList(),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<Database> _openDatabase() async {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path1 = path.join(documentsDirectory.path, 'my_database.db');
    //String path1 = await getDatabasesPath();
    return openDatabase(
      path1,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE categories (
            id TEXT PRIMARY KEY,
            name TEXT,
            image TEXT,
            description TEXT,
            status TEXT
          )
        ''');
      },
    );
  }


  List<DropdownMenuItem<String>> _buildDropdownItems() {
    List<DropdownMenuItem<String>> items = [];

    // Add the "Choose One" option
    items.add(DropdownMenuItem<String>(
      value: 'Choose One',
      child: Text('Choose One'),
    ));

    // Add the categories from the provided list
    items.addAll(categories.map((category) {
      return DropdownMenuItem<String>(
        value: category['id'],
        child: Text(category['name']),
      );
    }));

    return items;
  }
}
