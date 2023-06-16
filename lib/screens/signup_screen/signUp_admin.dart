import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:save_enerrgy/screens/loginScreen/loginScreen.dart';
import '../../alert_dialog/alert_dialog.dart';
import '../../api_manager/api_manager.dart';
import '../loginScreen/widgets/materialBtn.dart';
import '../loginScreen/widgets/textButton.dart';
import '../loginScreen/widgets/textForm.dart';


class SignUpScreen extends StatefulWidget {
  static const String routeName = 'createAdmin';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible = true;
  String gender = 'Male';
  List<String> genders = ['Male','Female'];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06,vertical: size.width * 0.2),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Text(
                    'You are where you find the\nbest you are looking for!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white54, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFiield(
                      controller: nameController,
                      keyboard: TextInputType.name,
                      hint: 'Full Name',
                      prefIcon: Icons.person_outline,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Full Name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  TextFiield(
                    hint: 'Phone Number',
                    keyboard: TextInputType.phone,
                    prefIcon: Icons.phone,
                    validate: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Phone Number must not be empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  TextFiield(
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      hint: 'Email Address',
                      prefIcon: Icons.email_outlined,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Full Name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  TextFiield(
                    controller: passController,
                    keyboard: TextInputType.visiblePassword,
                    hint: 'Password',
                    prefIcon: Icons.password,
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
                    height: size.height * 0.015,
                  ),

                  Text('Gender',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 28
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: DropdownButton<String>(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                      isExpanded: true,
                      underline: Container(color: Colors.white,height: 1,),
                      iconEnabledColor: Colors.black,
                      items: genders.map((item) {
                        return DropdownMenuItem<String>(child: Text(item,
                        ), value: item);})
                          .toList(),
                      onChanged: (text) {
                        setState(() {
                          gender = text!;
                        });
                      },
                      value: gender,
                    ),
                  ),                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  MaterialBtn(
                      'Already have an account? ',
                      'Login',
                      () => Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName)),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextButtoon('Sign Up', () async {
                    if (formKey.currentState!.validate()) {
                      showLoading(context, 'Loading....', isCancelable: false);
                      var auth = await ApiManager.createAccount(
                          emailController.text,
                          passController.text,
                          nameController.text,
                          phoneController.text,
                          gender,);
                      await Future.delayed(Duration(seconds: 2), () {
                        hideLoading(context);
                      });
                      if (auth.isSuccess == true) {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      } else {
                        showMessage(context,
                            dialogType: DialogType.error,
                            desc: auth.message ?? '',
                            btnOkOnPress: () {});
                      }
                  }})
                ],
              ),
            ),
          ),
        ));
  }
}
