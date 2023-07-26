import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path; // Import the path package
import '../../exports.dart';
class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImage;
  Dio dio = Dio();
  bool _isSync = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            if (selectedImage != null)
              Image.file(selectedImage!),
            ElevatedButton(
              onPressed: 
                _getFromGallery,
                
              
              child: Text('Choose Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (selectedImage == null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please select an image.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                try {
                  await addCategory();
                  
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to add category. Please try again. ${e}'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  setState(() {
      _isSync = false;
    });
                }
              },
              child: _isSync ? CircularProgressIndicator(color: Colors.white,) : Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }


 _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }
//  Future<File?> getImageFromGallery() async {
//   try {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
// print(pickedFile);
//     if (pickedFile == null) {
//       // User canceled image selection
//       print('Image selection canceled.');
//       return null;
//     }

//     File image = File(pickedFile.path);
//     return image;
//   } catch (e) {
//     // Handle any exceptions during image selection
//     print('Error picking image: $e');
//     return null;
//   }
// }


  // Future<File?> getImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();

  //   final XFile? photo = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 25,
  //   );
  //   _image = photo!.path;
  //   pic = photo.path;
  // }

  Future<void> addCategory() async {

    setState(() {
      _isSync = true;
    });

    FormData formData = FormData.fromMap({
      "name": nameController.text,
      "description": descriptionController.text,
      "image": await MultipartFile.fromFile(selectedImage!.path),
    });

    Response response = await dio.post(
      '${Constants.uri}/admin/addCategory',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    if (response.statusCode == 200) {
      // Manually parse the response data (assuming the response is in JSON format)
      Map<String, dynamic> responseData = response.data;
      // Save the returned JSON fields in the local database (Sqflite)
      //await saveCategoryToLocalDatabase(responseData);
       await saveCategoryToLocalDatabase(responseData);
       showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text("Added Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                 setState(() {
      _isSync = false;
    }); // Closes the dialog
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
          content: Text("Failed Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                setState(() {
      _isSync = false;
    });// Closes the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
      
    }
  }

  Future<void> saveCategoryToLocalDatabase(Map<String, dynamic> categoryData) async {
    print(categoryData);
    final db = await _openDatabase();
    await db.insert('categories', categoryData,
        conflictAlgorithm: ConflictAlgorithm.replace);
        
  }

  Future<Database> _openDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path1 = path.join(documentsDirectory.path, 'my_database.db');
    return openDatabase(path1, version: 1,
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
    });
  }
}
