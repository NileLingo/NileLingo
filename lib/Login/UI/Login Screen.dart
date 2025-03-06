import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/Constant.dart';
import '../../Home Page/UI/Home Screen.dart';
import '../../Sign up/UI/Sign Up Screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: double.infinity,
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("EGY",style: GoogleFonts.montserrat(
            color: primaryTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey There",style: GoogleFonts.montserrat(
                color: primaryTextColor,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                height: 2.h,
              ),
              Text("Welcome to NileLingu le’s translate easly from EGY to ENG and vice versa.",style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                color: secondaryTextColor,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                height: 4.h,
              ),
              TextFormField(
                style: GoogleFonts.montserrat(
                  color: primaryTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
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
                style: GoogleFonts.montserrat(
                  color: primaryTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
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
              SizedBox(
                height: 3.5.h,
              ),
              Text("Forget Password?",style: GoogleFonts.montserrat(
                color: primaryTextColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                height: 7.h,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen())
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text("Login",style: GoogleFonts.montserrat(
                    color: backgroundColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Center(
                child: Text("OR",style: GoogleFonts.montserrat(
                  color: secondaryTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: (){},
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
                      Image.asset("assets/google2.png",width: 30,height: 30,),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text("Continue With Google",style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),),
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
                  Text("Don't have an account?",style: GoogleFonts.montserrat(
                    color: secondaryTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),),
                   SizedBox(
                    width: 1.w,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen())
                      );
                    },
                    child: Text("Sign Up",style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
