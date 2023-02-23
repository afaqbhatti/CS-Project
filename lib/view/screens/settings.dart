import 'package:connect_social/view/screens/settings/edit_social_information.dart';
import 'package:connect_social/view/screens/settings/prviacy_management.dart';
import 'package:connect_social/view/screens/settings/update_password.dart';
import 'package:flutter/material.dart';
import 'package:connect_social/res/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Constants.titleImage2(context),
      ),
      body: Container(
          color: Constants.np_bg_clr,
          child: Padding(
            padding: EdgeInsets.only(
                left: Constants.np_padding_only,
                right: Constants.np_padding_only,
                top: Constants.np_padding_only),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                settingMenu(
                    'Edit Social Information', 'edit-social-information'),
                settingMenu('Change Password', 'change-password'),
                settingMenu('Privacy Management', 'privacy-management'),
                settingMenu('Blocklist', 'route'),
                settingMenu('Delete Account', 'route'),
              ],
            ),
          )),
      backgroundColor: Colors.white,
    );
  }

  Widget settingMenu(String title, String route) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            InkWell(
              onTap: () {
                if (route == 'edit-social-information') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditSocialInformationScreen()));
                }
                if (route == 'change-password') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePasswordScreen()));
                }
                if (route == 'privacy-management') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyManagementScreen()));
                }
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.edit,
                  size: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
