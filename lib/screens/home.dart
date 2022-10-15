import 'dart:convert' as convert;
import 'dart:developer';

import '/model/user_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;

import '../model/user_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  String search = '';

  List<UserAPIModel> userList = [];
  Future<void> getUserApi() async {
    print('api called');
    final response =
        await htpp.get(Uri.parse('https://gorest.co.in/public-api/users'));

    final data = convert.jsonDecode(response.body);
    //log(data.toString());
    print(data);
    for (var json in data['data']) {
      userList.add(UserAPIModel.fromJson(json));
      print(userList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Icon(
          Icons.search,
          color: Colors.black,
        )
      ], title: Text('Api Call')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                hintText: 'Search Name',
              ),
              onChanged: (String value) {
                print(value);
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Icon(Icons.circle_outlined);
                  } else {
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        late String postion = index.toString();
                        if (searchController.text.isEmpty) {
                          return Card(
                            child: Column(
                              children: [
                                ReRaww(
                                    titel: 'name',
                                    value: userList[index].name.toString()),
                                FittedBox(
                                  child: ReRaww(
                                      titel: 'email',
                                      value: userList[index].email.toString()),
                                ),
                              ],
                            ),
                          );
                        } else if (userList[index]
                            .name
                            .toString()
                            .toLowerCase()
                            .contains(search.toLowerCase())) {
                          return Card(
                            child: Column(
                              children: [
                                ReRaww(
                                    titel: '',
                                    value: userList[index].name.toString()),
                                FittedBox(
                                  child: ReRaww(
                                      titel: "",
                                      value: userList[index].email.toString()),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                        // return Card(
                        //   child: Column(
                        //     children: [
                        //       ReRaww(
                        //           titel: 'name',
                        //           value: userList[index].name.toString()),
                        //       FittedBox(
                        //         child: ReRaww(
                        //             titel: 'email',
                        //             value: userList[index].email.toString()),
                        //       ),
                        //     ],
                        //   ),
                        // );r
                      },
                    );
                  }
                })),
          )
        ],
      ),
    );
  }
}

class ReRaww extends StatelessWidget {
  String titel, value;

  ReRaww({Key? key, required this.titel, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
