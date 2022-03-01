import 'api_client.dart';
import 'drop_down.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of API Client
  ApiClient client = ApiClient();

  // Function to call API

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  // Setting main colors
  Color kMainColor = Color(0xFF0b0c10);
  Color kSecondaryColor = Color(0xFF66FCF1);

  //Setting the variables
  List<String> currencies = ["INR", "USD"];
  String from = "INR";
  String to = "USD";

  //variables for exchange rate
  double rate = 1;
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainColor,
        body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 18.0,
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
      alignment: Alignment.center,
    width: 200,
    child: Text(
    "Currency Converter Application",
    style: TextStyle(
    color: Color(0xFF66FCF1),
    fontSize: 30,
    fontWeight: FontWeight.bold,
      fontFamily: 'Times New Roman',
    ),
    ),
    ),
    Expanded(
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    TextField(
    onChanged: (value) async {
    rate = await client.getRate(from, to);
    setState(() {
    result =
    (rate * double.parse(value)).toStringAsFixed(3);
    });
    },
    decoration: InputDecoration(
    filled: true,
    fillColor: Color(0xFFC5C6C7),
    labelText: "Enter amount to convert currency",
    labelStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 30.0,
    color: kMainColor,
    ),
    ),
    style: TextStyle(
    color: kMainColor,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
    ),
    SizedBox(
    height: 15.0,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    customDropDown(currencies, from, (val) {
    setState(() {
    from = val;
    });
    }),
    FloatingActionButton(
    onPressed: () {
    setState(() {
    String temp = from;
    from = to;
    to = temp;
    });
    },
    child: Icon(Icons.swap_horiz_sharp),
    elevation: 0.0,
    backgroundColor: kSecondaryColor,
    ),
    customDropDown(currencies, to, (val) {
      setState(() {
        to = val;
      });
    }),
    ],
    ),
      SizedBox(height: 30.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xFFC5C6C7),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              result,
              style: TextStyle(
                color: kMainColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
    ),
    ),
    ),
    ],
    ),
        ),
        ),
    );
  }
}
