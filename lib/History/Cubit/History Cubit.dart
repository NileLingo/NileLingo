import 'package:flutter_bloc/flutter_bloc.dart';
import '../Service/History API.dart';
import 'History States.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  HistoryCubit() : super(HistoryInitialState());

  static HistoryCubit get(context) => BlocProvider.of(context);
  late var translations = [];
  Future<void> fetchUserTranslations(String userId) async {
    emit(HistoryLoadingState());

    try {
      translations = (await HistoryAPI.getUserTranslations(userId))!;

      if (translations != null && translations.isNotEmpty) {
        print(translations);
        emit(HistorySuccessState());
      } else {
        emit(HistoryErrorState("No translations found."));
      }
    } catch (e) {
      emit(HistoryErrorState("Error retrieving translations: ${e.toString()}"));
    }
  }

}
