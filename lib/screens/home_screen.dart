import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state/products.dart';
import 'wish_list_screen.dart';

class HomeScreen extends StatelessWidget {
  // Instantiate our Products class using Get.put()
  final Products _p = Get.put(Products());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff20416),
        title: Text('Upcoming Game Releases'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // This button also shows you how many items in the wish list
          // It lets you go to the WishListScreen
          InkWell(
            child: Container(
              width: 300,
              height: 80,
              color: Colors.black,
              alignment: Alignment.center,

              // Use Obx(()=> to update Text() whenever _wishList.items.length is changed
              child: Obx(() => Text(
                    'Wish List: ${_p.wishListItems.length}',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WishListScreen())),
          ),

          SizedBox(
            height: 20,
          ),

          Expanded(
              child: ListView.builder(
                  itemCount: _p.items.length,
                  itemBuilder: (context, index) {
                    final product = _p.items[index];
                    return Card(
                      key: ValueKey(product.id),
                      margin: EdgeInsets.all(5),
                      color: Colors.grey,
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                        trailing: Obx(() => IconButton(
                              onPressed: () {
                                if (product.inWishList.value == false) {
                                  _p.addItem(product.id);
                                } else {
                                  _p.removeItem(product.id);
                                }
                              },
                              icon: Icon(
                                Icons.favorite_rounded,
                                color: product.inWishList.value == false
                                    ? Colors.white
                                    : Colors.red,
                              ),
                            )),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
