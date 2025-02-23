import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tutoial/providers/cart_provider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Color(0xffF7F6FC),
        appBar: AppBar(
          backgroundColor: Color(0xffF7F6FC),
          title: Text(
            "My Cart",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<CartProvider>(
          builder: (ctx, cartProvider, _) => Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.carts.length,
                      itemBuilder: (ctx, index) {
                        final cart = cartProvider.carts[index];
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              CustomSlidableAction(
                                  padding: EdgeInsets.all(10),
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor: Color(0xffFE474C),
                                  onPressed: (context) {
                                    cartProvider.removeCart(cart);
                                  },
                                  child: Icon(
                                    IconlyBold.delete,
                                    size: 25,
                                  ))
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: .2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              cart.product.images![0]))),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.product.title ?? '',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        cart.product.category!.name ?? '',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$${cart.product.price!.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            spacing: 8,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider.updateQty(
                                                      cart.product.id ?? 0,
                                                      cart.quantity - 1);
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors
                                                            .grey.shade300),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Text(cart.quantity.toString()),
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider.updateQty(
                                                      cart.product.id ?? 0,
                                                      cart.quantity + 1);
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color:
                                                            Color(0xff7963EA)),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total \$100 ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff7963EA)),
                      child: Text("CheckOut",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
