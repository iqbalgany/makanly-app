import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_state.dart';

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(const QuantityState());

  void setBaseIngredientAmount(List<double> amounts) {
    emit(state.copyWith(isLoading: true));
    try {
      emit(state.copyWith(isLoading: false, baseIngredientAmounts: amounts));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  List<String> get updateIngredientAmounts {
    return state.baseIngredientAmounts!
        .map((amount) => (amount * state.currentNumber).toStringAsFixed(1))
        .toList();
  }

  void incrementQuantity() {
    emit(state.copyWith(currentNumber: state.currentNumber + 1));
  }

  void decrementQuantity() {
    if (state.currentNumber > 1) {
      emit(state.copyWith(currentNumber: state.currentNumber - 1));
    }
  }
}
