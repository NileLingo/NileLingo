import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nile_lingo/Sign%20up/Cubit/Sign%20Up%20Cubit.dart';
import 'package:nile_lingo/Sign%20up/Cubit/Sign%20Up%20States.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/Constant.dart';
import '../../Home Page/UI/Home Screen.dart';
import '../../Login/UI/Login Screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit, SignUpStates>(
      listener: (context, state) {
        if(state is SignUpSuccessState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leadingWidth: double.infinity,
            backgroundColor: backgroundColor,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "EGY",
                style: GoogleFonts.montserrat(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey There",
                      style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Welcome to NileLingu le’s translate easly from EGY to ENG and vice versa.",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: secondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Form(
                      key: SignUPCubit.get(context).formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username is too short";
                              }
                            },
                            style: GoogleFonts.montserrat(
                              color: primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: SignUPCubit.get(context).nameController,
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: GoogleFonts.montserrat(
                                color: secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              fillColor: const Color(0xff1E1E1E),
                              filled: true,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is too short";
                              }
                            },
                            style: GoogleFonts.montserrat(
                              color: primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: SignUPCubit.get(context).emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: GoogleFonts.montserrat(
                                color: secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              fillColor: const Color(0xff1E1E1E),
                              filled: true,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          TextFormField(
                            style: GoogleFonts.montserrat(
                              color: primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            obscureText: SignUPCubit.get(context).obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is too short";
                              }
                            },
                            controller: SignUPCubit.get(context).passwordController,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    SignUPCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    SignUPCubit.get(context).obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: secondaryTextColor,
                                  ),
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: GoogleFonts.montserrat(
                                color: secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              fillColor: const Color(0xff1E1E1E),
                              filled: true,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: SignUPCubit.get(context).isSelected,
                          onChanged: (value) {
                            SignUPCubit.get(context).changeSelected();
                          },
                          fillColor: SignUPCubit.get(context).isSelected
                              ? MaterialStateProperty.all(primaryColor)
                              : MaterialStateProperty.all(fillColor),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "By signing up you agree to our ",
                                  style: GoogleFonts.montserrat(
                                      color: primaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: "Terms of Service",
                                      style: GoogleFonts.montserrat(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: GoogleFonts.montserrat(
                                          color: primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: GoogleFonts.montserrat(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(SignUPCubit.get(context).formKey.currentState!.validate()){
                          SignUPCubit.get(context).userSignUp();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: state is SignUpLoadingState
                            ? CircularProgressIndicator(
                                color: primaryTextColor,
                              )
                            : Text(
                                "Sign Up",
                                style: GoogleFonts.montserrat(
                                  color: backgroundColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.8.h,
                    ),
                    Center(
                      child: Text(
                        "OR",
                        style: GoogleFonts.montserrat(
                          color: secondaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.8.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/google2.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "Continue With Google",
                              style: GoogleFonts.montserrat(
                                color: primaryTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.montserrat(
                            color: secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
