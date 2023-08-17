import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_bloc.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_event.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_state.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_status.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = serviceLocator.get<ThemeBloc>();
        return bloc;
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              setState(() {
                if (state.theme is ThemeDarkStatus) {
                  isDarkTheme = true;
                } else {
                  isDarkTheme = false;
                }
              });
            },
          );
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  const CustomHeader(title: 'تنظیمات'),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          const Row(
                            children: <Widget>[
                              Text(
                                'ظاهر برنامه',
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(15),
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: ConstantsColors.grey,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.mode_night_rounded,
                                  color: ConstantsColors.blue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('حالت شب'),
                                const Spacer(),
                                Switch(
                                  value: isDarkTheme,
                                  focusColor: ConstantsColors.blue,
                                  activeColor: ConstantsColors.blue,
                                  onChanged: (value) {
                                    context.read<ThemeBloc>().add(
                                          ThemeChangeEvent(),
                                        );
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
