import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, images;

  final double price;

  Product({
    required this.images,
    required this.id,
    required this.title,
    required this.price,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: "images/item.png",
    title: "Cá hồi",
    price: 64.99,
  ),
  Product(
    id: 2,
    images: "images/item.png",
    title: "Cơm chiên dương châu",
    price: 50.5,
  ),
  Product(
    id: 3,
    images: "images/item.png",
    title: "Gà sốt mắm",
    price: 36.55,
  ),
  Product(
    id: 4,
    images: "images/item.png",
    title: "Bún bò",
    price: 20.20,
  ),
];
