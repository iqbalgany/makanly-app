import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FavoriteCubit() : super(const FavoriteState()) {
    loadFavorites();
  }

  void toggleFavorite(String productId) async {
    final currentFavorites = List<String>.from(state.favoriteIds);

    emit(state.copyWith(isFavoriteLoading: true));

    try {
      if (currentFavorites.contains(productId)) {
        currentFavorites.remove(productId);
        await _firestore.collection('userFavorite').doc(productId).delete();
      } else {
        currentFavorites.add(productId);
        await _firestore.collection('userFavorite').doc(productId).set({
          'isFavorite': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      emit(
        state.copyWith(isFavoriteLoading: false, favoriteIds: currentFavorites),
      );
    } catch (e) {
      emit(
        state.copyWith(isFavoriteLoading: false, errorMessage: e.toString()),
      );
    }
  }

  bool isExist(String productId) {
    return state.favoriteIds.contains(productId);
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(isFavoriteLoading: true));
    try {
      final snapshot = await _firestore.collection('userFavorite').get();

      final ids = snapshot.docs.map((doc) => doc.id).toList();

      emit(state.copyWith(isFavoriteLoading: false, favoriteIds: ids));
    } catch (e) {
      emit(
        state.copyWith(isFavoriteLoading: false, errorMessage: e.toString()),
      );
    }
  }
}
