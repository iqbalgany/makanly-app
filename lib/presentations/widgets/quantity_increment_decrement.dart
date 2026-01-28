import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QuantityIncrementDecrement extends StatelessWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;

  const QuantityIncrementDecrement({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2.5, color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onRemove, icon: Icon(Iconsax.minus_copy)),
          SizedBox(width: 10),
          Text(
            currentNumber.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          IconButton(onPressed: onAdd, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
