
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertask/src/data/database/database_helper.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  var priceTotal = 0.0;

  void _removeFromCart(ProductModel product) {
    setState(() {
      db.delete(product.id!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 28,
          ),
        ),

        title: Text(
          "Cart",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: db.getAllProducts(),
            builder: (contex, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {

                  if (snapshot.hasData) {
                    List<ProductModel> productList = snapshot.data!;

                    return CartList(
                      product: productList[index],
                      onRemove: _removeFromCart,
                    );
                  }
                },
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: FutureBuilder<String>(
                      future: db.getTotalPriceFromDatabase(),
                      builder: (contex, snapshot) {


                        if(snapshot.hasError){
                          print("SnapError: ${snapshot.error}");

                          return const SizedBox();
                        }else{
                          return Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child:  Center(
                                child: Text(
                                  "Total Price : ${snapshot.data??"0.0"}",
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                )),
                          );

                        }
                      }))
            ],
          )
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  final ProductModel product;
  final Function(ProductModel) onRemove;

  const CartList({super.key, required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.black12,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title!,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(product.description!),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toString()}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => onRemove(product),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text(
                        'Remove from Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
