part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<String> favoriteIds;
  final bool isFavoriteLoading;
  final String? errorMessage;
  const FavoriteState({
    this.isFavoriteLoading = false,
    this.errorMessage,
    this.favoriteIds = const [],
  });

  FavoriteState copyWith({
    List<String>? favoriteIds,
    bool? isFavoriteLoading,
    String? errorMessage,
  }) {
    return FavoriteState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isFavoriteLoading: isFavoriteLoading ?? this.isFavoriteLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [favoriteIds, isFavoriteLoading, errorMessage];
}
