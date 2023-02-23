import 'package:flutter/material.dart';
import 'package:connect_social/model/User.dart';
import 'package:connect_social/model/apis/api_response.dart';
import 'package:connect_social/res/constant.dart';
import 'package:connect_social/shared_preference/app_shared_preference.dart';
import 'package:connect_social/utils/Utils.dart';
import 'package:connect_social/view/screens/chatbox.dart';
import 'package:connect_social/view/screens/friend_request.dart';
import 'package:connect_social/view/screens/other_profile.dart';
import 'package:connect_social/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatefulWidget {
  final int? user_id;
  const FriendScreen(this.user_id);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<User> friends = [];
  String? authToken;
  int? AuthId;
  String _networkType = 'friends';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      authToken = await AppSharedPref.getAuthToken();
      AuthId = await AppSharedPref.getAuthId();
      _pullRefresh(context);
    });
  }

  Future<void> _pullRefresh(ctx) async {
    Provider.of<UserViewModel>(context, listen: false).setFriends([]);
    Map data = {'id': '${widget.user_id}', 'key': '${_networkType}'};
    await Provider.of<UserViewModel>(ctx, listen: false)
        .fetchFriends(data, '${authToken}');
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    List<User?> friends = _userViewModel.getFriends;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Constants.titleImage2(context),
        ),
        body: Container(
          color: Constants.np_bg_clr,
          child: Padding(
            padding: EdgeInsets.all(Constants.np_padding_only),
            child: RefreshIndicator(
                child: Card(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Network',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FriendRequestScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                                color: Colors.white,
                                padding:
                                    EdgeInsets.all(Constants.np_padding_only),
                                child: Row(
                                  children: [
                                    Icon(Icons.open_in_new_rounded),
                                    Text(
                                      'Network Requests',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Row(children: [
                          for (var item
                              in Constants.networkList(internal: true)) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _networkType = item['key'];
                                });
                                _pullRefresh(context);
                              },
                              child: Container(
                                  color: (_networkType == item['key'])
                                      ? Colors.black
                                      : Colors.grey.shade200,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 7),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      (_networkType == item['key'])
                                          ? MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(invertColors: true),
                                              child: Image.asset(
                                                'assets/images/${item['key']}.png',
                                                width: 20,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/${item['key']}.png',
                                              width: 20,
                                            ),
                                      Text(
                                        '${item['title']}',
                                        style: TextStyle(
                                          color: (_networkType == item['key'])
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ]),
                      ),
                    ),
                    Divider(),
                    if (_userViewModel.getFetchFriendStatus.status ==
                        Status.IDLE) ...[
                      if (friends.length == 0) ...[
                        Padding(
                          padding: EdgeInsets.all(Constants.np_padding_only),
                          child: Center(
                            child: Text('No user'),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          //height: MediaQuery.of(context).size.height - 270,
                          child: ListView.builder(
                            itemCount: friends.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _FriendCard(friends[index]);
                            },
                          ),
                        )
                        //for (var friend in friends) FriendsCard(friend!)
                      ]
                    ] else if (_userViewModel.getFetchFriendStatus.status ==
                        Status.BUSY) ...[
                      Container(
                        height: 100,
                        child: Center(
                          child: Utils.LoadingIndictorWidtet(size: 40.0),
                        ),
                      )
                    ],
                  ]),
                ),
                //onRefresh:(context){ _pullRefresh(context) }
                onRefresh: () async {
                  _pullRefresh(context);
                }),
          ),
        ));
  }

  Widget _FriendCard(User? user) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherProfileScreen(user?.id)))
            .then((value) => _pullRefresh(context));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network('${Constants.profileImage(user)}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return Constants.defaultImage(50.0);
              }),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${user?.fname} ${user?.lname}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatBoxScreen(user)));
                          },
                          child: Icon(Icons.message),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
