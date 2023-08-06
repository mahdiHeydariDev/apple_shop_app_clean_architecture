import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_status.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/widgets/category_cart.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(
      CategoriesSendRequestEvent(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state.status is CategoriesLoadingStatus) {
              return const CustomLoading();
            }
            if (state.status is CategoriesSuccessStatus) {
              return CustomScrollView(
                slivers: <Widget>[
                  const CustomHeader(title: 'دسته بندی'),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid.builder(
                      itemCount: (state.status as CategoriesSuccessStatus)
                          .categoriesResponse
                          .length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 160,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryCart(
                          category: (state.status as CategoriesSuccessStatus)
                              .categoriesResponse[index],
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
