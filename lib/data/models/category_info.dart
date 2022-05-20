import 'package:expense_tracker/defines/enums/category_enum.dart';
import 'package:expense_tracker/themes/category_color.dart';
import 'package:flutter/material.dart';

class CategoryInfo {
  String name;
  IconData icon;
  Color color;

  CategoryInfo({required this.name, required this.icon, required this.color});

  static CategoryInfo getCategoryInfo(CategoryEnum categoryId) {
    switch (categoryId) {
      case CategoryEnum.food:
        return CategoryInfo(
            name: 'Food', icon: Icons.lunch_dining, color: CategoryColor.food);
      case CategoryEnum.shopping:
        return CategoryInfo(
            name: 'Shopping',
            icon: Icons.shopping_bag,
            color: CategoryColor.shopping);
      case CategoryEnum.transportation:
        return CategoryInfo(
            name: 'Transportation',
            icon: Icons.commute,
            color: CategoryColor.transportation);
      case CategoryEnum.health:
        return CategoryInfo(
            name: 'Health',
            icon: Icons.health_and_safety,
            color: CategoryColor.health);
      case CategoryEnum.beauty:
        return CategoryInfo(
            name: 'Beauty', icon: Icons.spa, color: CategoryColor.beauty);
      case CategoryEnum.entertainment:
        return CategoryInfo(
            name: 'Entertainment',
            icon: Icons.sentiment_very_satisfied,
            color: CategoryColor.entertainment);
      case CategoryEnum.travel:
        return CategoryInfo(
            name: 'Travel',
            icon: Icons.flight_takeoff,
            color: CategoryColor.travel);
      case CategoryEnum.income:
        return CategoryInfo(
            name: 'Income', icon: Icons.paid, color: CategoryColor.income);
      default:
        return CategoryInfo(
            name: 'Others', icon: Icons.style, color: CategoryColor.others);
    }
  }
}
