import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_status.dart';
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
    return Scaffold(
      backgroundColor: ConstantsColors.background,
      body: SafeArea(child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
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
                    ),
                    CustomTextField(
                      hintText: 'رمز عبور',
                      icon: Icons.lock_outline,
                      controller: passwordController,
                      isSecret: true,
                    ),
                    CustomTextField(
                      hintText: 'تکرار رمز عبور',
                      icon: Icons.lock_outline,
                      controller: passwordConfirmController,
                      isSecret: true,
                    ),
                    CustomButton(
                      text: 'ثبت نام',
                      whenClick: () {
                        BlocProvider.of<RegisterBloc>(context).add(
                          RegisterSendRequestEvent(
                            userName: userNameController.text,
                            password: passwordConfirmController.text,
                            passwordConfirm: passwordConfirmController.text,
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
              if (state.status is RegisterLoadingStatus) ...[
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 50,
                    ),
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color: Colors.white,
                    ),
                    child: const CustomLoading(),
                  ),
                )
              ],
              if (state.status is RegisterSuccessResponseStatus) ...[
                const SliverToBoxAdapter(
                  child: Text('KOSS'),
                )
              ],
              if (state.status is RegisterFailedResponseStatus) ...[
                const SliverToBoxAdapter(
                  child: Text('KIRRR'),
                )
              ]
            ],
          );
        },
      )),
    );
  }
}
