# Smart Pomodoro App 🍅⏰

A complete and feature-rich Pomodoro Timer application built with Flutter. This app helps you boost your productivity using the Pomodoro Technique with beautiful UI and comprehensive features.

## Features ✨

### 🏠 Home Screen
- Beautiful animated Pomodoro timer
- Real-time clock display
- Session type switcher (Pomodoro, Short Break, Long Break)
- Customizable timer durations
- Session counter and progress tracking
- Visual circular progress indicator

### ✅ Task Management
- Create, edit, and delete tasks
- Task categories (Development, Education, Health, Work, General)
- Priority levels (High, Medium, Low)
- Estimated vs completed Pomodoros tracking
- Task filtering (All, Active, Completed)
- Swipe to delete tasks
- Progress bars for each task

### 📊 Statistics & Analytics
- Weekly activity charts
- Total Pomodoros and hours tracking
- Task completion statistics
- Current and best streak tracking
- Category breakdown with visual charts
- Productivity insights and tips
- Performance trends

### 👤 Profile Management
- User profile with avatar
- Level and XP system
- Achievement badges
- Session statistics
- Edit profile information
- Bio and personal details
- Share profile functionality

### ⚙️ Settings
- Timer customization
  - Pomodoro length
  - Short break duration
  - Long break duration
  - Sessions before long break
- Automation settings
  - Auto-start breaks
  - Auto-start Pomodoros
- Notifications
  - Push notifications
  - Sound alerts
  - Vibration
- Appearance
  - Light/Dark theme toggle
- Account management
  - Edit profile
  - Change password
- Data & Privacy
  - Export data
  - Clear data
- App information
  - Version info
  - Privacy policy
  - Terms of service

### 🎨 UI/UX Features
- Beautiful gradient designs
- Smooth animations
- Dark mode support
- Responsive design
- Material Design 3
- Custom color schemes
- Interactive widgets

## Screenshots 📱

*(Add screenshots here)*

## Installation 🚀

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pomodoro-app.git
```

2. Navigate to the project directory:
```bash
cd pomodoro_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Dependencies 📦

- `flutter` - Flutter SDK
- `cupertino_icons` - iOS style icons
- `intl` - Internationalization and date formatting
- `shared_preferences` - Local data storage
- `flutter_local_notifications` - Push notifications

## Project Structure 📁

```
lib/
├── main.dart                 # App entry point
├── Models/
│   └── Task.dart            # Task data model
├── Screens/
│   ├── HomeScreen.dart      # Main app screen with navigation
│   ├── LoginScreen.dart     # User login
│   ├── SignUpScreen.dart    # User registration
│   ├── TasksScreen.dart     # Task management
│   ├── StatisticsScreen.dart # Analytics and stats
│   ├── ProfileScreen.dart   # User profile
│   ├── SettingsScreen.dart  # App settings
│   └── FocusSessionScreen.dart # Dedicated focus timer
└── Widgets/
    ├── HomeWidget.dart      # Pomodoro timer widget
    └── NavigationBar.dart   # Bottom navigation
```

## Usage 💡

### Starting a Pomodoro Session
1. Open the app and tap the timer
2. Select your session type (Pomodoro/Break)
3. Press Start
4. Focus on your task!
5. Take a break when the timer completes

### Managing Tasks
1. Navigate to Tasks screen
2. Tap '+' button to create a new task
3. Set title, description, category, priority
4. Estimate Pomodoros needed
5. Track progress as you complete sessions

### Viewing Statistics
1. Navigate to Statistics screen
2. Select time period (Week/Month/Year)
3. View your activity charts
4. Check category breakdown
5. Read productivity insights

### Customizing Settings
1. Navigate to Settings screen
2. Adjust timer durations
3. Enable/disable notifications
4. Toggle dark mode
5. Manage account preferences

## The Pomodoro Technique 🍅

The Pomodoro Technique is a time management method developed by Francesco Cirillo:

1. **Choose a task** you want to work on
2. **Set the timer** to 25 minutes (1 Pomodoro)
3. **Work on the task** until the timer rings
4. **Take a short break** (5 minutes)
5. **After 4 Pomodoros**, take a longer break (15-30 minutes)

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Developer 👨‍💻

**Chamidu Lakshan**
- GitHub: [@lakshanchamidu](https://github.com/lakshanchamidu)

## Acknowledgments 🙏

- Flutter team for the amazing framework
- Material Design for the design guidelines
- Pomodoro Technique by Francesco Cirillo

## Future Enhancements 🔮

- [ ] Cloud sync across devices
- [ ] Team collaboration features
- [ ] Advanced analytics and reports
- [ ] Custom timer sounds
- [ ] Integration with calendar apps
- [ ] Export reports as PDF
- [ ] Widget support for home screen
- [ ] Apple Watch & Wear OS support

---

Made with ❤️ using Flutter
