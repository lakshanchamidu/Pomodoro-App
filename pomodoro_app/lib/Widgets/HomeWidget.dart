import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomePageWidget> {
  // Clock Text
  String dateText = "";
  String dayText = "";
  String timeText = "";
  String amPm = "";

  // Pomodoro Variables
  Timer? timer;
  int totalSeconds = 1500; // default 25 min
  int remainingSeconds = 1500;
  double progressValue = 1.0;

  String currentMode = "Pomodoro"; // Pomodoro / Short Break / Long Break
  int completedSessions = 0;

  @override
  void initState() {
    super.initState();

    // Clock Timer
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

  // -----------------------------------------------------------------------
  // 🔥 TIME PICKER (USER CAN CHANGE SESSION TIME)
  // -----------------------------------------------------------------------
  void openTimePicker(String mode) {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Set $mode Time (minutes)",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Minutes",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  int minutes = int.tryParse(controller.text) ?? 0;
                  if (minutes > 0) {
                    setState(() {
                      totalSeconds = minutes * 60;
                      remainingSeconds = totalSeconds;
                      progressValue = 1.0;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          ),
        );
      },
    );
  }

  // -----------------------------------------------------------------------
  // 🔥 CHANGE MODE
  // -----------------------------------------------------------------------
  void changeMode(String mode) {
    timer?.cancel();

    setState(() {
      currentMode = mode;

      if (mode == "Pomodoro") {
        totalSeconds = 1500;
      } else if (mode == "Short Break") {
        totalSeconds = 300;
      } else {
        totalSeconds = 900;
      }

      remainingSeconds = totalSeconds;
      progressValue = 1.0;
    });
  }

  // -----------------------------------------------------------------------
  // 🔥 START TIMER
  // -----------------------------------------------------------------------
  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
          progressValue = remainingSeconds / totalSeconds;
        });
      } else {
        timer?.cancel();

        if (currentMode == "Pomodoro") {
          completedSessions++;
          changeMode("Short Break");
          startTimer();
        } else {
          changeMode("Pomodoro");
        }
      }
    });
  }

  // -----------------------------------------------------------------------
  // ⏸ STOP TIMER
  // -----------------------------------------------------------------------
  void stopTimer() {
    timer?.cancel();
  }

  // -----------------------------------------------------------------------
  // 🔄 RESET TIMER
  // -----------------------------------------------------------------------
  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = totalSeconds;
      progressValue = 1.0;
    });
  }

  // -----------------------------------------------------------------------
  // FORMAT TIME (MM:SS)
  // -----------------------------------------------------------------------
  String formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  // -----------------------------------------------------------------------
  // UI SECTION
  // -----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            children: [

              // -----------------------------------------------------------------------
              // 🕒 MODERN CLOCK CARD
              // -----------------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark 
                      ? [
                          const Color(0xFF1F1F3D),
                          const Color(0xFF2A2A4E),
                        ]
                      : [
                          Colors.white,
                          const Color(0xFFFFF5F0),
                        ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      dayText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          timeText,
                          style: TextStyle(
                            fontSize: 52,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          amPm,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dateText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // -----------------------------------------------------------------------
              // 🎯 MODE SELECTOR CHIPS
              // -----------------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark 
                    ? const Color(0xFF1A1A2E).withOpacity(0.5)
                    : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(child: _modernModeButton("Pomodoro")),
                    Expanded(child: _modernModeButton("Short Break")),
                    Expanded(child: _modernModeButton("Long Break")),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Edit Time Button
              TextButton.icon(
                onPressed: () => openTimePicker(currentMode),
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ),
                label: Text(
                  "Customize Time",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // -----------------------------------------------------------------------
              // ⭕ PREMIUM CIRCULAR TIMER
              // -----------------------------------------------------------------------
              Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 280,
                      width: 280,
                      child: CircularProgressIndicator(
                        value: progressValue,
                        strokeWidth: 12,
                        backgroundColor: isDark
                          ? const Color(0xFF2A2A4E)
                          : Colors.grey.shade200,
                        color: Theme.of(context).colorScheme.primary,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Container(
                      height: 240,
                      width: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isDark
                            ? [
                                const Color(0xFF1F1F3D),
                                const Color(0xFF2A2A4E),
                              ]
                            : [
                                Colors.white,
                                const Color(0xFFFFF8F5),
                              ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatTime(remainingSeconds),
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w800,
                              fontFamily: "monospace",
                              color: Theme.of(context).colorScheme.onBackground,
                              letterSpacing: -2,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              currentMode,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Sessions Counter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Completed: $completedSessions sessions",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // -----------------------------------------------------------------------
              // 🎮 MODERN CONTROL BUTTONS
              // -----------------------------------------------------------------------
              Row(
                children: [
                  _modernControlButton(
                    label: "Start",
                    icon: Icons.play_arrow_rounded,
                    onTap: startTimer,
                    isPrimary: true,
                  ),
                  const SizedBox(width: 12),
                  _modernControlButton(
                    label: "Pause",
                    icon: Icons.pause_rounded,
                    onTap: stopTimer,
                    isPrimary: false,
                  ),
                  const SizedBox(width: 12),
                  _modernControlButton(
                    label: "Reset",
                    icon: Icons.refresh_rounded,
                    onTap: resetTimer,
                    isPrimary: false,
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // MODERN BUTTON BUILDERS
  // -----------------------------------------------------------------------

  Widget _modernModeButton(String mode) {
    final isSelected = currentMode == mode;
    
    return GestureDetector(
      onTap: () => changeMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          mode == "Pomodoro" ? "Focus" : mode == "Short Break" ? "Short" : "Long",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected 
              ? Colors.white
              : Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _modernControlButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: isPrimary
              ? LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
            color: isPrimary 
              ? null
              : Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isPrimary 
                ? Colors.transparent
                : Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isPrimary 
                  ? Colors.white
                  : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary 
                    ? Colors.white
                    : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
