import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/category_cart.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const CustomHeader(title: 'دسته بندی'),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (context, index) {
                  return const CategoryCart();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
