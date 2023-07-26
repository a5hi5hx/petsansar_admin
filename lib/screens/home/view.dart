import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path; // Import the path package
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategoriesFromDatabase();
  }

  Future<void> fetchCategoriesFromDatabase() async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> fetchedCategories = await db.query('categories');
    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
      ),
      body: categories.isNotEmpty
          ? ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]['name']),
                  subtitle: Text(categories[index]['description']),
                  trailing: Text(categories[index]['status']),
                );
              },
            )
          : Center(
              child: Text('No categories found'),
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
}
