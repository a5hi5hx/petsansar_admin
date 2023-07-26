//File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  void signOutUser(BuildContext context) {
    AuthService().signOutuser(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Pet Sansar Admin",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("adoptmenepal@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' My Course '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ), //Drawer
      backgroundColor: Color(0xffcbbdbd),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff724a09),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Pet Sansar Admin",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            color: Color(0xffffffff),
          ),
        ),
        
        actions: [
          //buttons
        //   Icon(Icons.add, color: Color(0xffffffff), size: 30),
        //  const SizedBox(width: 15),
          IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  // onPressed: () => obj.signOutUser(context),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Logout'),
                        content: Text('Confirm LogOut'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => signOutUser(context),
                              child: Text('Confirm')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Go Back'))
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 24,
                  ),
                ),
                         const SizedBox(width: 15),

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
         
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
            height: 165,
            child: GestureDetector(
              onTap: ()  {
               
                    
              },
              child: Card(
                margin: EdgeInsets.all(5),
                color: Color(0xff07093d),
                shadowColor: Color(0xff000000),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 20),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 100,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Start Processing",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Color(0xffffffff),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const  SizedBox(width: 120,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                      child: Image(
                          image: NetworkImage("https://picsum.photos/250?image=9"),
                          height: 130,
                          width: 115,
                          fit: BoxFit.contain,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           Divider(
            color: Color(0xff808080),
            height: 16,
            thickness: 0,
            indent: 0,
            endIndent: 0,
          ),
          //grid
          Expanded(
            flex: 1,
            child: GridView(
              padding: EdgeInsets.all(5),
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.2,
              ),
              children: [
                GestureDetector(
                  onTap: () {
 Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductPage()));
                   },
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color(0xffc03636),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductPage()));

                            },
                            color: Color(0xff212435),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Add Items",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (_) => AddCategoryPage()));

                  },
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color.fromARGB(255, 6, 67, 124),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.category),
                            onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(builder: (_) => AddCategoryPage()));

                            },
                            color: Color.fromARGB(255, 179, 181, 191),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Add Category",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryListPage()));

                  },
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color.fromARGB(255, 41, 16, 115),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.category),
                            onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryListPage()));

                            },
                            color: Color.fromARGB(255, 162, 218, 227),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "All Category",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AddScrollDataScreen()));

                  },
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color.fromARGB(255, 20, 14, 184),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (_) => AddScrollDataScreen()));
                            },
                            color: Color.fromARGB(255, 165, 173, 175),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Add Scroll View',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color(0xffc03636),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {},
                            color: Color(0xff212435),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Add Items",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: EdgeInsets.all(4.0),
                    color: Color(0xffc03636),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {},
                            color: Color(0xff212435),
                            iconSize: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Add Items",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}