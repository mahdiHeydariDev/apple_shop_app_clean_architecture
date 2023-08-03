import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/utils/generators/color_generator.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_status.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/add_to_basket_button.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/drop_down_box.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/price_button.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class DetailProductScreen extends StatefulWidget {
  final ProductEntity product;
  const DetailProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = DetailProductBloc(
          categoryUsecase: serviceLocator.get(),
          galleryImageUsecase: serviceLocator.get(),
          detailProductUsecase: serviceLocator.get(),
          basketUsecase: serviceLocator.get(),
        );
        bloc.add(
          DetailProductSendRequestEvent(
            id: widget.product.category,
            productId: widget.product.id,
          ),
        );
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<DetailProductBloc, DetailProductState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: <Widget>[
                    if (state.status is DetailProductLoadingStatus) ...[
                      const SliverToBoxAdapter(
                        child: Text('Loading...'),
                      )
                    ],
                    if (state.status is DetailProductSuccessStatus) ...[
                      CustomHeader(
                        title: (state.status as DetailProductSuccessStatus)
                            .category
                            .title,
                        backButton: true,
                      ),
                      //header(name of product)
                      ProductName(name: widget.product.name),
                      //Product Gallery
                      ProductGallery(
                        mainImage: widget.product.thumbnail,
                        galleryImages:
                            (state.status as DetailProductSuccessStatus)
                                .galleryImages,
                      ),
                      //select variants
                      VariantsContainer(
                        productVariants:
                            (state.status as DetailProductSuccessStatus)
                                .productVariants,
                      ),

                      //drop down box
                      if (widget.product.description.isNotEmpty) ...[
                        DescriptionDropDowBox(
                          isDescription: true,
                          description: widget.product.description,
                        ),
                      ],
                      if ((state.status as DetailProductSuccessStatus)
                          .properties
                          .isNotEmpty) ...[
                        DescriptionDropDowBox(
                          isDescription: false,
                          properties:
                              (state.status as DetailProductSuccessStatus)
                                  .properties,
                        ),
                      ],
                      // DescriptionDropDowBox(),
                      // DescriptionDropDowBox(),

                      //price & a button to add basket
                      FooterWidget(product: widget.product),
                    ],
                    if (state.status is DetailProductFailedStatus) ...[
                      const SliverToBoxAdapter(
                        child: Text('Failed...'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VariantsContainer extends StatelessWidget {
  final List<ProductVariantEntity> productVariants;
  const VariantsContainer({
    super.key,
    required this.productVariants,
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
            for (var variant in productVariants)
              Variantgenerator(productVariant: variant)
          ],
        ),
      ),
    );
  }
}

class Variantgenerator extends StatelessWidget {
  final ProductVariantEntity productVariant;
  const Variantgenerator({super.key, required this.productVariant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (productVariant.variants.isNotEmpty) ...[
          Text(productVariant.variantType.title),
        ],
        if (productVariant.variantType.type == 'Color') ...[
          ColorVariantGenerator(colors: productVariant.variants),
        ],
        if (productVariant.variantType.type == 'Storage') ...[
          StorageVariantGenerator(storages: productVariant.variants),
        ],
      ],
    );
  }
}

class ColorVariantGenerator extends StatefulWidget {
  final List<VariantEntity> colors;
  const ColorVariantGenerator({
    super.key,
    required this.colors,
  });

  @override
  State<ColorVariantGenerator> createState() => _ColorVariantGeneratorState();
}

class _ColorVariantGeneratorState extends State<ColorVariantGenerator> {
  int currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.colors.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      currentSelected = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear,
                    margin: const EdgeInsets.only(left: 10),
                    width: index == currentSelected ? 67 : 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Color(
                        colorGenerator(color: widget.colors[index].value),
                      ),
                      borderRadius: BorderRadius.circular(
                        9,
                      ),
                    ),
                    child: currentSelected == index
                        ? Center(
                            child: Text(
                              widget.colors[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantGenerator extends StatefulWidget {
  final List<VariantEntity> storages;
  const StorageVariantGenerator({super.key, required this.storages});

  @override
  State<StorageVariantGenerator> createState() =>
      _StorageVariantGeneratorState();
}

class _StorageVariantGeneratorState extends State<StorageVariantGenerator> {
  int currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storages.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      currentSelected = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear,
                    margin: const EdgeInsets.only(left: 10),
                    width: 67,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: currentSelected == index
                            ? ConstantsColors.blue
                            : ConstantsColors.grey,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.storages[index].value} GB',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: currentSelected == index
                              ? ConstantsColors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductGallery extends StatefulWidget {
  final String mainImage;
  final List<GalleryImageEntity> galleryImages;
  const ProductGallery({
    super.key,
    required this.mainImage,
    required this.galleryImages,
  });

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  int currentSelected = 0;
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 148,
                          child: CustomCachedImage(
                            imageUrl: widget.galleryImages.isNotEmpty
                                ? widget.galleryImages[currentSelected].imageUrl
                                : widget.mainImage,
                            fixed: true,
                            rounded: false,
                          ),
                        ),
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
                    itemCount: widget.galleryImages.length,
                    itemBuilder: (context, index) {
                      //return column for solve the size problem in list view builder on items
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentSelected = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: currentSelected == index
                                      ? ConstantsColors.blue
                                      : ConstantsColors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: CustomCachedImage(
                                imageUrl: widget.galleryImages[index].imageUrl,
                                rounded: true,
                                fixed: true,
                              ),
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
  final String name;
  const ProductName({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20),
      sliver: SliverToBoxAdapter(
        child: Text(
          name,
          style: const TextStyle(
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
  final ProductEntity product;
  const FooterWidget({
    required this.product,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AddToBasketButton(product: product),
            const SizedBox(
              width: 20,
            ),
            PriceButton(
              realPrice: product.realPrice,
              price: product.price,
              percent: product.percent,
            ),
          ],
        ),
      ),
    );
  }
}
