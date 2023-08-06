import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_status.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/category_slider.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/products_slider.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/search_box.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(
      HomeSendRequestEvent(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController sliderController = PageController(
      viewportFraction: 0.9,
      initialPage: 1,
    );
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status is HomeLoadingStatus) {
            return const CustomLoading();
          }
          if (state.status is HomeSuccessStatus) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<HomeBloc>(context).add(
                  HomeSendRequestEvent(),
                );
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  const CustomSearchBox(),
                  SliderCustom(
                    sliderController: sliderController,
                    banners: (state.status as HomeSuccessStatus).banners,
                  ),
                  CategorySlider(
                    categories: (state.status as HomeSuccessStatus).categories,
                  ),
                  ProductsSlider(
                    title: 'محبوب ترین ها⚡️',
                    products:
                        (state.status as HomeSuccessStatus).hotestProducts,
                  ),
                  ProductsSlider(
                    title: 'پرفروش ترین ها🔥',
                    products:
                        (state.status as HomeSuccessStatus).bestSellerProducts,
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
