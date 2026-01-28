import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:recipe_app/core/themes/colors.dart';
import 'package:recipe_app/presentations/cubits/favorite/favorite_cubit.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Text('Favorite', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final favoriteItems = state.favoriteIds;
          if (favoriteItems.isEmpty) {
            return Center(
              child: Text(
                'No Favorites yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              String favorite = favoriteItems[index];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('RecipeModel')
                    .doc(favorite)
                    .get(),
                builder: (context, snapshot) {
                  final favoritesItem = snapshot.data!;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('Error loading favorites'));
                  }
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.all(15),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      favoritesItem['imagePath'],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    favoritesItem['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.flash_1,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        '${favoritesItem['cal']} Cal',
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
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 35,
                        child: GestureDetector(
                          onTap: () {
                            context.read<FavoriteCubit>().toggleFavorite(
                              favoritesItem.id,
                            );
                          },
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
