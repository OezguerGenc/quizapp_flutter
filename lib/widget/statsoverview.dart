import 'package:flutter/material.dart';

class StatsOverView extends StatelessWidget {
  const StatsOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Text("Richtige Antworten:"),
              Text("0"),
            ],
          ),
          Row(
            children: [
              Text("Falsche Antworten:"),
              Text("0"),
            ],
          ),
        ],
      ),
    );
  }
}
