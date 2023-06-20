import 'package:flutter/material.dart';
import 'package:wegojim/indiv_muscle_page.dart';

class MuscleTile extends StatefulWidget {
  final String muscle;
  final String imageLink;

  const MuscleTile({super.key, required this.muscle, required this.imageLink});

  @override
  State<MuscleTile> createState() => _MuscleTileState();
}

class _MuscleTileState extends State<MuscleTile> {
  bool isUpperBodySelected = false;

  bool isLowerBodySelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpperBodyPage(),
          ),
        );*/
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndivMusclePage(title: widget.muscle),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isUpperBodySelected = true;
          });
        },
        onExit: (_) {
          setState(() {
            isUpperBodySelected = false;
          });
        },
        child: Container(
          width: 170,
          height: 170,
          /*color: isUpperBodySelected ? Colors.red : Colors.grey,*/
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: NetworkImage(
                widget.imageLink,
              ),
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child: Text(
              widget.muscle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}