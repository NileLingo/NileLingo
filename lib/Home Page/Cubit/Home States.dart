abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class RecordingState extends HomeStates {
  final bool isRecording;
  RecordingState(this.isRecording);
}

class PlayingState extends HomeStates {
  final bool isPlaying;
  PlayingState(this.isPlaying);
}

class FilePickedState extends HomeStates {
  final String filePath;
  FilePickedState(this.filePath);
}

class LanguageSwitchedState extends HomeStates {
  final String language1;
  final String language2;
  LanguageSwitchedState(this.language1, this.language2);
}

class FavoriteToggledState extends HomeStates {
  final bool isFavourite;
  FavoriteToggledState(this.isFavourite);
}

class ErrorState extends HomeStates {
  final String errorMessage;
  ErrorState(this.errorMessage);
}