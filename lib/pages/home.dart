import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/theme/color.dart';
import 'package:food_app/utils/data.dart';
import 'package:food_app/widgets/category_item.dart';
import 'package:food_app/widgets/custom_textbox.dart';
import 'package:food_app/widgets/feature_item.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/widgets/notification_box.dart';
import 'package:food_app/widgets/popular_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  getData() async {
    print('trying to get the data');
    var url = Uri.parse('http://10.0.2.2:3000/foods/');
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(78, 0, 0, 0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.clear_all_rounded,
                      size: 28,
                    ))),
            NotificationBox(
              number: 1,
            )
          ],
        ),
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Hello Sangvaleap!",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Find Your Meals",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: CustomTextBox(
                  hint: "Search",
                  prefix: Icon(Icons.search, color: darker),
                  suffix: Icon(Icons.filter_list_outlined, color: primary))),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: 0),
            child: listCategories(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 400,
            child: listPopulars(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  listCategories() {
    List<Widget> lists = List.generate(
        categories.length, (index) => CategoryItem(data: categories[index]));
    lists.insert(
        0,
        CategoryItem(
          data: {
            "name": "All",
            "icon": FontAwesomeIcons.th,
          },
          seleted: true,
        ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  listPopulars() {
    var data = getData();

    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(snapshot.data.length,
                  (index) => PopularItem(data: snapshot.data[index])),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
