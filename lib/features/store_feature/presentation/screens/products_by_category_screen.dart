import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/core/widgets/product_cart.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const CustomHeader(
              title: 'آیفون',
              backButton: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 217,
                  crossAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  return const Expanded(
                    child: Text('data'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
