import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class muzakkiAdd extends StatefulWidget {
  final int index;
  final List list;

  muzakkiAdd({this.list, this.index});

  @override
  _muzakkiAddState createState() => _muzakkiAddState();
}

class _muzakkiAddState extends State<muzakkiAdd> {
  var name = TextEditingController();
  bool hide = false;
  String _hide = '0';
  var rice = TextEditingController();
  var cash = TextEditingController();
  var infaq = TextEditingController();

  Future addMuzakki() async {
    var url = 'https://bonoworksdesign.com/zakat/add_muzakki.php';
    await http.post(Uri.parse(url), body: {
      'name' : name.text,
      'hide' : _hide,
      'rice' : rice.text,
      'cash' : cash.text,
      'infaq' : infaq.text,
    });
  }

  Future updMuzakki() async {
    var url = 'https://bonoworksdesign.com/zakat/edit_muzakki.php';
    await http.post(Uri.parse(url), body: {
      'id' : widget.list[widget.index]['id'],
      'name' : name.text,
      'hide' : _hide,
      'rice' : rice.text,
      'cash' : cash.text,
      'infaq' : infaq.text,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.index != null) {
      name.text = widget.list[widget.index]['name'];
      hide = widget.list[widget.index]['hide'] == '1' ? true : false;
      rice.text = widget.list[widget.index]['rice'];
      cash.text = widget.list[widget.index]['cash'];
      infaq.text = widget.list[widget.index]['infaq'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => alert(),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 19.0.h,),
                        Text(
                          'Muzakki',
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0.sp,
                          ),
                        ),
                        SizedBox(height: 4.0.h,),
                        Text(
                          'Nama Muzakki',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: name,
                          enableSuggestions: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w),
                    child: CheckboxListTile(
                      value: hide,
                      onChanged: (value) {
                        setState(() {
                          hide = value;
                          _hide = hide == true ? '1' : '0';
                        });
                      },
                      title: Text(
                        'Tampilkan sebagai hamba Allah',
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      activeColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.0.h,),
                        Text(
                          'Zakat Beras (kg)',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: rice,
                          enableSuggestions: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15.0.sp,
                          ),
                        ),
                        SizedBox(height: 3.0.h,),
                        Text(
                          'Zakat Tunai (Rp)',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: cash,
                          enableSuggestions: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15.0.sp,
                          ),
                        ),
                        SizedBox(height: 3.0.h,),
                        Text(
                          'Nominal Infaq (Rp)',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: infaq,
                          enableSuggestions: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15.0.sp,
                          ),
                        ),
                        SizedBox(height: 24.0.h,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
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
                      onTap: () async {
                        return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => alert(),
                        );
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
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 6.0.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 6.4.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white, Colors.white.withOpacity(0.0),
                                ],
                              )
                          ),
                        ),
                        Container(
                          height: 5.0.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        widget.index != null ? updMuzakki() : addMuzakki();
                        await Navigator.pushReplacementNamed(context, '/muzakki_list');
                      },
                      child: Container(
                        width: 74.0.w,
                        height: 12.0.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      'Ingin membatalkan data Muzakki?',
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