import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/statsprovider.dart';
import 'package:provider/provider.dart';

class StatsOverView extends StatelessWidget {
  StatsOverView({super.key});

  final TextStyle textstyle1 =
      const TextStyle(color: Colors.greenAccent, fontSize: 24);
  final TextStyle textstyle2 =
      const TextStyle(color: Colors.redAccent, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Richtige Antworten:",
                textAlign: TextAlign.center,
                style: textstyle1,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Text(
                context.read<StatsProvider>().getRight().toString(),
                style: textstyle1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Falsche Antworten:",
                style: textstyle2,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Text(
                context.read<StatsProvider>().getNotRight().toString(),
                style: textstyle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
