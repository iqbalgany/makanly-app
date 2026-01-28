import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:makanly/core/themes/colors.dart';
import 'package:makanly/presentations/widgets/custom_icon_button.dart';
import 'package:makanly/presentations/widgets/food_items_display.dart';

class ViewAllItemsPage extends StatefulWidget {
  const ViewAllItemsPage({super.key});

  @override
  State<ViewAllItemsPage> createState() => _ViewAllItemsPageState();
}

class _ViewAllItemsPageState extends State<ViewAllItemsPage> {
  final CollectionReference completeApp = FirebaseFirestore.instance.collection(
    'RecipeModel',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          SizedBox(width: 15),
          CustomIconButton(
            icon: Icons.arrow_back_ios,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          Text(
            'Quick & Easy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          CustomIconButton(icon: Iconsax.notification, pressed: () {}),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            StreamBuilder(
              stream: completeApp.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Center(child: Text('Error'));
                } else if (streamSnapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: streamSnapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Column(
                        children: [
                          FoodItemsDisplay(documentSnapshot: documentSnapshot),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 5),
                              Text(
                                '${documentSnapshot['rating'].toString()}/5',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                '${documentSnapshot['review'].toString()} Reviews',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
