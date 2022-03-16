import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ShoppingListItem.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, products}) : super(key: key);
//初始数据
  final List<Product> products = [
    new Product(name: 'Flower'),
    new Product(name: 'Flour'),
    new Product(name: 'Chocolate chips'),
    new Product(name: 'Chocolate chips'),
    new Product(name: 'Chocolate chips'),
    new Product(name: 'Chocolate chips'),
    new Product(name: 'Chocolate chips'),

  ];

  @override
  createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  //对比数据
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
    //1. 点击时启动SelectionScreen
    //2. 等待SelectionScreen返回结果
    _navigateAndDisplaySelection(BuildContext context) async {
      // Navigator.push returns a Future that will complete after we call
      // Navigator.pop on the Selection Screen!
      final result = await Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new SelectionScreen()),
      );
      // After the Selection Screen returns a result, show it in a Snackbar!
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$result")));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
        actions: [

          CupertinoButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
              },
            child: Text('值回传!',
              style: TextStyle(
                color: Colors.red[700],
              ),
            ),
          ),
        ],
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
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          Product p =  widget.products[index];
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

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pick an option'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result
                  Navigator.pop(context, 'Yep!');
                },
                child: new Text('Yep!'),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result
                  Navigator.pop(context, 'Nope.');
                },
                child: new Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}