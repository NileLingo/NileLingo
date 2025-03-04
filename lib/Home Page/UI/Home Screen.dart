import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/Constant.dart';
import '../../History/UI/History Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String language1 = "EGY";
  String language2 = "ENG";
  bool isFavourite = false;
  bool showResult = false;
  bool isRecording = false;
  String path = "";
  bool isPlaying = false;
  //Recording
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  Future<void> pickAudioFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        showResult = true;
        path = result.files.single.path!; // Add file path to the list
      });
    }
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        leadingWidth: 15.w,
        leading: FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: IconButton(
              onPressed: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              icon: FaIcon(
                isFavourite
                    ? FontAwesomeIcons.solidStar
                    : FontAwesomeIcons.star,
                color: isFavourite ? primaryColor : secondaryTextColor,
                size: 25,
              )),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            "NileLingo",
            style: GoogleFonts.montserrat(
              color: primaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          FadeInRight(
            duration: const Duration(milliseconds: 500),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: secondaryTextColor,
                      size: 30,
                    ))),
          ),
        ],
      ),
      body: showResult
          ? SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 25, top: 25, right: 25, bottom: 45),
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language1,
                        style: GoogleFonts.montserrat(
                          color: primaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              truncateFileName(getFileName(path), 20),
                              style: GoogleFonts.montserrat(
                                color: secondaryTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // If already playing, pause it
                              if (isPlaying) {
                                await audioPlayer.pause();
                                setState(() {
                                  isPlaying = false;
                                });
                              } else {
                                // Play the selected recording
                                await audioPlayer
                                    .play(DeviceFileSource(path));
                                setState(() {
                                  isPlaying = true;
                                });
                              }
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.volume_up,
                              color: primaryColor,
                              size: 35,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.5.h),
                FadeInRight(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language2,
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.volume_up,
                                    color: primaryColor,
                                    size: 35,
                                  )),
                              const Spacer(),
                              Text(
                                "ازيك",
                                style: GoogleFonts.montserrat(
                                  color: secondaryTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Cultural insights",
                    style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Another sentence that can be used for greating someone",
                          style: GoogleFonts.montserrat(
                            color: secondaryTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up,
                                  color: primaryColor,
                                  size: 30,
                                )),
                            Expanded(
                              child: Text(
                                "عامل ايه ؟ (? meaning : how are you)",
                                style: GoogleFonts.montserrat(
                                  color: secondaryTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up,
                                  color: primaryColor,
                                  size: 30,
                                )),
                            Expanded(
                              child: Text(
                                "عامل ايه ؟ (? meaning : how are you)",
                                style: GoogleFonts.montserrat(
                                  color: secondaryTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Note: ",
                                style: GoogleFonts.montserrat(
                                  color: primaryColor,
                                  // Change this to your desired color
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                "this phrase can’t be translated literally",
                                style: GoogleFonts.montserrat(
                                  color: secondaryTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "See more details",
                              style: GoogleFonts.montserrat(
                                color: primaryTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
          : SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: double.infinity,
                    height: 30.h,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language1,
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        TextFormField(
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          onFieldSubmitted: (value) {
                            setState(() {
                              showResult = true;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type Here ..",
                            hintStyle: GoogleFonts.montserrat(
                              color: secondaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            fillColor: fillColor,
                            filled: true,
                            contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (isRecording) {
                                  String? filePath = await audioRecorder.stop();
                                  if (filePath != null) {
                                    setState(() {
                                      path = filePath;
                                      isRecording = false;
                                      showResult = true;
                                    });
                                  }
                                } else {
                                  if (await audioRecorder.hasPermission()) {
                                    final Directory appDirectory =
                                    await getApplicationDocumentsDirectory();
                                    final String filePath =
                                        '${appDirectory.path}/audio_${path}.wav';
                                    await audioRecorder.start(const RecordConfig(), path: filePath);
                                    setState(() {
                                      isRecording = true;
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('You must grant permission to record audio'),
                                    ));
                                  }
                                }
                              },
                              icon: isRecording
                                  ? Icon(
                                Icons.stop_circle_outlined,
                                color: primaryColor,
                                size: 50,
                              )
                                  : Icon(
                                Icons.mic,
                                color:primaryColor,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      String temp = language1;
                      language1 = language2;
                      language2 = temp;
                    });
                  },
                  child: Center(
                    child: Image.asset('assets/Vector (1).png'),
                  ),
                ),
                SizedBox(height: 2.5.h),
                FadeInRight(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: double.infinity,
                    height: 27.h,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language2,
                          style: GoogleFonts.montserrat(
                            color: primaryTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Text(
                            "Translation",
                            style: GoogleFonts.montserrat(
                              color: secondaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.elliptical(200, 100),
                    topLeft: Radius.elliptical(200, 100),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
            ),
            Positioned(
              width: 80,
              height: 80,
              left: 7.w,
              bottom: 4.h,
              child: GestureDetector(
                onTap: pickAudioFiles,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff433061),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Image.asset("assets/Group 3.png", scale: 0.85),
                ),
              ),
            ),
            Positioned(
              width: 130,
              height: 130,
              left: 34.w,
              bottom: 7.h,
              child: GestureDetector(
                onTap: () async {
                  if (isRecording) {
                    await audioRecorder.stop();
                  }
                  if (isPlaying) {
                    await audioPlayer.stop();
                  }
                  setState(() {
                    showResult = false;
                    isRecording = false;
                    isPlaying = false;
                    path = ""; // Reset the path to clear the previous recording
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff433061),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Image.asset("assets/Plus.png"),
                ),
              ),
            ),
            Positioned(
              width: 80,
              height: 80,
              right: 7.w,
              bottom: 4.h,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff433061),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Image.asset(
                  "assets/refresh.png",
                  scale: 0.85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
String getFileName(String path) {
  return path.split('/').last; // Extract the file name from the path
}

// Helper function to truncate long file names
String truncateFileName(String fileName, int maxLength) {
  if (fileName.length <= maxLength) {
    return fileName;
  }
  return '${fileName.substring(0, maxLength)}...';
}