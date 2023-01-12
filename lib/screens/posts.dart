import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  final searchController = TextEditingController();

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
                height: 10,
              ),
              Spaces().verticalSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Search Here!',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    labelText: constants().search,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
              Spaces().verticalSpace(10),
              const Divider(
                indent: 70,
                endIndent: 70,
                color: Colors.white,
                height: 10,
              ),
              Spaces().verticalSpace(10),
              Expanded(
                child: FirebaseAnimatedList(
                  query: reference,
                  itemBuilder: (context, snapshot, animation, index) {
                    final titleData = snapshot.child('title').value.toString();
                    final idData = snapshot.child('id').value.toString();

                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              snapshot.child('title').value.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.child('id').value.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              child: PopupMenuButton(
                                color: Color(constants().primaryColor),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: Icon(
                                      Icons.edit,
                                      color: Color(constants().secondaryColor),
                                    ),
                                    title: Text(
                                      constants().edit,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: Icon(
                                      Icons.delete,
                                      color: Color(constants().secondaryColor),
                                    ),
                                    title: Text(
                                      constants().delete,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                                ],
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            indent: 50,
                            endIndent: 50,
                          )
                        ],
                      );
                    } else if ((titleData.toLowerCase().contains(
                            searchController.text.toLowerCase().toString())) ||
                        (idData.toLowerCase().contains(
                            searchController.text.toLowerCase().toString()))) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              snapshot.child('title').value.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.child('id').value.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              child: PopupMenuButton(
                                color: Color(constants().primaryColor),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          color:
                                              Color(constants().secondaryColor),
                                        ),
                                        title: Text(
                                          constants().edit,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.delete,
                                          color:
                                              Color(constants().secondaryColor),
                                        ),
                                        title: Text(
                                          constants().delete,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            indent: 50,
                            endIndent: 50,
                          )
                        ],
                      );
                    } else {
                      return Container();
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
