# 📖 Al-Quran App - Demo Project

> **⚠️ DISCLAIMER: This is a DEMO project for showcasing coding skills. Not intended for production use or religious purposes.**

A beautiful Flutter mobile application for reading the Holy Quran with modern UI/UX design. This project demonstrates advanced Flutter development skills including state management, API integration, audio playback, and responsive design.

## 🎯 Project Overview

This is a **DEMONSTRATION PROJECT** created by [CodingGeh](https://github.com/Coding-Geh) to showcase:
- Flutter development skills
- Modern UI/UX design principles
- API integration capabilities
- State management with Provider
- Audio playback functionality
- Multi-language support
- Responsive design patterns

## 🚀 Features

### 📱 Core Features
- **Complete Quran Reading**: All 114 surahs with Arabic text and translations
- **Multi-language Support**: Indonesian and English translations
- **Audio Recitation**: Listen to beautiful Quran recitations by Sheikh Mishary Rashid Alafasy
- **Bookmark System**: Save and manage your favorite ayahs
- **Search Functionality**: Find surahs by name or translation
- **Modern UI**: Beautiful, responsive design with smooth animations

### 🎨 UI/UX Features
- **Dark/Light Theme**: Adaptive theme system
- **Smooth Animations**: Fade and slide transitions
- **Responsive Design**: Works on all screen sizes
- **Pull-to-Refresh**: Easy content refresh
- **Loading States**: Professional loading indicators
- **Error Handling**: User-friendly error messages

### 🔧 Technical Features
- **State Management**: Provider pattern implementation
- **API Integration**: Multiple RESTful API endpoints for translations
- **Audio Streaming**: Real-time audio playback
- **Local Storage**: Persistent bookmark data
- **Internationalization**: i18n support with separate translation APIs
- **Error Handling**: Comprehensive error management

## 🛠️ Technology Stack

### Frontend
- **Flutter**: 3.32.2 (Latest stable)
- **Dart**: 3.8.1
- **Provider**: State management
- **Easy Localization**: i18n support

### Audio & Media
- **just_audio**: Audio playback
- **audio_session**: Audio session management

### UI & Design
- **Material Design 3**: Modern design system
- **Custom Animations**: Fade and slide transitions
- **Responsive Layout**: Adaptive design

### Data & Storage
- **SharedPreferences**: Local data persistence
- **HTTP**: API communication
- **JSON**: Data serialization

## 📡 API Integration

This app uses the **AlQuran Cloud API** for Quran data:

- **Base URL**: `https://api.alquran.cloud/v1`
- **Documentation**: [AlQuran Cloud API](https://alquran.cloud/api)
- **Audio Source**: Sheikh Mishary Rashid Alafasy recitations

### API Endpoints Used
- `GET /surah` - Get all surahs
- `GET /surah/{number}` - Get specific surah with Arabic text
- `GET /surah/{number}/id.indonesian` - Get Indonesian translation
- `GET /surah/{number}/en.sahih` - Get English translation
- `GET /ayah/{number}/ar.alafasy` - Get ayah audio URL
- `GET /surah/{number}/ar.alafasy` - Get surah audio URL

## 📱 Screenshots

### Home Screen
![Home Screen](screenshot/home_screen.png)

### Surah Detail
![Surah Detail](screenshot/surah_detail_screen.png)

### Bookmarks
![Bookmarks](screenshot/bookmark_screen.png)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.32.2 or higher
- Dart 3.8.1 or higher
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Coding-Geh/alquran_app.git
   cd alquran_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── surah_model.dart     # Surah and Ayah models
│   └── bookmark_model.dart  # Bookmark model
├── providers/               # State management
│   ├── quran_provider.dart  # Quran data provider
│   ├── audio_provider.dart  # Audio playback provider
│   ├── bookmark_provider.dart # Bookmark management
│   └── theme_provider.dart  # Theme management
├── services/                # API services
│   ├── quran_service.dart   # Quran API service
│   ├── audio_service.dart   # Audio API service
│   └── bookmark_service.dart # Local storage service
├── screens/                 # UI screens
│   ├── home_screen.dart     # Main screen
│   ├── surah_detail_screen.dart # Surah detail
│   └── bookmarks_screen.dart # Bookmarks screen
├── widgets/                 # Reusable widgets
│   ├── surah_card.dart      # Surah list item
│   ├── ayah_card.dart       # Ayah display
│   ├── bookmark_card.dart   # Bookmark item
│   └── ...                  # Other UI components
└── utils/                   # Utilities
    ├── app_colors.dart      # Color definitions
    ├── constants.dart       # App constants
    └── text_styles.dart     # Typography styles
```

## 🔧 Configuration

### Environment Setup
- No API keys required (uses public API)
- Internet connection needed for Quran data
- Audio requires internet for streaming

### Localization
- Supported languages: English, Indonesian
- Easy to add more languages via `assets/i18n/`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Important Disclaimers

### Demo Purpose Only
- This app is created **ONLY for demonstration purposes**
- It showcases coding skills and Flutter development capabilities
- **NOT intended for production use**
- **NOT intended for religious purposes**

### No Warranty
- The developer makes no warranties about the accuracy of Quran content
- Users should verify Quran text and translations from authoritative sources
- The developer is not responsible for any religious interpretations

### API Usage
- Uses public AlQuran Cloud API
- API terms and conditions apply
- No guarantee of API availability or accuracy

### Educational Use
- This project is for learning and portfolio purposes
- Feel free to study the code and learn from it
- Please respect the educational nature of this project

## 🤝 Contributing

This is a demo project, but contributions for educational purposes are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Contact

- **Developer**: CodingGeh
- **GitHub**: [@Coding-Geh](https://github.com/Coding-Geh)
- **Repository**: [alquran_app](https://github.com/Coding-Geh/alquran_app)

## 🙏 Acknowledgments

- **AlQuran Cloud API** for providing Quran data
- **Sheikh Mishary Rashid Alafasy** for beautiful recitations
- **Flutter Team** for the amazing framework
- **Open Source Community** for various packages used

---

**Note**: This project is created purely for educational and demonstration purposes. Please use official Quran apps for religious purposes.
