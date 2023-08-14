import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/core/widgets/server_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_status.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/category_slider.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/products_slider.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/search_box.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/slider.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

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
    InternetConnectionChecker().onStatusChange.listen((status) {
      BlocProvider.of<HomeBloc>(context).add(
        HomeSendRequestEvent(),
      );
    });
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
          }
          if (state.status is HomeNotConnectionStatus) {
            return const NetworkErrorWidgte();
          }
          if (state.status is HomeFailedStatus) {
            return const ServerError();
          } else {
            return Container();
          }
        },
      )),
    );
  }
}

class NetworkErrorWidgte extends StatelessWidget {
  const NetworkErrorWidgte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/images/brokenconnection.png',
              fit: BoxFit.cover,
              color: ConstantsColors.blue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'اتصال اینترنت شما وجود ندارد!',
            style: TextStyle(
              color: ConstantsColors.blue,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'لطفاً اتصال اینترنتی خود را برقرار کنید و دوباره امتحان نمایید.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(
                HomeSendRequestEvent(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: ConstantsColors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'تلاش مجدد',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
