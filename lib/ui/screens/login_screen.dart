import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/members_provider.dart';

import '../../utils/helper.dart';

import '../widgets/common/alert_dialog.dart';
import '../widgets/common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool hasAccount;

  @override
  void initState() {
    hasAccount = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: Text(
                  "Libreasy",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.75,
              padding: EdgeInsets.symmetric(
                  vertical: 20, horizontal: Helper.hPadding),
              child: Column(
                children: [
                  hasAccount ? SignInWidget() : SignUpWidget(),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hasAccount = !hasAccount;
                      });
                    },
                    child: Text(
                      hasAccount
                          ? "New account? Sign up"
                          : "Already have an account? Sign in",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SignInWidget extends StatefulWidget {
  SignInWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late String email;

  late String password;

  @override
  void initState() {
    email = '';
    password = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final membersProvider =
        Provider.of<MembersProvider>(context, listen: false);
    return Column(
      children: [
        //Widget page
        Text(
          "SIGN IN",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 30),

        //Email
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          hintText: "Email",
          onSubmitted: (val) {
            setState(() {
              email = val;
            });
          },
          prefixIcon: Icons.email,
        ),

        SizedBox(height: 10),

        //Password
        CustomTextField(
          keyboardType: TextInputType.visiblePassword,
          hintText: "Password",
          onSubmitted: (val) {
            setState(() {
              password = val;
            });
          },
          prefixIcon: Icons.lock,
        ),

        SizedBox(height: 20),

        //Forgot
        InkWell(
          onTap: () {},
          child: Text(
            "Forgot password?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),

        SizedBox(height: 20),

        //Button
        ElevatedButton(
          onPressed: () {
            membersProvider.signIn(email: email, password: password);
            if (!membersProvider.loggedIn) {
              showDialog(
                context: context,
                builder: (context) => AlertDialogBox(
                  message: "Failed to sign in. Invalid Credentials",
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            primary: Colors.lightBlueAccent,
          ),
          child: Text(
            "SIGN IN",
            style: TextStyle(
              letterSpacing: 1.4,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpWidget extends StatefulWidget {
  SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late String firstName, lastName, email, password, cPassword;
  late int age;

  @override
  void initState() {
    firstName = '';
    lastName = '';
    email = '';
    password = '';
    cPassword = '';
    age = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final membersProvider =
        Provider.of<MembersProvider>(context, listen: false);
    return Expanded(
      child: Column(
        children: [
          //Label
          Text(
            "SIGN UP",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 15),

          //Name
          Row(
            children: [
              //First Name
              Expanded(
                child: CustomTextField(
                  keyboardType: TextInputType.name,
                  hintText: "First name",
                  onSubmitted: (val) {
                    setState(() {
                      firstName = val;
                    });
                  },
                  prefixIcon: Icons.person,
                ),
              ),

              SizedBox(width: 5),

              //Last Name
              Expanded(
                child: CustomTextField(
                  keyboardType: TextInputType.name,
                  hintText: "Last name",
                  onSubmitted: (val) {
                    setState(() {
                      lastName = val;
                    });
                  },
                  prefixIcon: Icons.person,
                ),
              ),
            ],
          ),

          SizedBox(height: 5),

          //Email
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            onSubmitted: (val) {
              setState(() {
                email = val;
              });
            },
            prefixIcon: Icons.email,
          ),

          SizedBox(height: 5),

          //Password
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            onSubmitted: (val) {
              setState(() {
                password = val;
              });
            },
            prefixIcon: Icons.lock,
          ),

          SizedBox(height: 5),

          //Confirm Password
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            hintText: "Confirm Password",
            onSubmitted: (val) {
              setState(() {
                cPassword = val;
              });
            },
            prefixIcon: Icons.lock,
          ),

          SizedBox(height: 5),

          //Age
          CustomTextField(
            keyboardType: TextInputType.number,
            hintText: "Age",
            onSubmitted: (val) {
              setState(() {
                age = int.tryParse(val) ?? 0;
              });
            },
            prefixIcon: Icons.tag,
          ),

          SizedBox(height: 10),

          //Button
          ElevatedButton(
            onPressed: () async {
              if (password.trim() != cPassword.trim()) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogBox(
                    message: "Passwords don't match",
                  ),
                );
                return;
              }
              if (email.trim().isEmpty ||
                  password.trim().isEmpty ||
                  firstName.trim().isEmpty ||
                  lastName.trim().isEmpty ||
                  age <= 0) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogBox(
                    message: "Please enter all fields",
                  ),
                );
                return;
              }
              await membersProvider.signUp(
                email: email.trim(),
                password: password.trim(),
                firstName: firstName.trim(),
                lastName: lastName.trim(),
                age: age,
              );
              if (!membersProvider.loggedIn) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogBox(
                    message: "Failed to sign up",
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size(MediaQuery.of(context).size.width, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              primary: Colors.lightBlueAccent,
            ),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                letterSpacing: 1.4,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
