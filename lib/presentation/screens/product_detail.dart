import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertask/core/utils/common.dart';
import 'package:fluttertask/src/data/database/database_helper.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  ProductModel? productModelDetails;
  ProductDetail(this.productModelDetails,{super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  final DatabaseHelper db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          widget.productModelDetails!.category.toString().toUpperCase(),
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,

      ),
      body: SafeArea(
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    widget.productModelDetails!.image.toString()),
                fit: BoxFit.fill),
          ),
        ),
      ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Details :-',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text('\$${widget.productModelDetails!.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16,color: Colors.blueAccent),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Text('Product Name:- ${widget.productModelDetails!.title}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(widget.productModelDetails!.rating!.rate.toString()),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${widget.productModelDetails!.rating!.count} ratings)',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Text('Product Description:- ${widget.productModelDetails!.description}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                     ElevatedButton(
                      onPressed: (){
                        db.insertProduct(widget.productModelDetails!!);

                        Common.toastWarning(context, "Added to cart successfully !!");

                        Navigator.pop(context);
                      },
                      child: Text("Add To Cart"),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
