import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zakat/pages/add_muzakki.dart';

class muzakkiList extends StatefulWidget {
  @override
  _muzakkiListState createState() => _muzakkiListState();
}

class _muzakkiListState extends State<muzakkiList> {
  List list;

  Future getMuzakki() async {
    var url = 'https://bonoworksdesign.com/zakat/get_muzakki.php';
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future delMuzakki(int index) async {
    var url = 'https://bonoworksdesign.com/zakat/del_muzakki.php';
    await http.post(Uri.parse(url), body: {
      'id' : list[index]['id']
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.7.w, 19.0.h, 6.7.w, 0),
                    child: Text(
                      'Muzakki',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(3.25.w, 44.0.w, 3.25.w, 20.0.w),
                    child: FutureBuilder(
                        future: getMuzakki(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null || snapshot.hasError) {
                            return Container(
                              height: 56.0.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitPulse(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            list = snapshot.data;
                          }
                          return
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.4.w),
                                      child: Dismissible(
                                        child: ListTile(
                                          leading: Container(
                                            width: 10.0.w,
                                            height: 10.0.w,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                int.parse(list[index]['hide']) == 1
                                                      ? 'H'
                                                      : list[index]['name'].toString().substring(0,1).toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: EdgeInsets.only(top: 2.0.w),
                                            child: Text(
                                              int.parse(list[index]['hide']) == 1
                                                  ? 'Hamba Allah'
                                                  : list[index]['name'],
                                              style: TextStyle(
                                                fontSize: 15.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).backgroundColor,
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(top: 2.2.w),
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Zakat Beras: ' + list[index]['rice'].toString() + ' kg',
                                                  style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                  ),
                                                ),
                                                Text(
                                                  'Zakat Tunai: ' +
                                                      NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: '',
                                                        decimalDigits: 0,
                                                      ).format(int.parse(list[index]['cash'])),
                                                  style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                  ),
                                                ),
                                                Text(
                                                  'Infaq: ' +
                                                      NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: '',
                                                        decimalDigits: 0,
                                                      ).format(int.parse(list[index]['infaq'])),
                                                  style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 5.8.w,),
                                              ],
                                            ),
                                          ),
                                          trailing: GestureDetector(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0.8.w, 0.8.w, 0),
                                              child: Image.asset(
                                                'images/ic_edit.png',
                                                width: 4.4.w,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) =>
                                                      muzakkiAdd(list: list, index: index),));
                                            },
                                          ),
                                        ),
                                        key: Key(list[index].toString()),
                                        background: Container(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            delMuzakki(index);
                                            list.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.2.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Theme.of(context).dividerColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                        }
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 4.0.h,
                  color: Colors.white,
                ),
                Container(
                  height: 11.0.h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white, Colors.white.withOpacity(0.0),
                        ],
                      )
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Container(
                width: 19.0.w,
                height: 15.0.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      width: 19.0.w,
                      height: 19.0.w,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 7.0.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SizedBox(height: 5.6.h,),
                    Padding(
                      padding: EdgeInsets.only(right: 6.6.w,),
                      child: InkWell(
                        onTap: () {

                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Opacity(
                              opacity: .8,
                              child: Container(
                                width: 12.5.w,
                                height: 12.5.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6.0,
                                      color: Theme.of(context).shadowColor,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 5.6.w,
                              height: 5.6.w,
                              child: FittedBox(
                                child: Image.asset(
                                  'images/ic_search.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Positioned(
                  bottom: 2.8.h,
                  right: 6.6.w,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/muzakki_add');
                    },
                    child: Icon(
                      Icons.add,
                    ),
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class alert extends StatefulWidget {
  @override
  _alertState createState() => _alertState();
}

class _alertState extends State<alert> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.0.w,
              constraints: BoxConstraints(
                minHeight: 24.0.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dialogBackgroundColor,
                    blurRadius: 24,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(7.8.w, 5.0.w, 7.8.w, 5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingin menghapus data Muzakki?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 7.0.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 14.8.w,
                              height: 14.8.w,
                              child: Image.asset(
                                'images/ic_cancel.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.6.w,),
                        Ink(
                          child: InkWell(
                            onTap: () async {
                              await Navigator.pushReplacementNamed(context, '/muzakki_list');
                            },
                            child: Container(
                              width: 14.8.w,
                              height: 14.8.w,
                              child: Image.asset(
                                'images/ic_ok.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}