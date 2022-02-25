import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/notification_box.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/pages/cart.dart';
import 'package:food_app/theme/color.dart';

class FoodDetailScreen extends StatefulWidget {
  FoodDetailScreen({Key? key, required this.data}) : super(key: key);
  final data;
  originalPrice() {
    return data['price'];
  }

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  int portion = 1;
  double price = 0;
  Widget build(BuildContext context) {
    final foodData = widget.data;
    price = foodData['price'];
    saveFood(food) async {
      Map<dynamic, dynamic> data = {
        "name": food['name'],
        "imageUrl": food['imageUrl'],
        "price": food['price'].toString(),
        "source": food['source'],
      };
      // print(data.runtimeType);
      try {
        var url = Uri.parse('http://192.168.225.2:3000/foods/add');
        var response = await http.post(url, body: data);
        if (response.body == 'exists') {
          Fluttertoast.showToast(
            msg: "item existed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Saved",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.clear_all_rounded,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 0, right: 0),
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(foodData['imageUrl']))),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foodData['name'],
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text('\$ ${foodData['price']}',
                          style: TextStyle(
                              color: primary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    foodData['description'],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Number of portion',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  price = price / portion;
                                  price =
                                      double.parse(price.toStringAsFixed(3));
                                  setState(() {
                                    portion++;
                                    foodData['price'] =
                                        price + foodData['price'];
                                    foodData['price'] = double.parse(
                                        foodData['price'].toStringAsFixed(3));
                                  });
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  shape: StadiumBorder(),
                                  backgroundColor: secondary,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(82),
                                color: Colors.white,
                                border: Border.all(color: secondary),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text('$portion'),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 60,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  print(
                                      "foodData runtim ${foodData['price'].runtimeType}");
                                  if (portion >= 2) {
                                    print('this is the portion');
                                    price = price / portion;
                                    price =
                                        double.parse(price.toStringAsFixed(3));
                                    print(price);
                                    print(portion);
                                    setState(() {
                                      portion--;
                                      foodData['price'] =
                                          foodData['price'] - price;
                                      foodData['price'] = double.parse(
                                          foodData['price'].toStringAsFixed(3));
                                    });
                                  }
                                },
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    backgroundColor: secondary,
                                    shape: StadiumBorder()),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          saveFood(foodData);
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: secondary),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 24, letterSpacing: 1.6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
