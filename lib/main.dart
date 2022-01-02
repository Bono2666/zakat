import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zakat/pages/add_mustahiq.dart';
import 'package:zakat/pages/add_muzakki.dart';
import 'package:zakat/pages/home.dart';
import 'package:zakat/pages/mustahiq_list.dart';
import 'package:zakat/pages/muzakki_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appName = 'Zakat';

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              title: appName,
              theme: ThemeData(
                fontFamily: 'Poppins',

                primaryColor: Color(0xffDE823A),
                accentColor: Color(0xff757575),
                dividerColor: Color(0xffD1D3D4),
                shadowColor: Color(0x32000000),
                backgroundColor: Color(0xff180400),
                dialogBackgroundColor: Color(0x30000000),

                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.black,
                  selectionColor: Color(0xffDE823A),
                  selectionHandleColor: Color(0xff180400),
                ),

                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
              initialRoute: '/',
              // ignore: missing_return
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/':
                    return slideUpRoute(page: home());
                  case '/muzakki_add':
                    return slideLeftRoute(page: muzakkiAdd());
                  case '/mustahiq_add':
                    return slideLeftRoute(page: mustahiqAdd());
                  case '/muzakki_list':
                    return slideUpRoute(page: muzakkiList());
                  case '/mustahiq_list':
                    return slideUpRoute(page: mustahiqList());
                }
              },
            );
          },
        );
      },
    );
  }
}

class slideUpRoute extends PageRouteBuilder {
  final Widget page;

  slideUpRoute({this.page}) :super(
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
        return SlideTransition(
          position: Tween(
            begin: const Offset(0,1.2),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
        return page;
      }
  );
}

class slideLeftRoute extends PageRouteBuilder {
  final Widget page;

  slideLeftRoute({this.page}) :super(
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
        return SlideTransition(
          position: Tween(
            begin: const Offset(1.2,0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
        return page;
      }
  );
}
