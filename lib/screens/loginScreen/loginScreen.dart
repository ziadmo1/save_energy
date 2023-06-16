import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:save_enerrgy/screens/loginScreen/widgets/materialBtn.dart';
import 'package:save_enerrgy/screens/loginScreen/widgets/textButton.dart';
import 'package:save_enerrgy/screens/loginScreen/widgets/textForm.dart';
import 'package:save_enerrgy/screens/signup_screen/signUp_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../alert_dialog/alert_dialog.dart';
import '../../api_manager/api_manager.dart';
import '../home_screen/home_screen.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'Welcome back to the best.\nwe\'re always here, waiting for \nyou!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white54, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFiield(
                        hint: 'Email Address',
                        keyboard: TextInputType.emailAddress,
                        controller: emailController,
                        prefIcon: Icons.email,
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Email Address must not be empty';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    TextFiield(
                      hint: 'Password',
                      controller: passController,
                      prefIcon: Icons.password,
                      keyboard: TextInputType.visiblePassword,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Password must not be empty';
                        } else if (text.length < 6) {
                          return 'Password must be equal 6 characters';
                        }
                        return null;
                      },
                      isVisible: isVisible,
                      suffIcon: IconButton(
                          onPressed: () {
                            isVisible = !isVisible;
                            setState(() {});
                          },
                          icon: Icon(
                            isVisible == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white54,
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MaterialBtn(
                      'Not have an account? ',
                      'Sign up',
                      () => Navigator.pushReplacementNamed(context, SignUpScreen.routeName)
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextButtoon('Login', () async {
                      if (formKey.currentState!.validate()) {
                        showLoading(context, 'Loading....',
                            isCancelable: false);
                        var auth = await ApiManager.loginAccount(
                            emailController.text, passController.text);
                        await Future.delayed(Duration(seconds: 2), () {
                          hideLoading(context);
                        });
                        if (auth.isSuccess == true) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              'tokenAdmin', auth.data?.user?.sId??'');
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.routeName,
                          );
                        } else {
                          showMessage(context,
                              dialogType: DialogType.error,
                              desc: auth.message ?? '',
                              btnOkOnPress: () {});
                        }
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

