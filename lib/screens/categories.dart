import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/category.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/meals.dart';
import 'package:flutter_meals_app/widgets/category_grid_item.dart';
import 'package:flutter_meals_app/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  // 只有一個動畫控制器，所以使用SingleTickerProviderStateMixin，如果有多個動畫控制器，則使用TickerProviderStateMixin
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); //Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
              // position: _animationController.drive(
              //   Tween(
              //     begin: const Offset(0, 0.3),
              //     end: const Offset(0, 0),
              //   ),
              // ),
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
              ),

              child: child,
            ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //       animation: _animationController,
  //       builder: (context, child) => GridView(  // 這種寫法會導致每次build都會重新創建GridView，不推薦
  //             padding: const EdgeInsets.all(24),
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               childAspectRatio: 3 / 2,
  //               crossAxisSpacing: 20,
  //               mainAxisSpacing: 20,
  //             ),
  //             children: [
  //               for (final category in availableCategories)
  //                 CategoryGridItem(
  //                   category: category,
  //                   onSelectCategory: () {
  //                     _selectCategory(context, category);
  //                   },
  //                 ),
  //             ],
  //           ));
  // }
}
