import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:makanly/core/themes/colors.dart';
import 'package:makanly/presentations/cubits/favorite/favorite_cubit.dart';
import 'package:makanly/presentations/cubits/quantity/quantity_cubit.dart';
import 'package:makanly/presentations/widgets/custom_icon_button.dart';
import 'package:makanly/presentations/widgets/quantity_increment_decrement.dart';

class RecipeDetailPage extends StatefulWidget {
  final DocumentSnapshot<Object?>? documentSnapshot;
  const RecipeDetailPage({super.key, required this.documentSnapshot});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: startCookingAndFavoriteButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.documentSnapshot!['imagePath'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.documentSnapshot!['imagePath'],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      CustomIconButton(
                        icon: Icons.arrow_back_ios_new,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      CustomIconButton(
                        icon: Iconsax.notification,
                        pressed: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.sizeOf(context).width,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    widget.documentSnapshot!['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Iconsax.flash_1, size: 20, color: Colors.grey),
                      Text(
                        '${widget.documentSnapshot!['cal']} Cal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text(
                        '${widget.documentSnapshot!['rating'].toString()}/5',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '${widget.documentSnapshot!['review'].toString()} Reviews',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredient',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'How many servings?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      BlocBuilder<QuantityCubit, QuantityState>(
                        builder: (context, state) {
                          return QuantityIncrementDecrement(
                            currentNumber: state.currentNumber,
                            onAdd: () => context
                                .read<QuantityCubit>()
                                .incrementQuantity(),
                            onRemove: () => context
                                .read<QuantityCubit>()
                                .decrementQuantity(),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: widget
                                .documentSnapshot!['imageIngredients']
                                .map<Widget>(
                                  (imageUrl) => StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('RecipeModel')
                                        .doc(widget.documentSnapshot!.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return Center(
                                          child: Text('Data tidak ditemukan'),
                                        );
                                      }

                                      return Container(
                                        height: 60,
                                        width: 60,
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imageUrl),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.documentSnapshot!['ingredients']
                                .map<Widget>(
                                  (ingredient) => SizedBox(
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        ingredient,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Text(
              'Start Cooking',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10),
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              final String docId = widget.documentSnapshot?.id ?? '';
              final isFav = state.favoriteIds.contains(docId);
              return IconButton(
                style: IconButton.styleFrom(
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                ),
                onPressed: () {
                  context.read<FavoriteCubit>().toggleFavorite(
                    widget.documentSnapshot!.id,
                  );
                },
                icon: Icon(
                  isFav ? Iconsax.heart : Iconsax.heart_copy,
                  color: isFav ? Colors.red : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
