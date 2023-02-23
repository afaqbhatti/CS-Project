import 'dart:io';

import 'package:connect_social/model/apis/api_response.dart';
import 'package:connect_social/utils/Utils.dart';
import 'package:connect_social/view/screens/widgets/textfield_social_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connect_social/model/UDetails.dart';
import 'package:connect_social/model/User.dart';
import 'package:connect_social/res/app_url.dart';
import 'package:connect_social/res/constant.dart';
import 'package:connect_social/shared_preference/app_shared_preference.dart';
import 'package:connect_social/view_model/u_details_view_model.dart';
import 'package:connect_social/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

import '../widgets/phone_textfield_social_info.dart';

class EditSocialInformationScreen extends StatefulWidget {
  const EditSocialInformationScreen({Key? key}) : super(key: key);

  @override
  State<EditSocialInformationScreen> createState() =>
      _EditSocialInformationScreenState();
}

class _EditSocialInformationScreenState
    extends State<EditSocialInformationScreen> {
  var authToken;
  var authId;

  final _aboutController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _workplaceController = TextEditingController();
  final _hobbiesController = TextEditingController();
  //high school is university
  final _highSchoolController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      authToken = await AppSharedPref.getAuthToken();
      authId = await AppSharedPref.getAuthId();
      Map data = {'id': '${authId}'};
      Provider.of<UserDetailsViewModel>(context, listen: false)
          .setDetailsResponse(UserDetail());
      Provider.of<UserDetailsViewModel>(context, listen: false)
          .getUserDetails(data, '${authToken}');
    });
  }

  @override
  void dispose() {
    _aboutController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _workplaceController.dispose();
    _hobbiesController.dispose();
    _highSchoolController.dispose();
    _mobileController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic userViewModel = Provider.of<UserViewModel>(context);
    dynamic userDetailViewModel = Provider.of<UserDetailsViewModel>(context);
    User? user = userViewModel.getUser;
    UserDetail? userDetail =
        Provider.of<UserDetailsViewModel>(context).getDetails;

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
                Card(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.edit_note),
                              Text(
                                'Edit Social Information',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        if (userDetailViewModel.getUserDetailStatus.status ==
                            Status.IDLE) ...[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFeildSocialInfo(
                                  label: 'First Name',
                                  controller: _firstNameController,
                                  value: '${user?.fname}',
                                  onChange: (String) {
                                    setState(() {
                                      '${user?.fname}';
                                      _firstNameController.text;
                                    });
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'Last Name',
                                  controller: _lastNameController,
                                  value: '${user?.lname}',
                                  onChange: (String) {
                                    _lastNameController.text;
                                    '${user?.lname}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'About',
                                  controller: _aboutController,
                                  value: '${userDetail?.about}',
                                  onChange: (String) {
                                    _aboutController.text;
                                    '${userDetail?.about}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'City',
                                  controller: _cityController,
                                  value: '${userDetail?.city}',
                                  onChange: (String) {
                                    _cityController.text;
                                    '${userDetail?.city}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'State',
                                  controller: _stateController,
                                  value: '${userDetail?.state}',
                                  onChange: (String) {
                                    _stateController.text;
                                    '${userDetail?.state}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'Country',
                                  controller: _countryController,
                                  value: '${userDetail?.country}',
                                  onChange: (String) {
                                    _countryController.text;
                                    '${userDetail?.country}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'Workplace',
                                  controller: _workplaceController,
                                  value: '${userDetail?.workplace}',
                                  onChange: (String) {
                                    _workplaceController.text;
                                    userDetail?.workplace;
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'University',
                                  controller: _highSchoolController,
                                  value: '${userDetail?.high_school}',
                                  onChange: (String) {
                                    _highSchoolController.text;
                                    '${userDetail?.high_school}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'Hobbies',
                                  controller: _hobbiesController,
                                  value: '${userDetail?.hobbies}',
                                  onChange: (String) {
                                    _hobbiesController.text;
                                    '${userDetail?.hobbies}';
                                  },
                                ),
                                TextFeildSocialInfo(
                                  label: 'Phone number',
                                  controller: _mobileController,
                                  value: '${user?.phone}',
                                  onChange: (String newValue) {
                                    _mobileController.text;
                                    '${_mobileController.text}';

                                    setState(() {
                                      newValue = '${user?.phone}';
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 50,
                                        padding: EdgeInsets.only(top: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: const Text('Update'),
                                          onPressed: () async {
                                            if (_firstNameController
                                                .text.isEmpty) {
                                              Utils.toastMessage(
                                                  'First name is required');
                                            } else if (_lastNameController
                                                .text.isEmpty) {
                                              Utils.toastMessage(
                                                  'New Password is required');
                                            } else if (_mobileController
                                                .text.isEmpty) {
                                              Utils.toastMessage(
                                                  'Phone number is required');
                                            } else {
                                              Map data = {
                                                'id': '${user?.id}',
                                                'fname':
                                                    '${_firstNameController.text}',
                                                'lname':
                                                    '${_lastNameController.text}',
                                                'about':
                                                    '${_aboutController.text}',
                                                'city':
                                                    '${_cityController.text}',
                                                'state':
                                                    '${_stateController.text}',
                                                'country':
                                                    '${_countryController.text}',
                                                'workplace':
                                                    '${_workplaceController.text}',
                                                'hobbies':
                                                    '${_hobbiesController.text}',
                                                'high_school':
                                                    '${_highSchoolController.text}',
                                                'phone':
                                                    '${_mobileController.text}',
                                              };
                                              dynamic response =
                                                  await userDetailViewModel
                                                      .updateSocialInfo(
                                                          data, '${authToken}');
                                              print(data);
                                              print(user?.fname);
                                              print(_firstNameController.text);
                                              print(_mobileController.text);
                                              print(user?.phone);
                                              if (response['success'] == true) {
                                                Utils.toastMessage(
                                                    '${response['message']}');
                                                Navigator.of(context).pop();
                                              } else {
                                                Utils.toastMessage(
                                                    '${response['message']}');
                                              }
                                            }
                                          },
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ] else if (userDetailViewModel
                                .getUserDetailStatus.status ==
                            Status.BUSY) ...[
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Utils.LoadingIndictorWidtet(),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
    );
  }

  // Widget inputWidget(label, _controller, value) {
  //   setState(
  //     () {
  //       if (value != null && value != 'null') {
  //         _controller.text = value;
  //       }
  //     },
  //   );
  //   return Container(
  //     padding: EdgeInsets.only(top: 10),
  //     child: TextField(
  //       autofocus: true,
  //       controller: _controller,
  //       decoration: InputDecoration(
  //         border: OutlineInputBorder(),
  //         labelText: label,
  //       ),
  //       keyboardType: TextInputType.name,
  //     ),
  //   );
  // }

  Widget phoneWidget(label, _controller, value) {
    setState(() {
      if (value != null) {
        _controller.text = value;
      }
    });
    print(_mobileController.text);
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Phone',
          prefixIcon: Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
