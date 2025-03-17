import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nile_lingo/Home%20Page/Service/Api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'Home States.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // State variables
  String language1 = "EGY";
  TextEditingController textController = TextEditingController();
  String language2 = "ENG";
  bool isFavourite = false;
  bool isRecording = false;
  bool isAudioInput = false; // To track if input was audio or text
  String path = "";
  String audioFilePath = "";
  bool isPlaying = false;
  bool isResultPlaying = false;
  bool showResult = false;
  String sourceText = "";
  String translation = "";
  AudioApi audioApi = AudioApi();
  String translationId = "";
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  void toggleFavourite() {
    isFavourite = !isFavourite;
    emit(FavoriteToggledState(isFavourite));
  }

  void switchLanguages() {
    String temp = language1;
    language1 = language2;
    language2 = temp;
    emit(LanguageSwitchedState(language1, language2));
  }

  Future<void> toggleRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        path = filePath;
        isRecording = false;
        isAudioInput = true; // Mark as audio input
        emit(RecordingState(isRecording));
        emit(FilePickedState(path));

        // Process the recorded audio
        await processAudioFile(path);
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDirectory = await getApplicationDocumentsDirectory();
        final String filePath = '${appDirectory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.wav';
        await audioRecorder.start(const RecordConfig(), path: filePath);
        isRecording = true;
        emit(RecordingState(isRecording));
      } else {
        emit(ErrorState('You must grant permission to record audio'));
      }
    }
  }

  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'opus'],
    );

    if (result != null && result.files.single.path != null) {
      path = result.files.single.path!;
      isAudioInput = true; // Mark as audio input
      emit(FilePickedState(path));

      // Process the selected audio file
      await processAudioFile(path);
    }
  }

  void showResultWidget() {
    showResult = !showResult;
    emit(ShowResultState(showResult));
  }

  Future<void> togglePlaying({bool isSource = true}) async {
    try {
      if (isSource) {
        if (isResultPlaying) {
          await audioPlayer.stop();
          isResultPlaying = false;
        }

        if (isPlaying) {
          await audioPlayer.pause();
          isPlaying = false;
          print("⏸️ Source audio paused");
        } else {
          if (!File(path).existsSync()) {
            emit(ErrorState("Audio file not found at: $path"));
            print("❌ Error: Audio file not found at $path");
            return;
          }

          await audioPlayer.play(DeviceFileSource(path));
          isPlaying = true;
          print("▶️ Playing source audio: $path");
        }
      } else {
        if (isPlaying) {
          await audioPlayer.stop();
          isPlaying = false;
        }

        if (isResultPlaying) {
          await audioPlayer.pause();
          isResultPlaying = false;
          print("⏸️ Result audio paused");
        } else {
          if (!File(audioFilePath).existsSync()) {
            emit(ErrorState("Audio file not found at: $audioFilePath"));
            print("❌ Error: Audio file not found at $audioFilePath");
            return;
          }

          await audioPlayer.play(DeviceFileSource(audioFilePath));
          isResultPlaying = true;
          print("▶️ Playing result audio: $audioFilePath");
        }
      }

      emit(PlayingState(isPlaying, isResultPlaying));
    } catch (e) {
      print("🚨 Exception in togglePlaying: $e");
      emit(ErrorState("Failed to play audio: $e"));
    }
  }

  Future<void> processAudioFile(String filePath) async {
    if (filePath.trim().isEmpty) {
      emit(ErrorState("Please select an audio file."));
      return;
    }

    translation = "";
    translationId = ""; // Reset translationId before processing
    emit(TranslationLoadingState());

    try {
      isAudioInput = true; // Set as audio input
      String srcLang = (language1 == "EGY") ? "ar" : "en";
      String tgtLang = (language2 == "ENG") ? "en" : "ar";

      // Call the API and receive the translated text, audio file path, and translation ID
      Map<String, String>? result =
      await AudioApi.speechToSpeechTranslation(filePath, srcLang, tgtLang);

      if (result == null || result["audioFilePath"] == null) {
        emit(ErrorState("Translation failed: No audio file returned."));
        return;
      }

      // Extract translation, audio file path, and translation ID
      translation = result["translationText"] ?? "";
      audioFilePath = result["audioFilePath"]!;
      translationId = result["translationId"] ?? "";

      print("🎵 Translated speech audio saved at: $audioFilePath");
      print("📜 Translated text: $translation");
      print("🆔 Translation ID: $translationId");

      emit(TranslationSuccessWithAudioState(translation, audioFilePath, translationId));
    } catch (e) {
      print("🚨 Exception: $e");
      emit(ErrorState("Audio processing failed: $e"));
    }
  }
  Future<void> toggleFavorite(String userId, String translationId) async {
    if (translationId.trim().isEmpty) {
      emit(ErrorState("Invalid translation ID."));
      return;
    }

    emit(FavoriteToggleLoadingState());

    try {
      // Toggle the local state first
      toggleFavourite();

      // Call the API to toggle favorite status
      bool? newFavoriteStatus =
      await AudioApi.toggleFavorite(userId, translationId);

      if (newFavoriteStatus == null) {
        // Revert the change if the API call fails
        toggleFavourite();
        emit(ErrorState("Failed to update favorite status."));
        return;
      }

      print("⭐ Favorite status updated: $newFavoriteStatus");

      emit(FavoriteToggleSuccessState(newFavoriteStatus));
    } catch (e) {
      // Revert the change if an exception occurs
      toggleFavourite();
      print("🚨 Exception: $e");
      emit(ErrorState("Failed to toggle favorite: $e"));
    }
  }

  Future<void> translateAndSpeak(String text) async {
    if (text.trim().isEmpty) {
      emit(ErrorState("Please enter text to translate."));
      return;
    }

    isAudioInput = false; // Set as text input
    sourceText = text.trim();
    translationId = ""; // Reset translationId before processing
    emit(SourceTextChangedState(sourceText));
    emit(TranslationLoadingState());

    try {
      String srcLang = (language1 == "EGY") ? "ar" : "en";
      String tgtLang = (language2 == "ENG") ? "en" : "ar";

      // Call translateAndSpeak to get the translation text, audio path, and translation ID
      Map<String, String>? result =
      await AudioApi.translateAndSpeak(sourceText, srcLang, tgtLang);

      if (result == null) {
        emit(ErrorState("Translation failed: No response from API."));
        return;
      }

      translation = result["translationText"] ?? "";
      audioFilePath = result["audioFilePath"] ?? "";
      translationId = result["translationId"] ?? "";

      if (translation.isEmpty) {
        emit(ErrorState("Translation failed: No text returned."));
        return;
      }

      if (audioFilePath.isEmpty) {
        emit(ErrorState("Audio generation failed: No file path returned."));
        return;
      }

      print("✅ Translation success: $translation");
      print("🎵 Audio file generated at: $audioFilePath");
      print("🆔 Translation ID: $translationId");

      emit(TranslationSuccessWithAudioState(translation, audioFilePath, translationId));
    } catch (e) {
      print("🚨 Exception: $e");
      emit(ErrorState("Translation and speech failed: $e"));
    }
  }

  void reset() {
    isRecording = false;
    isPlaying = false;
    isResultPlaying = false;
    showResult = false;
    isAudioInput = false;
    sourceText = "";
    translation = "";
    path = "";
    audioFilePath = "";
    textController.clear();
    audioPlayer.stop();

    emit(HomeInitialState());
  }
}
