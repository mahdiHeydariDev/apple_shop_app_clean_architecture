import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';

class SliderCustom extends StatelessWidget {
  const SliderCustom({
    super.key,
    required this.sliderController,
    required this.banners,
  });
  final PageController sliderController;
  final List<BannerEntity> banners;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        bottom: 32,
      ),
      sliver: SliverToBoxAdapter(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              height: 177,
              child: PageView.builder(
                pageSnapping: true,
                controller: sliderController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    width: 340,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CustomCachedImage(
                      imageUrl: banners[index].thumbnail!,
                      rounded: true,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 8.0,
              child: SmoothPageIndicator(
                controller: sliderController, // PageController
                count: 3,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 8,
                  dotColor: Colors.white,
                  activeDotColor: ConstantsColors.blue,
                  dotHeight: 8,
                  dotWidth: 8,
                ), // your preferred effect
                onDotClicked: (index) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
