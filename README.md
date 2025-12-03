# Union Shop - Flutter E-Commerce Application

A modern, mobile-first e-commerce application built with Flutter, providing a complete shopping experience with product browsing, cart management, and personalized shopping features.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Technologies Used](#-technologies-used)
- [Testing](#-testing)
- [Development](#-development)
- [Contact](#-contact)

## ✨ Features

### 🛍️ Shopping Experience

- **Homepage** with featured products
- **Collections** organized by categories
- **Product Details** with variants and pricing
- **Shopping Cart** with real-time calculations
- **Search** functionality across all products

### 📱 User Interface

- **Mobile-first** responsive design
- **Clean, modern** Flutter UI
- **Intuitive navigation** with drawer menu
- **Consistent branding** and theming

### 🔧 Technical Features

- **Clean Architecture** with separation of concerns
- **State Management** using Provider pattern
- **Comprehensive Testing** suite
- **Cross-platform** compatibility (Web, iOS, Android)

## 📸 Screenshots

> _Application screenshots would be placed here. Consider adding screenshots of your main pages._

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (version 3.0 or higher)
- **Dart SDK** (version 2.17 or higher)
- **Git** for version control
- **Code Editor** (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Achilleas05/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Verify setup**
   ```bash
   flutter doctor
   flutter analyze
   ```

### Running the Application

#### Web Development (Recommended)

```bash
# Run in Chrome
flutter run -d chrome

# Run with hot reload
flutter run -d chrome --hot-reload
```

#### Mobile Development

```bash
# For Android
flutter run -d android

# For iOS (requires macOS)
flutter run -d ios
```

### Viewing in Mobile Mode (Web)

1. Open Chrome DevTools (`F12` or `Ctrl+Shift+I`)
2. Enable Device Toolbar (`Ctrl+Shift+M`)
3. Select a mobile device from the dropdown
4. Refresh the page

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/product_test.dart

# Run with coverage
flutter test --coverage
```

## 📁 Project Structure

```
union_shop/
├── lib/
│   ├── main.dart                      # Application entry point
│   ├── models/                        # Data models
│   │   ├── cart.dart                  # Shopping cart model
│   │   ├── collection.dart            # Product collection model
│   │   ├── fixtures.dart              # Sample data
│   │   ├── order.dart                 # Order model
│   │   └── product.dart               # Product model
│   ├── pages/                         # UI screens
│   │   ├── about_page.dart            # About page
│   │   ├── cart_page.dart             # Shopping cart page
│   │   ├── collection_page.dart       # Collection view
│   │   ├── collections_page.dart      # All collections
│   │   ├── login_page.dart            # Login screen
│   │   └── print_shack_page.dart      # Personalization page
│   └── widgets/                       # Reusable widgets
│       ├── footer.dart                # Footer component
│       ├── header.dart                # Header/navigation
│       └── search_overlay.dart        # Search functionality
├── test/                              # Test files
│   ├── models/                        # Model tests
│   ├── pages/                         # Page tests
│   └── widgets/                       # Widget tests
├── web/                               # Web-specific files
├── android/                           # Android configuration
├── ios/                               # iOS configuration
├── windows/                           # Windows configuration
├── pubspec.yaml                       # Dependencies
└── README.md                          # This file
```

## 🏗️ Technologies Used

### Core Framework

- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### Architecture & Patterns

- **Provider Pattern** - State management
- **MVC Architecture** - Separation of concerns
- **Widget Composition** - Reusable UI components

### Key Dependencies

- **Material Design** - UI components and theming
- **Cupertino Icons** - iOS-style icons
- **Flutter Test** - Testing framework

### Development Tools

- **VS Code/Android Studio** - IDE
- **Git** - Version control
- **Chrome DevTools** - Web debugging

## 🧪 Testing

The project includes comprehensive testing:

### Test Structure

- **Unit Tests**: Model validation and business logic
- **Widget Tests**: UI component testing
- **Integration Tests**: User flow testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests for specific directory
flutter test test/models/

# Generate coverage report
flutter test --coverage
```

### Test Coverage

Current test files include:

- `cart_test.dart` - Cart model tests
- `product_test.dart` - Product model tests
- Page tests for all major UI screens
- Widget tests for reusable components

## 💻 Development

### Code Style

- Follows official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Uses `analysis_options.yaml` for linting rules
- Consistent formatting with `dart format`

### Development Workflow

1. Create feature branch: `git checkout -b feature/feature-name`
2. Implement changes with tests
3. Run tests: `flutter test`
4. Analyze code: `flutter analyze`
5. Format code: `dart format .`
6. Commit changes: `git commit -m "feat: description"`
7. Push and create pull request

### Building for Production

```bash
# Build for web
flutter build web

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

## 🔧 Known Issues & Limitations

### Current Limitations

1. **Authentication System**: Currently uses mock authentication
2. **Payment Processing**: Checkout flow is simulated
3. **Backend Integration**: Uses local fixtures instead of live API
4. **Image Storage**: Product images are local assets

### Future Enhancements

- [ ] Integrate Firebase Authentication
- [ ] Add real payment processing
- [ ] Implement product search backend
- [ ] Add user account management
- [ ] Create admin dashboard
- [ ] Add product reviews system
- [ ] Implement push notifications

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Guidelines

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

## 📞 Contact & Support

### Developer

**Achilleas Achilleos**

- GitHub: [@Achilleas05](https://github.com/Achilleas05)
- Repository: [github.com/Achilleas05/union_shop](https://github.com/Achilleas05/union_shop)

### Getting Help

- **Issues**: Use [GitHub Issues](https://github.com/Achilleas05/union_shop/issues) for bug reports
- **Questions**: Open a discussion in GitHub Issues
- **Suggestions**: Feature requests are welcome

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Dart Community** for excellent packages and support
- **University of Portsmouth** for coursework inspiration
- **Open Source Community** for invaluable resources

---

**Built with ❤️ using Flutter**
