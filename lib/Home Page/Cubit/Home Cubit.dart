import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'Home States.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // State variables
  String language1 = "EGY";
  String language2 = "ENG";
  bool isFavourite = false;
  bool isRecording = false;
  String path = "";
  bool isPlaying = false;
  bool showResult = false;

  // Audio Recorder and Player
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  // Toggle favorite
  void toggleFavourite() {
    isFavourite = !isFavourite;
    emit(FavoriteToggledState(isFavourite));
  }

  // Switch languages
  void switchLanguages() {
    String temp = language1;
    language1 = language2;
    language2 = temp;
    emit(LanguageSwitchedState(language1, language2));
  }

  // Start or stop recording
  Future<void> toggleRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        path = filePath;
        isRecording = false;
        emit(RecordingState(isRecording));
        emit(FilePickedState(path));
        showResultWidget();
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

  // Play or pause audio
  Future<void> togglePlaying() async {
    if (isPlaying) {
      await audioPlayer.pause();
      isPlaying = false;
    } else {
      await audioPlayer.play(DeviceFileSource(path));
      isPlaying = true;
    }
    emit(PlayingState(isPlaying));
  }

  // Pick audio file
  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null && result.files.single.path != null) {
      path = result.files.single.path!;
      emit(FilePickedState(path));
      showResultWidget();
    }
  }
  void showResultWidget() {
    showResult = !showResult;
    emit(ShowResultState(showResult));
  }
  Future<void> reset() async {
    isRecording = false;
    isPlaying = false;
    showResult = false;
    path = "";
    audioPlayer.stop();
    emit(RecordingState(isRecording));
    emit(PlayingState(isPlaying));
    emit(FilePickedState(path));
    emit(ShowResultState(showResult));
  }
}