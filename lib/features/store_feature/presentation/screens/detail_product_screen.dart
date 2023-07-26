import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/add_to_basket_button.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/drop_down_box.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/price_button.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            CustomHeader(
              title: 'آیفون',
              backButton: true,
            ),
            //header(name of product)
            ProductName(),
            //Product Gallery
            ProductGallery(),
            //select variants
            VariantGenerator(),
            //drop down box
            DropDowBox(),
            DropDowBox(),
            DropDowBox(),

            //price & a button to add basket
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}

class VariantGenerator extends StatelessWidget {
  const VariantGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'انتخاب رنگ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 26,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: 26,
                          height: 26,
                          color: Colors.red,
                          margin: const EdgeInsets.only(left: 10),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductGallery extends StatelessWidget {
  const ProductGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //top of gallery(main image or selected image by user)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.bookmark_add_outlined,
                      size: 25,
                    ),
                    SizedBox(
                      width: 101,
                      height: 148,
                      child: Image.asset(
                        'assets/images/pro.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Row(
                      children: <Widget>[
                        Text(
                          '4.5/5',
                        ),
                        Icon(
                          Icons.star_rounded,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //bottom of gallery (list of images are in a slider and user can select)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      //return column for solve the size problem in list view builder on items
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ConstantsColors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductName extends StatelessWidget {
  const ProductName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.only(bottom: 20),
      sliver: SliverToBoxAdapter(
        child: Text(
          'آیفون 13 پرو مکس',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AddToBasketButton(),
            SizedBox(
              width: 20,
            ),
            PriceButton(),
          ],
        ),
      ),
    );
  }
}
