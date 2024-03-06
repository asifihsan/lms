// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:library_management_system/utils/enums/page_type_enum.dart';
import 'package:provider/provider.dart';

import '../../../providers/members_provider.dart';

import '../../../utils/helper.dart';

import '../common/alert_dialog.dart';
import '../common/custom_text_field.dart';

class MemberActions extends StatefulWidget {
  @override
  _MemberActionsState createState() => _MemberActionsState();
}

class _MemberActionsState extends State<MemberActions> {
  late String _action;
  late String _email;
  late String _bio;
  late String _password;
  late int _age;

  initState() {
    _action = '';
    super.initState();
  }

  Widget confirmCancelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _action = '';
            });
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () async {
            final memberProvider =
                Provider.of<MembersProvider>(context, listen: false);
            bool updated = await memberProvider.changeProfileData(
                email: _email, password: _password, bio: _bio, age: _age);

            showDialog(
              context: context,
              builder: (context) => AlertDialogBox(
                message: updated
                    ? "Data updated successfully"
                    : "Failed to update data",
              ),
            );

            setState(() {
              _action = '';
            });
          },
          child: Text(
            "Confirm",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget changePassword() {
    return Column(
      children: [
        SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: Icons.lock_outline,
          hintText: "Password",
          onSubmitted: (val) {
            setState(() {
              _password = val;
            });
          },
        ),
        SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: Icons.lock,
          hintText: "Confirm Password",
          onSubmitted: (val) {
            setState(() {
              if (_password != val) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: AlertDialogBox(
                        message: "Passwords don't match",
                      ),
                    );
                  },
                );
              }
              _password = val;
            });
          },
        ),
        SizedBox(height: 10),
        confirmCancelRow(),
      ],
    );
  }

  Widget changeEmail() {
    return Column(
      children: [
        SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
          hintText: "New Email",
          onSubmitted: (val) {
            setState(() {
              _email = val;
            });
          },
        ),
        SizedBox(height: 10),
        confirmCancelRow(),
      ],
    );
  }

  Widget changeBio() {
    return Column(
      children: [
        SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.text,
          prefixIcon: Icons.edit,
          maxLines: 5,
          hintText: "New Bio",
          onSubmitted: (val) {
            setState(() {
              _bio = val;
            });
          },
        ),
        SizedBox(height: 10),
        confirmCancelRow(),
      ],
    );
  }

  Widget changeAge() {
    return Column(
      children: [
        SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.number,
          prefixIcon: Icons.leaderboard_outlined,
          maxLines: 1,
          hintText: "New Age",
          onSubmitted: (val) {
            setState(() {
              _age = int.tryParse(val) ?? 0;
            });
          },
        ),
        SizedBox(height: 10),
        confirmCancelRow(),
      ],
    );
  }

  InkWell buildOptionButton(
      {Color? iconColor,
      VoidCallback? onTap,
      String? action,
      Color? actionColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: Helper.hPadding, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Action name
            Text(
              "$action",
              style: TextStyle(
                fontSize: 18,
                color: actionColor,
              ),
            ),

            SizedBox(width: 10),

            //Forward icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: iconColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_action == "bio") {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Helper.hPadding, vertical: 8),
        child: changeBio(),
      );
    } else if (_action == "pass") {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Helper.hPadding, vertical: 8),
        child: changePassword(),
      );
    } else if (_action == "email") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Helper.hPadding, vertical: 8),
        color: Colors.white,
        child: changeEmail(),
      );
    } else if (_action == "age") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Helper.hPadding, vertical: 8),
        color: Colors.white,
        child: changeAge(),
      );
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 5),
          buildOptionButton(
            iconColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                _action = "pass";
              });
            },
            action: "Change password",
            actionColor: Colors.black,
          ),
          Divider(height: 10, thickness: 1.3, color: Colors.grey[300]),
          buildOptionButton(
            iconColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                _action = "email";
              });
            },
            action: "Change email",
            actionColor: Colors.black,
          ),
          Divider(height: 10, thickness: 1.3, color: Colors.grey[300]),
          buildOptionButton(
            iconColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                _action = "bio";
              });
            },
            action: "Change bio",
            actionColor: Colors.black,
          ),
          Divider(height: 10, thickness: 1.3, color: Colors.grey[300]),
          buildOptionButton(
            iconColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                _action = "age";
              });
            },
            action: "Change age",
            actionColor: Colors.black,
          ),
          Divider(height: 10, thickness: 1.3, color: Colors.grey[300]),
          buildOptionButton(
            iconColor: Theme.of(context).primaryColor,
            onTap: () {
              Helper.navigateToPage(
                context: context,
                page: PageType.MEMBERPREFS,
                arguments: {},
              );
            },
            action: "Change preferences",
            actionColor: Colors.black,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
