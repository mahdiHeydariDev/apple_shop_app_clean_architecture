import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/form_text.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/core/widgets/server_error.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_status.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_button.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_text_field.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/form_container.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = LoginBloc(
          serviceLocator.get(),
          serviceLocator.get(),
        );
        bloc.add(
          LoginInitEvent(),
        );
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.status is LoginLoadingStatus) {
                return const CustomLoading();
              }
              if (state.status is LoginInitStatus) {
                return CustomScrollView(
                  slivers: <Widget>[
                    const CustomFormHeader(
                      text: 'ورود به اپل لند',
                    ),
                    FormContainer(
                      fields: [
                        CustomTextField(
                          hintText: 'نام کاربری',
                          icon: Icons.person_outline,
                          controller: userNameController,
                        ),
                        CustomTextField(
                          hintText: 'رمز عبور',
                          icon: Icons.lock_outline,
                          controller: passwordController,
                          isSecret: true,
                        ),
                        (state.status as LoginInitStatus).error == 400
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  FormText.incorrectUsername,
                                  style: TextStyle(
                                    color: ConstantsColors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : Container(),
                        CustomButton(
                          text: 'ورود',
                          whenClick: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginSendRequestEvent(
                                identity: userNameController.text,
                                password: passwordController.text,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          FormText.acceptPrivecy,
                          style: TextStyle(
                            color: ConstantsColors.grey,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
              if (state.status is LoginSuccessResponseStatus) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    BlocProvider.of<ProfileBloc>(context).add(
                      ProfileCheckSessionEvent(),
                    );
                    Navigator.pop(context);
                  },
                );
              }
              if (state.status is LoginFailedResponseStatus) {
                return const ServerError();
              }
              return Container();
            },
          )),
        ),
      ),
    );
  }
}
