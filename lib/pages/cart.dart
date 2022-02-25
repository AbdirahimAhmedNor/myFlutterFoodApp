import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/utils/data.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/theme/color.dart';
import 'package:food_app/widgets/feature_item.dart';


  getCartData() async {
    var url = Uri.parse('http://10.0.2.2:3000/foods/carts');
    var response = await http.get(url);
    return jsonDecode(response.body);
  }


class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override

  @override


  Widget build(BuildContext context) {
    onTapHandler(cart, index, name) async{
      cart.removeAt(index);
      var response = await http.post(Uri.parse('http://192.168.225.2:3000/foods/carts/$name'));
      setState(() {
        cart = cart;
      });
    }

    var carts = getCartData();

    getTotalAmount(data) async {
      double total = 0;
      var carts = await data;
      for (var i = 0; i < carts.length; i++) {
        total += carts[i]['price'];
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Food delivery'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Container(
                  child: FutureBuilder(
                    future: carts,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: List.generate(
                            snapshot.data.length,
                            (index) => FeaturedItem(
                                data: snapshot.data[index],
                                onTap: () =>
                                    onTapHandler(snapshot.data, index, snapshot.data[index]['name'])),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  FutureBuilder(
                    future: getTotalAmount(carts),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '\$ ${snapshot.data.toString()}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        );
                      } else
                        return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
