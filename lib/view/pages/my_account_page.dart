import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Constants/colors.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor2,
        elevation: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("My Account"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Add Photo",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                  radius: 80,
                  backgroundColor: bgColor2,
                  child: ClipOval(child: Image.asset('assets/images/me.png'))),
            ),
            const SizedBox(height: 60),
            Text(
              "Change Name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                hintText: "Enter your new name",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Change Email ID",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                hintText: "Enter your new email ID",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Change Password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                hintText: "Enter your new password",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
