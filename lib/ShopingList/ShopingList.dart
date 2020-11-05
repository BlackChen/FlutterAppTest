import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ShoppingListItem.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, products}) : super(key: key);

  final List<Product> products = [
    new Product(name: 'Flower'),
    new Product(name: 'Flour'),
    new Product(name: 'Chocolate chips'),
  ];

  @override
  createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Product> _shoppingCart = new List<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When user changes what is in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      // body: new ListView(
      //   padding: new EdgeInsets.symmetric(vertical: 8.0),
      //   children: widget.products.map((Product product) {
      //     return new ShoppingListItem(
      //       product: product,
      //       inCart: _shoppingCart.contains(product),
      //       onCartChanged: _handleCartChanged,
      //     );
      //   }).toList(),
      // ),
      body: new ListView.builder(
        itemCount: _shoppingCart.length,
        itemBuilder: (context, index) {
          Product p =  _shoppingCart[index];
          return new ShoppingListItem(
            product: p,
            inCart: _shoppingCart.contains(p),
            onCartChanged: _handleCartChanged,
          );
        },
      ),
    );
  }
}
