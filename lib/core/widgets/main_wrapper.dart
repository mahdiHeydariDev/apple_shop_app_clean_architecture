import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/basket_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/categories_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/home_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/profile_screen.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ConstantsColors.background,
        body: SafeArea(
          child: IndexedStack(
            index: screenIndex,
            children: getScreens(),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  screenIndex = index;
                });
              },
              currentIndex: screenIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: ConstantsColors.blue,
              unselectedItemColor: ConstantsColors.grey,
              selectedLabelStyle: const TextStyle(
                color: ConstantsColors.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                color: ConstantsColors.grey,
              ),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'خانه',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  activeIcon: Icon(Icons.category),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_outlined),
                  activeIcon: Icon(Icons.shopping_basket),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'حساب کاربری',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return [
      BlocProvider(
        create: (context) => serviceLocator.get<HomeBloc>(),
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) => serviceLocator.get<CategoriesBloc>(),
        child: const CategoriesScreen(),
      ),
      const BasketScreen(),
      const ProfileScreen(),
    ];
  }
}
