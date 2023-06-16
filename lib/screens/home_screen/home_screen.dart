import 'package:analog_clock/analog_clock.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:save_enerrgy/alert_dialog/alert_dialog.dart';
import 'package:save_enerrgy/api_manager/api_manager.dart';
import 'package:save_enerrgy/screens/loginScreen/loginScreen.dart';
import 'package:save_enerrgy/screens/loginScreen/models/AuthAdminRes.dart';
import 'package:save_enerrgy/themes/myTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late CustomTimerController controller = CustomTimerController(
      vsync: this,
      begin: Duration(minutes: minutes, hours: hours, seconds: seconds),
      end: Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);
  int minutes = 0;
  int hours = 0;
  int seconds = 0;
  String text = 'Connect';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('tokenAdmin');
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ),
        body: FutureBuilder<UserDataRes>(
            future: ApiManager.getDataUser(),
            builder: (context, snapshot) {
              var userData = snapshot.data?.data?.user;
              minutes = userData?.timeRemaining?.minutes ?? 0;
              hours = userData?.timeRemaining?.hours ?? 0;
              seconds = userData?.timeRemaining?.seconds ?? 0;
              return userData == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AnalogClock(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2.0, color: Colors.black),
                                color: Colors.transparent,
                                shape: BoxShape.circle),
                            width: 200,
                            height: 200,
                            isLive: true,
                            hourHandColor: Colors.white,
                            minuteHandColor: Colors.white,
                            showSecondHand: true,
                            numberColor: Colors.white,
                            showNumbers: true,
                            textScaleFactor: 1.4,
                            showTicks: true,
                            digitalClockColor: Colors.white,
                            showDigitalClock: true,
                            datetime: DateTime.now(),
                            key: UniqueKey(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Hello, ${userData.fullName}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 28),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Card(
                              elevation: 8,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: CustomTimer(
                                    controller: controller,
                                    builder: (state, time) {
                                      if (userData.chargerEnabledAt != 0) {
                                        controller.start();
                                      }
                                      return Text(
                                          "${time.hours}:${time.minutes}:${time.seconds}.${time.milliseconds}",
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: MyTheme.navyBlue,
                                              fontWeight: FontWeight.bold));
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: ()async{
                              if (text == 'Not Available'|| text == 'Connected' || userData.isAvailableToCharge == false) {
                                return;
                              }
                              else {
                                text = 'Loading...';
                                setState(() {

                                });
                                var device = await ApiManager.connectDevice();
                                if(device.isSuccess == true) {
                                  controller.start();
                                  text = 'Connected';
                                  setState(() {});
                                }
                                else {
                                  showMessage(context, dialogType: DialogType.error, desc: device.message??'',btnOkOnPress: (){
                                    text = 'Connect';
                                    setState(() {

                                    });
                                  });
                                }
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              child: Text(
                                userData.isAvailableToCharge == false
                                    ? text = 'Not Available'
                                    : userData.chargerEnabledAt != 0
                                        ? text = 'Connected'
                                        : text,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: text == 'Not Available'
                                        ? Colors.red
                                        : MyTheme.navyBlue),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }));
  }
}
