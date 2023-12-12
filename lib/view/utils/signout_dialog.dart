import 'package:flutter/material.dart';
import 'package:todo/view/utils/snackbar.dart';

import '../../Constants/colors.dart';
import '../../services/auth_service.dart';
import 'buttons.dart';

void signoutDialog(BuildContext context) {
  {
    AuthService authService = AuthService();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Confirm Logout'),
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
              content: const Text('Are you sure you want to logout?'),
              contentTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: primaryColor)),
                ),
                PrimaryButton(() async {
                  await authService.signOut(context).then((value) {
                    showCustomSnackBar("Logged out successfully", context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  });
                }, "Log Out"),
              ],
            ));
  }
}
