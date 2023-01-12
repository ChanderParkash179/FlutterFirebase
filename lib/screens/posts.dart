import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final reference = FirebaseDatabase.instance.ref('POST');

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(constants().primaryColor),
                Color(constants().secondaryColor),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Spaces().verticalSpace(25),
              Text(
                constants().postTitle.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: constants().fontSize,
                  color: Colors.white,
                ),
              ),
              Spaces().verticalSpace(10),
              const Divider(
                indent: 50,
                endIndent: 50,
                color: Colors.white,
                height: 5,
              ),
              Spaces().verticalSpace(30),
              Expanded(
                child: StreamBuilder(
                  stream: reference.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 5,
                      ));
                    } else {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List list = [];
                      list.clear();

                      list = map.values.toList();

                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    list[index]['title'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constants().fontSize - 6),
                                  ),
                                  Text(
                                    list[index]['id'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constants().fontSize - 6),
                                  ),
                                ],
                              ),
                              Spaces().verticalSpace(5),
                              const Divider(
                                indent: 25,
                                endIndent: 25,
                                color: Colors.white,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes().addpostRoute);
          },
          child: const Icon(
            CupertinoIcons.add_circled,
          ),
        ),
      ),
    );
  }
}
