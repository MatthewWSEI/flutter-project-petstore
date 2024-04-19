import "package:flutter/material.dart";

void dispalyMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}

String formatPrice(int price) {
  return "\$ ${price.toStringAsFixed(2)}";
}
