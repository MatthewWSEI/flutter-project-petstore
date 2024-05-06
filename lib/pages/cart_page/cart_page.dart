import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_store/components/button.dart';
import 'package:flutter_project_store/model/product.dart';
import 'package:flutter_project_store/model/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(Product product, BuildContext context) {
    final shop = context.read<Shop>();

    shop.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'CART',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                centerTitle: true,
                elevation: 0,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.cart.length,
                      itemBuilder: (context, index) {
                        final Product product = value.cart[index] as Product;

                        final String productName = product.name;
                        final int productPrice = product.price;

                        return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 20),
                          child: ListTile(
                            title: Text(productName),
                            subtitle: Text("\$ ${productPrice.toString()}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeFromCart(product, context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(text: 'Pay Now', onTap: () {}),
                  )
                ],
              ),
            ));
  }
}
