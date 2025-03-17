import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nile_lingo/Login/Cubit/Login%20Cubit.dart';
import 'package:nile_lingo/Login/Cubit/Login%20States.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/Constant.dart';
import '../../Home Page/UI/Home Screen.dart';
import '../../Sign up/UI/Sign Up Screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey There",
                      style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Welcome to NileLingo le’s translate easily from EGY to ENG and vice versa.",
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        color: secondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Form(
                      key: LoginCubit.get(context).formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          controller: LoginCubit.get(context).emailController,
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: GoogleFonts.montserrat(
                              color: secondaryTextColor,
                              fontSize: 16.sp,
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
                          controller: LoginCubit.get(context).passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }
                          },
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          obscureText: LoginCubit.get(context).obscureText,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    LoginCubit.get(context).obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: secondaryTextColor,
                                  )),
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.montserrat(
                              color: secondaryTextColor,
                              fontSize: 16.sp,
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
                    )),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Text(
                      "Forget Password?",
                      style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    GestureDetector(
                      onTap: () {
                       if(LoginCubit.get(context).formKey.currentState!.validate()){
                          LoginCubit.get(context).userLogin();

                       }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: state is LoginLoadingState
                            ? CircularProgressIndicator(
                                color: primaryTextColor,
                              )
                            : Text(
                                "Login",
                                style: GoogleFonts.montserrat(
                                  color: backgroundColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Text(
                        "OR",
                        style: GoogleFonts.montserrat(
                          color: secondaryTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 8.h,
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
                                fontSize: 17.sp,
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
                          "Don't have an account?",
                          style: GoogleFonts.montserrat(
                            color: secondaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
                              color: primaryColor,
                              fontSize: 16.sp,
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
