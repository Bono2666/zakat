import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class mustahiqAdd extends StatefulWidget {
  final int index;
  final List list;

  mustahiqAdd({this.list, this.index});

  @override
  _mustahiqAddState createState() => _mustahiqAddState();
}

class _mustahiqAddState extends State<mustahiqAdd> {
  var name = TextEditingController();
  var rw = TextEditingController();
  var job = TextEditingController();

  Future addMustahiq() async {
    var url = 'https://bonoworksdesign.com/zakat/add_mustahiq.php';
    await http.post(Uri.parse(url), body: {
      'name' : name.text,
      'rw' : rw.text,
      'job' : job.text,
    });
  }

  Future updMustahiq() async {
    var url = 'https://bonoworksdesign.com/zakat/edit_mustahiq.php';
    await http.post(Uri.parse(url), body: {
      'id' : widget.list[widget.index]['id'],
      'name' : name.text,
      'rw' : rw.text,
      'job' : job.text,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.index != null) {
      name.text = widget.list[widget.index]['name'];
      rw.text = widget.list[widget.index]['rw'];
      job.text = widget.list[widget.index]['job'];
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
                          'Mustahiq',
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0.sp,
                          ),
                        ),
                        SizedBox(height: 4.0.h,),
                        Text(
                          'Nama Mustahiq',
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
                    padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.0.h,),
                        Text(
                          'RW',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: rw,
                          enableSuggestions: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15.0.sp,
                          ),
                        ),
                        SizedBox(height: 3.0.h,),
                        Text(
                          'Pekerjaan',
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        TextField(
                          controller: job,
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
                        widget.index != null ? updMustahiq() : addMustahiq();
                        await Navigator.pushReplacementNamed(context, '/mustahiq_list');
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
                      'Ingin membatalkan data Mustahiq?',
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
                              await Navigator.pushReplacementNamed(context, '/mustahiq_list');
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