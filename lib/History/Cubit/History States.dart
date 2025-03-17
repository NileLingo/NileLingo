abstract class HistoryStates {}

class HistoryInitialState extends HistoryStates {}

class HistoryLoadingState extends HistoryStates {}

class HistorySuccessState extends HistoryStates {
}


class HistoryErrorState extends HistoryStates {
  final String error;

  HistoryErrorState(this.error);
}

