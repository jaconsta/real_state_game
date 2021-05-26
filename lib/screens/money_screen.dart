import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MoneyScreen extends StatefulWidget {
  static const id = 'MoneyScreen';
  const MoneyScreen({Key key}) : super(key: key);

  @override
  _MoneyScreenState createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  int transferValue;
  bool isError = false;
  bool balanceError = false;

  Widget renderError() {
    if (isError == false) {
      return Container();
    }
    return Text('There is an error above');
  }

  Widget renderNotEnoughBalanceError() {
    if (balanceError == false) {
      return Container();
    }
    return Text('Not enough balance');
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    int currentMoney = arguments['currentMoney'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Receive / send money')
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Money balance $currentMoney'),
              TextField(keyboardType: TextInputType.number, onChanged: (value) {
                int newVal = int.tryParse(value);
                if (newVal == null) {
                  setState(() {
                    isError = true;
                  });
                } else {
                  transferValue = newVal;
                  if(isError) {
                    setState(() {
                      isError = false;
                    });
                  }
                }
              },),
              renderError(),
              renderNotEnoughBalanceError(),
              TextButton(onPressed: () {
                Navigator.pop(context, transferValue);
              }, child: Text('receive')
              ),
              TextButton(onPressed: () {
                int negativeValue = transferValue * -1;
                int preBalance = currentMoney + negativeValue;
                if (preBalance < 0) {
                  setState(() {
                    balanceError = true;
                  });
                  return;
                }
                Navigator.pop(context, negativeValue);
              }, child: Text('pay'))
            ],
        ),
      )
    );
  }
}
