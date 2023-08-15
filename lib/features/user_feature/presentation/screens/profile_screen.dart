import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_bloc.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_event.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_status.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/screens/login_screen.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/screens/register_screen.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/log_out_button.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkNetwork();
    return BlocProvider(
      create: (context) {
        var bloc = serviceLocator.get<ProfileBloc>();
        bloc.add(
          ProfileCheckSessionEvent(),
        );
        return bloc;
      },
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    const CustomHeader(title: 'حساب کاربری'),
                    if (state.status is ProfileDoesntLoginStatus) ...[
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text('برای خود یک حساب ایجاد کنید.'),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ConstantsColors.blue,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => RegisterBloc(
                                            useCase: serviceLocator.get(),
                                          ),
                                          child: const RegisterScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'ایجاد حساب',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 15),
                                child: Text('حساب کاربری دارید؟ وارد شوید'),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ConstantsColors.green,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value:
                                              serviceLocator.get<ProfileBloc>(),
                                          child: const LoginScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'ورود به حساب',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (state.status is ProfileLoginStatus) ...[
                      const SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'محمد مهدی حیدری',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '09214840491',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: ConstantsColors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LogOutButton(),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 30,
                        ),
                        sliver: SliverGrid.builder(
                          itemCount: 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<ThemeBloc>().add(
                                      ThemeChangeEvent(),
                                    );
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 56,
                                    height: 56,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: ShapeDecoration(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                          40,
                                        ),
                                      ),
                                      shadows: const <BoxShadow>[
                                        BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                          color: ConstantsColors.blue,
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      color: ConstantsColors.blue,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.color_lens_outlined,
                                        color: Colors.white,
                                        size: 45,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'تغییر پوسته',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                if (state.status is ProfileLoadingStatus) ...[
                  const CustomLoading(),
                ],
                const Positioned(
                  bottom: 15,
                  child: Column(
                    children: <Widget>[
                      Text('Powerd By MahdiFlutter'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'VERSION 1.0.0',
                        style: TextStyle(
                          color: ConstantsColors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        )),
      ),
    );
  }

  Future<void> checkNetwork() async {}
}
