import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();

  String result = '';

  void calculate(String op) {
    final firstText = firstController.text.trim();
    final secondText = secondController.text.trim();

    if (firstText.isEmpty || secondText.isEmpty) {
      setState(() => result = 'Please enter both numbers.');
      return;
    }

    final a = double.tryParse(firstText);
    final b = double.tryParse(secondText);

    if (a == null || b == null) {
      setState(() => result = 'Enter two valid numbers.');
      return;
    }

    double answer;
    switch (op) {
      case '+':
        answer = a + b;
        break;
      case '-':
        answer = a - b;
        break;
      case '×':
        answer = a * b;
        break;
      default:
        if (b == 0) {
          setState(() => result = 'Cannot divide by zero.');
          return;
        }
        answer = a / b;
    }

    setState(() => result = 'Result: $answer');
  }

  void clearAll() {
    setState(() {
      firstController.clear();
      secondController.clear();
      result = '';
    });
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: firstController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: secondController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final op in ['+', '-', '×', '÷'])
                  ElevatedButton(
                    onPressed: () => calculate(op),
                    child: Text(op, style: const TextStyle(fontSize: 20)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: clearAll,
              icon: const Icon(Icons.refresh),
              label: const Text('Clear'),
            ),
            const SizedBox(height: 24),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
