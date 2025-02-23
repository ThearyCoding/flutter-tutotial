import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutoial/services/token_storage.dart';
import 'package:flutter_tutoial/views/login_page.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../providers/product_provider.dart';
import '../../models/product.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();



  void showBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          RangeValues values = RangeValues(1, 500);

          int value = 0;
          return StatefulBuilder(
            builder: (ctx, setstateModel) => SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ),
                    ),
                    Text(
                      "Filters",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Categories",
                      style: TextStyle(fontSize: 16),
                    ),
                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, widget) => Wrap(
                        spacing: 9,
                        children: List<Widget>.generate(
                            categoryProvider.categories.length, (index) {
                          return ChoiceChip(
                              selected: value == index,
                              label: Text(
                                  categoryProvider.categories[index].name ??
                                      ''),
                              onSelected: (bool selectedValue) {
                                setstateModel(() {
                                  value = index;
                                });
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Price",
                      style: TextStyle(fontSize: 16),
                    ),
                    RangeSlider(
                        divisions: 5,
                        min: 1,
                        max: 500,
                        labels: RangeLabels(
                            values.start.toString(), values.end.toString()),
                        values: values,
                        onChanged: (value) {
                          setstateModel(() {
                            values = value;
                          });
                        }),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0265FF)),
                            onPressed: () async {
                              final categoryid = Provider.of<CategoryProvider>(
                                      context,
                                      listen: false)
                                  .categories[value]
                                  .id;
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .filterProducts(values.start, values.end,
                                      categoryid ?? 0);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ))),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Reset"))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Shop List'),
          actions: [
            IconButton(
                onPressed: () async {
                  await TokenStorage().clearToken();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          filled: true,
                          fillColor: Color.fromARGB(255, 220, 229, 251),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              await productProvider
                                  .searchProductByTitle(_searchController.text);
                            },
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showBottomSheet();
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 7),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 220, 229, 251),
                        ),
                        child: Icon(IconlyBold.filter)),
                  )
                ],
              ),
              Consumer2<CategoryProvider, ProductProvider>(
                builder: (context, categoryProvider, productP, widget) =>
                    categoryProvider.isLoading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: categoryProvider.categories.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  final category =
                                      categoryProvider.categories[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      productProvider
                                          .changeSelectedIndex(index);
                                      await productProvider
                                          .fetchProductByCategoryId(
                                              category.id ?? 0);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Chip(
                                        backgroundColor:
                                            productProvider.selectedIndex ==
                                                    index
                                                ? Colors.blue
                                                : Colors.transparent,
                                        label: Text(
                                          category.name ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                productProvider.selectedIndex ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
              ),
              Expanded(
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, widget) => productProvider
                          .isLoading
                      ? Expanded(
                          child: Center(
                          child: CircularProgressIndicator(),
                        ))
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: productProvider.products.length,
                          itemBuilder: (ctx, index) {
                            final Product product =
                                productProvider.products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                              product: product,
                                            )));
                              },
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Card(
                                    child: Column(
                                  children: [
                                    Flexible(
                                      child: Hero(
                                        tag: product.id ?? 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          product.images![0]))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        product.title ?? 'No title provided',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${product.price ?? 0}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            '${product.category!.name}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ));
  }
}
