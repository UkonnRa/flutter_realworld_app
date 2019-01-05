import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/actions.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/pages/main_page.dart';
import 'package:flutter_realworld_app/pages/profile_page.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:flutter_redurx/flutter_redurx.dart';

class AppDrawer extends StatelessWidget {
  final AuthUser _currentUser;

  AppDrawer(this._currentUser, {Key key}) : super(key: key);

  Drawer _placeholderDrawer(BuildContext context) => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(child: CircularProgressIndicator()),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      );

  Drawer _loginDrawer(BuildContext context, Profile profile) => Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(profile)));
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(_currentUser.username),
                accountEmail: Text(_currentUser.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      util.isNullEmpty(_currentUser.image, trim: true)
                          ? AssetImage('res/assets/smiley-cyrus.jpg')
                          : CachedNetworkImageProvider(_currentUser.image),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(MainPageType.YOUR_FEED)),
                    ModalRoute.withName('/'));
              },
              title: Text(S.of(context).yourFeed),
            ),
            ListTile(
              leading: Icon(Icons.public),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            MainPage(MainPageType.GLOBAL_FEED)),
                    ModalRoute.withName('/'));
              },
              title: Text(S.of(context).globalFeed),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
              title: Text(S.of(context).settings),
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              onTap: () {
                Provider.dispatch<AppState>(context,
                    Logout(successCallback: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              MainPage(MainPageType.GLOBAL_FEED)),
                      ModalRoute.withName('/'));
                  util.flushbar(context, S.of(context).logoutSuccessfulTitle,
                      S.of(context).logoutSuccessfulTitle);
                }));
              },
              title: Text(S.of(context).logout),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              onTap: () {
                util.showAbout(context);
              },
              title: Text(S.of(context).aboutApp),
            ),
          ],
        ),
      );

  Drawer _notLoginDrawer(BuildContext context) => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "conduit",
                    style: Theme.of(context).textTheme.display1.merge(TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
                  ),
                  Text(
                    S.of(context).conduitSlogan,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .merge(TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.public),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            MainPage(MainPageType.GLOBAL_FEED)),
                    ModalRoute.withName('/'));
              },
              title: Text(S.of(context).globalFeed),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(S.of(context).aboutApp),
              onTap: () {
                util.showAbout(context);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
        future: Api.getInstance()
            .then((api) => api.profileGet(_currentUser.username))
            .catchError((err) => util.errorHandle(err, context)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (_currentUser == null)
              return _notLoginDrawer(context);
            else {
              print("snapshot: ${snapshot.data}");
              return _loginDrawer(context, snapshot.data);
            }
          } else {
            return _placeholderDrawer(context);
          }
        });
  }
}
