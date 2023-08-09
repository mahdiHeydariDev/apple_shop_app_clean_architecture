import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/form_text.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_status.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/screens/login_screen.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_button.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_text_field.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/form_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ConstantsColors.background,
        body: SafeArea(
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state.status is RegisterSuccessResponseStatus) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        alignment: Alignment.center,
                        content: const Text(
                          'حساب شما با موفقیت ایجاد شد.',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'ورود به حساب',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                });
              }
              if (state.status is RegisterInitStatus) {
                return CustomScrollView(
                  slivers: <Widget>[
                    const CustomFormHeader(text: 'ثبت نام در اپل لند'),
                    if (state.status is RegisterInitStatus) ...[
                      FormContainer(
                        fields: [
                          CustomTextField(
                            hintText: 'نام کاربری',
                            icon: Icons.person_outline,
                            controller: userNameController,
                            haveError: (state.status as RegisterInitStatus)
                                        .errorCode ==
                                    1
                                ? true
                                : false,
                            errorText: FormText.userNameEmpty,
                          ),
                          CustomTextField(
                            hintText: 'رمز عبور',
                            icon: Icons.lock_outline,
                            controller: passwordController,
                            isSecret: true,
                            haveError: (state.status as RegisterInitStatus)
                                        .errorCode ==
                                    2
                                ? true
                                : false,
                            errorText: FormText.passwordEmpty,
                          ),
                          CustomTextField(
                            hintText: 'تکرار رمز عبور',
                            icon: Icons.lock_outline,
                            controller: passwordConfirmController,
                            isSecret: true,
                            haveError: (state.status as RegisterInitStatus)
                                        .errorCode ==
                                    3
                                ? true
                                : false,
                            errorText: FormText.notEqualPasswords,
                          ),
                          (state.status as RegisterInitStatus).errorCode == 400
                              ? const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'این نام کاربری قبلاً ثبت شده است.',
                                    style: TextStyle(
                                      color: ConstantsColors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : const Row(),
                          CustomButton(
                            text: 'ثبت نام',
                            whenClick: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                RegisterSendRequestEvent(
                                  userName: userNameController.text,
                                  password: passwordController.text,
                                  passwordConfirm:
                                      passwordConfirmController.text,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'با ثبت نام در اپل لند ، قوانین و شرایط را می پذیرید.',
                            style: TextStyle(
                              color: ConstantsColors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ],
                );
              }
              if (state.status is RegisterLoadingStatus) {
                return const CustomLoading();
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
// if (state.status is RegisterLoadingStatus) ...[
//                   SliverToBoxAdapter(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 50,
//                       ),
//                       padding: const EdgeInsets.all(50),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadiusDirectional.circular(15),
//                         color: Colors.white,
//                       ),
//                       child: const CustomLoading(),
//                     ),
//                   )
//                 ],