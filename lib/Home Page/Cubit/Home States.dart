abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class RecordingState extends HomeStates {
  final bool isRecording;
  RecordingState(this.isRecording);
}

class PlayingState extends HomeStates {
  final bool isPlaying;
  final bool isResultPlaying;
  PlayingState(this.isPlaying,this.isResultPlaying);
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
class ShowResultState extends HomeStates {
  final bool showResult;
  ShowResultState(this.showResult);
}
class TranslationSuccessState extends HomeStates {
  final String translation;
  TranslationSuccessState(this.translation);
}
class TranslationFailedState extends HomeStates {
  final String errorMessage;
  TranslationFailedState(this.errorMessage);
}
class TranslationLoadingState extends HomeStates {}
class SourceTextChangedState extends HomeStates {
  final String sourceText;
  SourceTextChangedState(this.sourceText);
}
class TranslationSuccessWithAudioState extends HomeStates {
  final String translation;
  final String audioFilePath;
  final String translationId;

  TranslationSuccessWithAudioState(this.translation, this.audioFilePath, this.translationId);
}

class FavoriteToggleLoadingState extends HomeStates {}

class FavoriteToggleSuccessState extends HomeStates {
  final bool isFavourite;
  FavoriteToggleSuccessState(this.isFavourite);
}