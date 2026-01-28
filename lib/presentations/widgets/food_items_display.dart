import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:makanly/presentations/cubits/favorite/favorite_cubit.dart';
import 'package:makanly/presentations/pages/recipe_detail_page.dart';

class FoodItemsDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?>? documentSnapshot;
  const FoodItemsDisplay({super.key, this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailPage(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: documentSnapshot!['imagePath'],
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(documentSnapshot!['imagePath']),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  documentSnapshot!['name'],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Iconsax.flash_1, size: 16, color: Colors.grey),
                    Text(
                      '${documentSnapshot!['cal']} Cal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /// for favorite button
            BlocConsumer<FavoriteCubit, FavoriteState>(
              listener: (context, state) {
                if (state.errorMessage != null &&
                    state.errorMessage!.isNotEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
              builder: (context, state) {
                final String docId = documentSnapshot?.id ?? '';
                final isFav = state.favoriteIds.contains(docId);
                return Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: () {
                        context.read<FavoriteCubit>().toggleFavorite(docId);
                      },
                      child: Icon(
                        isFav ? Iconsax.heart : Iconsax.heart_copy,
                        color: isFav ? Colors.red : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
