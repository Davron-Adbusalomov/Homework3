import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Screen App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/screen2': (context) => Language(),
        '/screen3': (context) => Parol(),
        '/screen4': (context) => Withdraw(),
        '/screen5': (context) => ResultPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You are welcome!'),
      ),
      body: Stack(
        children: [

          Image.asset(
            'lib/assets/money.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Enter your card', style: TextStyle(color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(context, '/screen2', arguments: ' the language');
                    print('Choose $result');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Enter',style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LanguageButton(
              language: 'English',
              onPressed: () {
                _navigateToNextScreen(context, 'English');
              },
            ),
            LanguageButton(
              language: 'Uzbek',
              onPressed: () {
                _navigateToNextScreen(context, 'Uzbek');
              },
            ),
            LanguageButton(
              language: 'Russian',
              onPressed: () {
                _navigateToNextScreen(context, 'Russian');
              },
            ),

          ],
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context, String selectedLanguage) {
    Navigator.pushNamed(context, '/screen3', arguments: selectedLanguage);
  }
}

class LanguageButton extends StatelessWidget {
  final String language;
  final VoidCallback onPressed;

  LanguageButton({
    required this.language,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            language,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class Parol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String selectedLanguage = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your PIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Selected Language: $selectedLanguage'),
            PinEntryWidget(),
            ElevatedButton(
              onPressed: () {
                _navigateToNextScreen(context, 'Data from Screen 3');
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}

class PinEntryWidget extends StatefulWidget {
  @override
  _PinEntryWidgetState createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<PinEntryWidget> {
  String pin = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        keyboardType: TextInputType.number,
        obscureText: true,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
        onChanged: (value) {
          setState(() {
            pin = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Enter PIN',
        ),
      ),
    );
  }
}

void _navigateToNextScreen(BuildContext context, String data) {
  Navigator.pushNamed(context, '/screen4', arguments: data);
}

class Withdraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter Withdrawal Amount'),
            WithdrawalAmountWidget(),
            ElevatedButton(
              onPressed: () {
                // Add logic to process withdrawal
                _navigateToTheNextScreen(context, 'Withdrawal Successful');
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawalAmountWidget extends StatefulWidget {
  @override
  _WithdrawalAmountWidgetState createState() => _WithdrawalAmountWidgetState();
}

class _WithdrawalAmountWidgetState extends State<WithdrawalAmountWidget> {
  String withdrawalAmount = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
        onChanged: (value) {
          setState(() {
            withdrawalAmount = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Enter Amount',
        ),
      ),
    );
  }
}

void _navigateToTheNextScreen(BuildContext context, String data) {
  Navigator.pushNamed(context, '/screen5', arguments: data);
}


class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String result = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(result),
            ElevatedButton(
              onPressed: () {
                // Add logic to handle the result and navigate accordingly
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
