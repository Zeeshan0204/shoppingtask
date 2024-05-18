import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertask/core/utils/routes_strings.dart';
import 'package:fluttertask/presentation/bloc_logic/category_bloc/category_bloc.dart';
import 'package:fluttertask/presentation/bloc_logic/product_bloc/product_bloc.dart';
import 'package:fluttertask/presentation/screens/cart_screen.dart';
import 'package:fluttertask/presentation/screens/product_detail.dart';
import 'package:fluttertask/presentation/screens/widgets/product_widgets.dart';
import 'package:fluttertask/src/data/api_constants/api_urls.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fluttertask/src/data/database/database_helper.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<ProductModel> productList=[];
  List<ProductModel> searchList=[];

  bool isSearchStated=false;




  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRefreshEvent(context));

    BlocProvider.of<ProductBloc>(context).add(ProductRefreshEvent(context,""));

    super.initState();
  }

 final DatabaseHelper db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search by here',
                          hintStyle: const TextStyle(color: Color(0xff969DA5),
                              fontSize: 14, letterSpacing: 0.5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,size: 25,
                            color: Color(0xff1C1B1F),
                          ),
                          fillColor: Color(0xffF7F9FF),
                          filled: true),
                      onChanged: (search) =>  EasyDebounce.debounce(

                        'tFMemberController',
                        Duration(milliseconds: 5), () {
                        print("SearchData : ${search.toString()}");
                        isSearchStated = search.isNotEmpty && search.isNotEmpty;
                        print("SearchStarted : $isSearchStated");
                        setState(() {
                          if (isSearchStated) {
                            print(search.trim());
                            searchList = productList
                                .where((item) => item.title.toString().toLowerCase().contains(search.toLowerCase()) ||
                                item.price!.toString().toLowerCase().contains(search.toLowerCase()),
                            ).toList();
                            print("SearchResident : ${searchList.toString()}");
                          }
                        });
                      },
                      ),
                    ),
                    ),
                  ),

                 FutureBuilder(future: db.getProductCount(),
                     builder: (context,snapshot){

                     return InkWell(

                       onTap: (){
                         Navigator.pushNamed(
                           context,
                           RouteString.cart,
                         ).then((_) {
                           // Call setState when returning from the NextScreen
                           setState(() {
                             // Update your state here
                           });
                         });
                       },
                       child: badges.Badge(
                         badgeContent: Text(snapshot.data.toString()),
                         child: const Icon(Icons.shopping_cart),
                       ),
                     );

                     })

              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            BlocBuilder<CategoryBloc,CategoryState>(builder:(context,state){

              if(state is CategorySuccess){
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categoryModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          isSearchStated=false;
                          _searchController.clear();
                          BlocProvider.of<ProductBloc>(context).add(ProductRefreshEvent(context,"/${ApiUrls.categoryData}${state.categoryModel[index].name}"));
                        },
                        child: Container(
                          width: 150.0,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              state.categoryModel[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }



              return const SizedBox();
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<ProductBloc,ProductState>(builder:(context, state) {



                if(state is ProductLoading){
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if(state is ProductSuccess){

                  if (isSearchStated) {
                    print("SearchStarted");
                    productList = searchList;
                  } else {
                    print("SearchEnded");
                    productList = state.productModel;
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        // Calculate the number of columns based on the container width
                        int crossAxisCount = (constraints.maxWidth / 150).floor(); // Example: each item takes 150px

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount, // Dynamic columns count
                              crossAxisSpacing: 10.0, // Spacing between each column
                              mainAxisSpacing: 10.0, // Spacing between each row
                              childAspectRatio: 1,
                              mainAxisExtent: 270
                          ),
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(productList[index]))).then((_) {
                                  // Call setState when returning from the NextScreen
                                  setState(() {
                                    // Update your state here
                                  });
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(4),
                                child: Center(
                                  child: ProductCard(
                                      product: productList[index]
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );


                }

                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }


}
