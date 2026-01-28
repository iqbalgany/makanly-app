part of 'quantity_cubit.dart';

class QuantityState extends Equatable {
  final int currentNumber;
  final List<double>? baseIngredientAmounts;
  final bool? isLoading;
  final String? errorMessage;
  const QuantityState({
    this.currentNumber = 1,
    this.baseIngredientAmounts = const [],
    this.isLoading,
    this.errorMessage,
  });

  QuantityState copyWith({
    int? currentNumber,
    List<double>? baseIngredientAmounts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return QuantityState(
      baseIngredientAmounts:
          baseIngredientAmounts ?? this.baseIngredientAmounts,
      currentNumber: currentNumber ?? this.currentNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    currentNumber,
    baseIngredientAmounts,
    isLoading,
    errorMessage,
  ];
}
