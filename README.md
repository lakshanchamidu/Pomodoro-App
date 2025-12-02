# 🍅 Smart Pomodoro App

A complete and feature-rich Pomodoro Timer application built with Flutter. Track your productivity, manage tasks, and achieve your goals with the Pomodoro Technique, powered by **Hive local database** for fast and reliable data persistence.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?logo=dart)
![Hive](https://img.shields.io/badge/Database-Hive-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### 🎯 Core Functionality
- **Pomodoro Timer**: Classic 25-minute focus sessions with break management
- **Task Management**: Create, edit, and organize tasks with full CRUD operations
- **Real-time Statistics**: Track completed sessions, total hours, and productivity trends
- **User Profile**: Personalized profile with achievements and XP progression
- **Beautiful UI**: Glass morphism design with dark mode support
- **Local Database**: All data persists using Hive NoSQL database

### 🏠 Home Screen
- Real-time analog and digital clock display
- Quick start Pomodoro button
- Today's motivational messages
- Direct navigation to focus sessions
- Beautiful gradient background

### ✅ Task Management
- **Add Tasks**: Title, description, category, priority, and estimated Pomodoros
- **Categories**: Work, Study, Personal, Health, Other
- **Priority Levels**: Low, Medium, High
- **Progress Tracking**: Completed vs estimated Pomodoros
- **Edit & Delete**: Full task management capabilities
- **Persistent Storage**: Tasks saved to Hive database

### 📊 Statistics & Analytics
- **Total Pomodoros**: Count of all completed focus sessions
- **Completed Tasks**: Number of finished tasks
- **Weekly Chart**: Visual representation of productivity
- **Category Breakdown**: Pie chart showing task distribution by category
- **Dynamic Data**: All stats calculated from real database

### 👤 Profile Screen
- **User Information**: Name, email, bio, join date
- **Level System**: XP-based progression (Level = Pomodoros / 10)
- **Statistics Cards**: Sessions, hours, current streak
- **Achievements System**: 
  - 🏁 **First Steps**: Complete your first Pomodoro
  - 🔥 **Focus Master**: Complete 10+ sessions
  - 🏆 **Century Club**: Complete 100+ sessions
  - 🏃 **Marathon Runner**: Complete 50+ hours
  - 🎖️ **Week Warrior**: Maintain 7+ day streak
  - 🏅 **Task Champion**: Complete 50+ tasks
- **Editable Profile**: Update name, email, and bio
- **Data Persistence**: Profile saved to Hive

### ⚙️ Settings Screen
- **Timer Settings**:
  - Focus duration (default: 25 min)
  - Short break (default: 5 min)
  - Long break (default: 15 min)
  - Sessions before long break
- **Notifications**: Toggle alerts and sounds
- **Appearance**: Light/Dark theme
- **Account Management**: Edit profile, change password
- **Data & Privacy**: Export/clear data options

### 🎨 Design Features
- **Glass Morphism**: Frosted glass effects on login screen
- **Gradient Backgrounds**: Beautiful color transitions
- **Material Design 3**: Modern UI components
- **Smooth Animations**: Fluid transitions and interactions
- **Responsive Layout**: Adapts to all screen sizes
- **Custom Bottom Navigation**: Easy screen switching

## 📱 Screenshots

### Authentication
- **Login Screen**: Full-screen background with glass effect form
- **Sign Up Screen**: Beautiful registration interface

### Main Screens
- **Home**: Timer widget with clock and quick actions
- **Tasks**: List view with add/edit/delete functionality
- **Statistics**: Charts and analytics dashboard
- **Profile**: User stats, achievements, and level progression
- **Settings**: Comprehensive app configuration

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / VS Code
- Android Emulator or Physical Device / iOS Simulator

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/lakshanchamidu/Pomodoro-App.git
cd pomodoro_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate Hive type adapters** (Important!)
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

## 📦 Dependencies

### Production Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Database
  hive: ^2.2.3                          # Fast NoSQL database
  hive_flutter: ^1.1.0                  # Flutter integration for Hive
  path_provider: ^2.1.5                 # File system paths
  
  # Utilities
  intl: ^0.19.0                         # Date formatting
  flutter_local_notifications: ^18.0.1  # Push notifications
  shared_preferences: ^2.3.3            # Key-value storage

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  
  # Code Generation
  build_runner: ^2.4.13                 # Build system
  hive_generator: ^2.0.1                # Hive adapter generator
```

### Key Packages Explained
- **hive & hive_flutter**: Lightweight, fast NoSQL database written in pure Dart
- **build_runner**: Generates Hive TypeAdapter classes for models
- **intl**: Internationalization and localization support, date formatting
- **flutter_local_notifications**: Local push notifications for timer completion
- **path_provider**: Access to device file system locations

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point, Hive initialization
├── assets/                            # Images and static assets
├── Models/
│   ├── Task.dart                      # Task model with @HiveType
│   ├── Task.g.dart                    # Generated Hive adapter
│   ├── UserProfile.dart               # User profile model
│   └── UserProfile.g.dart             # Generated adapter
├── Screens/
│   ├── HomeScreen.dart                # Main navigation screen
│   ├── LoginScreen.dart               # Full-screen glass login
│   ├── SignUpScreen.dart              # User registration
│   ├── TasksScreen.dart               # Task CRUD with Hive
│   ├── FocusSessionScreen.dart        # Pomodoro timer screen
│   ├── StatisticsScreen.dart          # Real-time analytics
│   ├── ProfileScreen.dart             # Profile & achievements
│   └── SettingsScreen.dart            # App settings
└── Widgets/
    ├── HomeWidget.dart                # Dashboard timer widget
    └── NavigationBar.dart             # Bottom navigation bar

android/                               # Android-specific files
ios/                                   # iOS-specific files
web/                                   # Web-specific files
test/                                  # Unit and widget tests
```

## 💾 Database Architecture

### Hive Boxes
1. **tasks** (`Box<Task>`):
   - Stores all task data
   - Key: Task ID (String)
   - Value: Task object

2. **userProfile** (`Box<UserProfile>`):
   - Stores user profile data
   - Key: 'user' (single profile)
   - Value: UserProfile object

### Models

#### Task Model
```dart
@HiveType(typeId: 0)
class Task {
  @HiveField(0) final String id;
  @HiveField(1) final String title;
  @HiveField(2) final String description;
  @HiveField(3) final String category;
  @HiveField(4) final int estimatedPomodoros;
  @HiveField(5) final int completedPomodoros;
  @HiveField(6) final bool isCompleted;
  @HiveField(7) final DateTime createdAt;
  @HiveField(8) final String priority;
}
```

#### UserProfile Model
```dart
@HiveType(typeId: 1)
class UserProfile {
  @HiveField(0) final String name;
  @HiveField(1) final String email;
  @HiveField(2) final String bio;
  @HiveField(3) final DateTime joinDate;
}
```

## 💡 Usage Guide

### 1. First Time Setup
- Launch the app
- Login/Sign up (UI only, no authentication yet)
- Automatic profile creation with default values
- Empty task list ready for your first task

### 2. Creating Tasks
1. Navigate to **Tasks** screen
2. Tap the **+** (Add) button
3. Fill in task details:
   - **Title**: Task name
   - **Description**: Optional details
   - **Category**: Work, Study, Personal, Health, Other
   - **Priority**: Low, Medium, High
   - **Estimated Pomodoros**: How many sessions needed
4. Tap **Add Task**
5. Task automatically saved to Hive database

### 3. Starting a Focus Session
1. Go to **Home** screen
2. Tap **Start Focus** button
3. Timer screen opens with selected task
4. 25-minute countdown begins
5. Take a 5-minute break when complete
6. Session data persists across app restarts

### 4. Tracking Progress
- **Statistics Screen**: 
  - View total Pomodoros completed
  - See completed tasks count
  - Check weekly productivity chart
  - Analyze category breakdown
  
- **Profile Screen**:
  - Monitor your level and XP
  - Track total sessions and hours
  - View current streak
  - Unlock achievements

### 5. Managing Your Profile
1. Open **Profile** screen
2. Tap edit icon next to name/email
3. Update information in dialog
4. Changes saved to Hive database
5. Edit bio separately with bio edit button

## 🎨 Design Philosophy

### Color Scheme
- **Primary**: Indigo shades for main elements
- **Gradients**: Blue to purple transitions
- **Accent Colors**:
  - Blue: Task statistics
  - Green: Time tracking
  - Orange: Streaks and achievements
  - Purple: Advanced features
  - Amber: Special achievements

### UI Patterns
- **Glass Morphism**: Semi-transparent containers with blur
- **Cards**: Elevated containers for content grouping
- **Progress Indicators**: Visual feedback for task completion
- **Charts**: Interactive data visualization
- **Bottom Navigation**: Persistent navigation across screens

## 🔧 Configuration

### Customizing Timer Durations
Edit in `SettingsScreen.dart` or `FocusSessionScreen.dart`:
```dart
int focusDuration = 25; // minutes
int shortBreak = 5;     // minutes
int longBreak = 15;     // minutes
```

### Modifying Achievement Thresholds
Edit in `ProfileScreen.dart`:
```dart
if (completedSessions >= 1) // First Steps
if (completedSessions >= 10) // Focus Master
if (completedSessions >= 100) // Century Club
if (totalHours >= 50) // Marathon Runner
if (currentStreak >= 7) // Week Warrior
```

### Adding New Categories
Edit in `TasksScreen.dart`:
```dart
final categories = ['Work', 'Study', 'Personal', 'Health', 'Other', 'YourCategory'];
```

## 🐛 Known Issues & Limitations

1. **Test File Error**: `widget_test.dart` references old MyApp class (non-critical)
2. **Streak Calculation**: Simplified based on task count (enhancement needed)
3. **Authentication**: Login/Sign up screens are UI only (no backend)
4. **Timer Notifications**: Not fully implemented
5. **Data Export**: Export feature in settings not yet functional

## 🚧 Future Enhancements

### High Priority
- [ ] Implement timer notifications
- [ ] Add sound alerts for timer completion
- [ ] Enhanced streak tracking with date-based logic
- [ ] Dark mode toggle in settings
- [ ] Timer customization in settings UI

### Medium Priority
- [ ] Export statistics as PDF/CSV
- [ ] Import/Export database backup
- [ ] Multiple user profiles
- [ ] Cloud sync with Firebase
- [ ] Task templates for recurring tasks
- [ ] Pomodoro history timeline

### Low Priority
- [ ] Social features (share achievements)
- [ ] Advanced analytics (productivity heatmap)
- [ ] Integration with calendar apps
- [ ] Widgets for home screen
- [ ] Apple Watch / Wear OS support
- [ ] Focus mode with app blocking
- [ ] Team/collaborative Pomodoros

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Test Coverage
```bash
flutter test --coverage
```

### Widget Tests
Located in `test/widget_test.dart`

## 📄 License

This project is licensed under the MIT License.

```
MIT License

Copyright (c) 2024 Chamidu Lakshan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👨‍💻 Developer

**Chamidu Lakshan**
- GitHub: [@lakshanchamidu](https://github.com/lakshanchamidu)
- Repository: [Pomodoro-App](https://github.com/lakshanchamidu/Pomodoro-App)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter/Dart style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Keep code clean and commented

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing cross-platform framework
- **Hive Team**: For the fast and efficient local database
- **Material Design**: For comprehensive design guidelines
- **Francesco Cirillo**: Creator of the Pomodoro Technique
- **Open Source Community**: For inspiration and support

## 📖 The Pomodoro Technique

The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s:

1. ⏰ **Choose a task** you'd like to work on
2. 🍅 **Set the timer** to 25 minutes (one "Pomodoro")
3. 💪 **Work on the task** with full focus until the timer rings
4. ✅ **Mark off one Pomodoro** and take a short break (5 minutes)
5. 🔁 **Repeat** steps 2-4
6. 🎉 **After 4 Pomodoros**, take a longer break (15-30 minutes)

### Benefits
- Improved focus and concentration
- Reduced mental fatigue
- Enhanced time awareness
- Better work-life balance
- Increased productivity
- Reduced procrastination

## 📞 Support

For support, bug reports, or feature requests:
- 📧 Email: chamidu@example.com
- 🐛 GitHub Issues: [Create an issue](https://github.com/lakshanchamidu/Pomodoro-App/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/lakshanchamidu/Pomodoro-App/discussions)

## 🌟 Show Your Support

Give a ⭐️ if this project helped you!

## 📈 Project Stats

- **Lines of Code**: ~3000+
- **Screens**: 8 (Login, Sign Up, Home, Tasks, Focus Session, Statistics, Profile, Settings)
- **Database Models**: 2 (Task, UserProfile)
- **Widgets**: Custom navigation, timer, charts, cards
- **Supported Platforms**: Android, iOS, Web, Windows, macOS, Linux

---

<div align="center">

**Made with ❤️ and ☕ using Flutter**

*"Focus on what matters, one Pomodoro at a time"* 🍅

</div>
