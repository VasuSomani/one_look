import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/utils/todo_update.dart';
import '../../Constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(this.onPressed, this.text, {this.isLoading = false});
  final Function()? onPressed;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: (isLoading)
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  SecondaryButton(this.onPressed, this.text);
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Color(0xFFD0D1FF)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(width: 2, color: primaryColor)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.onPressed, required this.isLogin})
      : super(key: key);
  final Function()? onPressed;
  final bool isLogin;
  final String imgURL = 'assets/icons/google.png';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              side: const MaterialStatePropertyAll(
                  BorderSide(width: 1, color: CupertinoColors.systemGrey3)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: const MaterialStatePropertyAll(Colors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  imgURL,
                  scale: 0.9,
                ),
              ),
              (isLogin)
                  ? Text("Sign in with Google",
                      style: Theme.of(context).textTheme.bodyLarge)
                  : Text("Sign up with Google",
                      style: Theme.of(context).textTheme.bodyLarge)
            ],
          )),
    );
  }
}

class TileMenuButton extends StatelessWidget {
  const TileMenuButton(
      {Key? key, required this.updateFunction, required this.deleteFunction})
      : super(key: key);
  final VoidCallback updateFunction;
  final VoidCallback deleteFunction;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          updateFunction();
        } else if (value == 'delete') {
          deleteFunction();
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        double height = 35;
        return [
          PopupMenuItem<String>(
            height: height,
            value: 'edit',
            child: Text(
              'Edit',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            height: height,
            child: Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ];
      },
      icon: const Icon(
        Icons.more_vert_rounded,
        color: darkGrey,
      ),
    );
  }
}
