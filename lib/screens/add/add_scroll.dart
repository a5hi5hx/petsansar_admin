import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../exports.dart';
class AddScrollDataScreen extends StatefulWidget {
  const AddScrollDataScreen({super.key});

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddScrollDataScreen> {
  final TextEditingController titleController = TextEditingController();
  File? selectedImage;
  Dio dio = Dio();
bool _isSync = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Scroll Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            if (selectedImage != null)
              Image.file(selectedImage!, height: 200,),
            ElevatedButton(
              onPressed: () async {
                File? image = await getImageFromGallery();
                setState(() {
                  selectedImage = image;
                });
              },
              child: Text('Choose Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (selectedImage == null || titleController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please provide title and select an image.'),
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
                  await addData();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Data added successfully.'),
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
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to add data. Please try again.'),
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
              child: _isSync ? CircularProgressIndicator(color: Colors.white,) : Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  Future<void> addData() async {
setState(() {
  _isSync = true;
});    

    FormData formData = FormData.fromMap({
      "title": titleController.text,
      "image": await MultipartFile.fromFile(selectedImage!.path),
    });

    Response response = await dio.post(
     '${Constants.uri}/admin/addScroll',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    if (response.statusCode != 200) {
      setState(() {
  _isSync = false;
}); 
      throw Exception("Failed to add data");
    }
    setState(() {
  _isSync = false;
}); 
  }
}
