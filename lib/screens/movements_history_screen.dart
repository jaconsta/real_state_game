import 'package:flutter/material.dart';
import 'package:real_state_game/models/movements_history.dart';

class MovementHistoryScreen extends StatelessWidget {
  static const id = 'MovementHistoryScreen';

  const MovementHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Movements history')
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [...movements.history.map((hist) =>
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20.0,
                        width: double.infinity,
                        child: Text('${hist.date.hour}:${hist.date.minute} ${hist.source} - ${hist.type} - ${hist.amount}')
                      ),
                    ),
                  ),
                ).toList()
              ],
            ),
          ),
          TextButton(onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
