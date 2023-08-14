import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_event.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ProfileBloc>(context).add(
          ProfileLogoutSessionEvent(),
        );
      },
      child: Container(
        width: 200,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'خروج از حساب کاربری',
              style: TextStyle(
                color: ConstantsColors.red,
              ),
            ),
            Icon(
              Icons.logout,
              color: ConstantsColors.red,
            ),
          ],
        ),
      ),
    );
  }
}
