import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomePageWidget> {
  String dateText = "";
  String dayText = "";
  String timeText = "";
  String amPm = "";

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        dateText = DateFormat('MMM dd yyyy').format(now).toUpperCase();
        dayText = DateFormat('EEEE').format(now).toUpperCase();
        timeText = DateFormat('hh:mm').format(now);
        amPm = DateFormat('a').format(now);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dayText,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        amPm,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeText,
                        style: TextStyle(
                          fontSize: 42,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontFamily: 'monospace',
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dateText,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                _buildButton(context, "Start"),
                _buildButton(context, "Stop"),
                _buildButton(context, "Restart"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            foregroundColor: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
