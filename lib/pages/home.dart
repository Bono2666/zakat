import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List total, penyaluran;
  double totRice;
  int totCashInfaq;
  StreamSubscription<ConnectivityResult> subscription;
  String status = 'Offline';

  Future getTotal() async {
    var url = 'https://bonoworksdesign.com/zakat/get_total.php';
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future getTotMustahiq() async {
    var url = 'https://bonoworksdesign.com/zakat/get_tot_mustahiq.php';
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (await DataConnectionChecker().hasConnection) {
        setState(() {
          status = 'Online';
        });
      } else {
        setState(() {
          status = 'Offline';
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => MinimizeApp.minimizeApp(),
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              height: 100.0.h,
              color: Theme.of(context).backgroundColor,
            ),
            Stack(
              children: [
                Container(
                  height: 64.0.h,
                  child: Image.asset(
                    'images/stack-coins.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 35.0.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Zakat',
                        style: TextStyle(
                          fontFamily: 'Siti',
                          fontSize: 36.0.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.8.w,)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 36.0.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35.0.h,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(56),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.7.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.7.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 7.8.w,
                                    height: 0.5.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0.h,),
                              Text(
                                'Zakat dan Infaq',
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                              SizedBox(height: 1.8.h,),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: getTotal(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null || snapshot.hasError) {
                              return Container(
                                height: 32.0.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    status == 'Online'
                                        ? SpinKitPulse(
                                      color: Theme.of(context).primaryColor,
                                    )
                                        : Text('Gagal menghubungi server...'),
                                  ],
                                ),
                              );
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              try {
                                setState(() {
                                  total = snapshot.data;
                                  totRice = double.parse(total[0]['tot_rice']);
                                  totCashInfaq = int.parse(total[0]['tot_cash']) +
                                      int.parse(total[0]['tot_infaq']);
                                });
                              } catch (err) {
                                Container(
                                  height: 32.0.w,
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
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(6.7.w, 2.2.w, 0, 2.2.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38.0.w,
                                      height: 32.0.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,3),
                                            blurRadius: 6,
                                            color: Theme.of(context).shadowColor,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 4.4.w,
                                            left: 5.0.w,
                                            child: Image.asset(
                                              'images/beras.png',
                                              width: 8.8.w,
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 2.2.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  NumberFormat('#.##', 'id').format(totRice),
                                                  style: TextStyle(
                                                    fontSize: 28.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -2,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 14.4.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Beras (Kg)',
                                                  style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5.6.w,),
                                    Container(
                                      width: 38.0.w,
                                      height: 32.0.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,3),
                                            blurRadius: 6,
                                            color: Theme.of(context).shadowColor,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 4.4.w,
                                            left: 5.0.w,
                                            child: Image.asset(
                                              'images/coins.png',
                                              width: 11.0.w,
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 3.8.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: '',
                                                    decimalDigits: 0,
                                                  ).format(totCashInfaq),
                                                  style: TextStyle(
                                                    fontSize: 15.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -1,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 11.1.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total (Rp)',
                                                  style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5.6.w,),
                                    Container(
                                      width: 38.0.w,
                                      height: 32.0.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,3),
                                            blurRadius: 6,
                                            color: Theme.of(context).shadowColor,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 4.4.w,
                                            left: 5.0.w,
                                            child: Image.asset(
                                              'images/coins.png',
                                              width: 11.0.w,
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 3.8.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: '',
                                                    decimalDigits: 0,
                                                  ).format(int.parse(total[0]['tot_cash'])),
                                                  style: TextStyle(
                                                    fontSize: 15.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -1,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 11.1.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Zakat (Rp)',
                                                  style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5.6.w,),
                                    Container(
                                      width: 38.0.w,
                                      height: 32.0.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,3),
                                            blurRadius: 6,
                                            color: Theme.of(context).shadowColor,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 4.4.w,
                                            left: 5.0.w,
                                            child: Image.asset(
                                              'images/coins.png',
                                              width: 11.0.w,
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 3.8.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: '',
                                                    decimalDigits: 0,
                                                  ).format(int.parse(total[0]['tot_infaq'])),
                                                  style: TextStyle(
                                                    fontSize: 15.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -1,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 4.4.w,
                                            bottom: 11.1.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Infaq (Rp)',
                                                  style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 6.7.w,),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6.7.w, 1.8.h, 6.7.w, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'DATA',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.0.w,),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/muzakki_list');
                                },
                                child: Container(
                                  height: 11.0.w,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Muzakki',
                                        style: TextStyle(
                                          fontSize: 13.0.sp,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.0.w),
                                        child: Image.asset(
                                          'images/ic_person.png',
                                          width: 3.8.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.4.w,),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/mustahiq_list');
                                },
                                child: Container(
                                  height: 11.0.w,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Mustahiq',
                                        style: TextStyle(
                                          fontSize: 13.0.sp,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1.0.w),
                                        child: Image.asset(
                                          'images/ic_mustahiq.png',
                                          height: 5.6.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.0.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Penyaluran',
                                    style: TextStyle(
                                      fontSize: 20.0.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.2.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 82.0.w,
                                    child: Text(
                                      'Ilustrasi penyaluran zakat dan infaq untuk 1 orang mustahiq '
                                          'berdasarkan data yang telah tercatat.',
                                      style: TextStyle(
                                        fontSize: 8.0.sp,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.5.h,),
                              FutureBuilder(
                                future: getTotMustahiq(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData || snapshot.data == null || snapshot.hasError) {
                                    return Container(
                                      height: 40.0.h,
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
                                    try {
                                      setState(() {
                                        penyaluran = snapshot.data;
                                      });
                                    } catch (err) {
                                      Container(
                                        height: 40.0.h,
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
                                  }
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'images/beras_color.png',
                                            width: 41.0.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 15.6.w,
                                                child: Stack(
                                                  alignment: AlignmentDirectional.topEnd,
                                                  children: [
                                                    Text(
                                                      'Beras',
                                                      style: TextStyle(
                                                        fontSize: 13.0.sp,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 4.7.w),
                                                          child: Text(
                                                            totRice > 0
                                                            ? NumberFormat('#.##', 'id').format(totRice /
                                                                double.parse(penyaluran[0]['tot_mustahiq']))
                                                            : '-',
                                                            style: TextStyle(
                                                              fontSize: 24.0.sp,
                                                              fontWeight: FontWeight.w700,
                                                              letterSpacing: -2,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 0.6.w,),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 1.1.w),
                                                          child: Text(
                                                            'kg',
                                                            style: TextStyle(
                                                              fontSize: 10.0.sp,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.0.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'images/coins_color.png',
                                            width: 41.0.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 15.6.w,
                                                child: Stack(
                                                  alignment: AlignmentDirectional.topEnd,
                                                  children: [
                                                    Text(
                                                      'Uang Tunai',
                                                      style: TextStyle(
                                                        fontSize: 13.0.sp,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 1.1.w),
                                                          child: Text(
                                                            'Rp',
                                                            style: TextStyle(
                                                              fontSize: 10.0.sp,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 0.6.w,),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 4.7.w),
                                                          child: Text(
                                                            totCashInfaq > 0
                                                                ? NumberFormat.currency(
                                                              locale: 'id',
                                                              symbol: '',
                                                              decimalDigits: 0
                                                            ).format(totCashInfaq /
                                                                double.parse(penyaluran[0]['tot_mustahiq']))
                                                                : '-',
                                                            style: TextStyle(
                                                              fontSize: 20.0.sp,
                                                              fontWeight: FontWeight.w700,
                                                              letterSpacing: -2,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 11.2.h,),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}