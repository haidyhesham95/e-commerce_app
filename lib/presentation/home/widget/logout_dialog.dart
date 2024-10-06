import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/style/color.dart';
import '../../auth/view/login.dart';
import '../manager/home_cubit.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key,});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: AppColors.blue)),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.blue),

          ),
          onPressed: (){
            context.read<HomeCubit>().logOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
          child: const Text('Logout', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
