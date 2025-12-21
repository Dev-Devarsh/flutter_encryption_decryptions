## 3.0.0

### 🚀 Major Release: Full Web Support
*   **Web Support**: Added comprehensive support for Flutter Web using `crypto-js`.
    *   Seamless encryption and decryption on web platforms.
    *   Consistent behavior across Android, iOS, and Web.
*   **Package Version Upgrade**: Major version bump to `3.0.0`.
*   **Flutter & Dart SDK Update**: Updated Flutter SDK requirement to `>=3.19.0` and Dart SDK requirement to `>=3.4.0`.
*   **iOS Platform Support**: Updated `ios/encryption_decryptions.podspec` to explicitly mention iOS 13.0 min version.

## 2.1.0

### 🚀 MAJOR MODERNIZATION UPDATE
**Complete package modernization with latest Android and Flutter standards**

#### 🛠️ Build System Modernization
* **Migrated to Kotlin DSL**: Converted from Groovy (`build.gradle`) to Kotlin DSL (`build.gradle.kts`) for better IDE support, autocomplete, and type safety
* **Modern Settings**: Updated `settings.gradle` to `settings.gradle.kts` with enhanced dependency resolution management
* **Enhanced Gradle Configuration**: Added performance optimizations including caching, parallel builds, and configuration on demand

#### 📱 Android Platform Updates
* **Android Gradle Plugin**: Updated from 8.7.0 → **8.11.0** (latest stable)
* **Gradle Wrapper**: Updated from 8.9 → **8.14** (latest stable with Java 24 support)
* **Kotlin**: Updated from 1.7.10 → **2.2.10** (latest stable with K2 compiler)
* **Compile SDK**: Updated from 33 → **35** (Android 15 support)
* **Target SDK**: Updated to **35** (Android 15)
* **Minimum SDK**: Updated from 16 → **21** (Android 5.0+, dropped KitKat support for modern standards)
* **Java Version**: Updated from 8 → **17** (modern LTS version)
* **NDK**: Updated to latest compatible version

#### 🎯 Flutter & Dart Updates
* **Flutter SDK**: Updated minimum requirement from ">=2.5.0" → **">=3.19.0"**
* **Dart SDK**: Updated from ">=2.19.6" → **">=3.3.0"**
* **flutter_lints**: Updated from 2.0.0 → **5.0.0** for enhanced code quality standards

#### 🔧 Build Optimizations & Performance
* **Gradle Performance**: Enabled parallel builds, build caching, and configuration on demand
* **Android Build Optimizations**: Added `nonTransitiveRClass=true` and `nonFinalResIds=true`
* **Memory Settings**: Optimized JVM arguments for better build performance
* **Modern R8**: Enhanced with latest optimization flags

#### 🛡️ Security & Configuration
* **ProGuard Rules**: Added comprehensive `proguard-rules.pro` for release builds
  - Protects plugin classes from obfuscation during development
  - Ensures proper code preservation for debugging
* **Consumer Rules**: Added `consumer-rules.pro` for library consumers
  - **Automatic Protection**: Plugin classes automatically preserved in user's release builds
  - **Zero Setup Required**: No manual ProGuard configuration needed by users
  - **Prevents Crashes**: Eliminates "ClassNotFoundException" in release APKs
  - **Seamless Integration**: Rules applied transparently when users add the plugin
* **Namespace Declaration**: Enhanced namespace configuration for AGP 8.0+ full compatibility
* **Package Security**: Updated dependency versions to address security vulnerabilities

#### 📖 Example App Updates
* **Updated Example**: Modernized example app with same Android standards (compileSdk 35, Java 17, minSdk 21)
* **Gradle Wrapper**: Updated example's Gradle to 8.14
* **Build Configuration**: Aligned example app with main package standards

#### 🔄 Breaking Changes
* **Minimum Android Version**: Now requires Android 5.0+ (API 21) instead of Android 4.1+ (API 16)
* **Minimum Flutter Version**: Now requires Flutter 3.19.0+ instead of 2.5.0+
* **Java Requirements**: Now requires Java 17 for development (previously Java 8)

#### ✅ Compatibility & Testing
* **AGP 8.11.0 Compatible**: Full compatibility with latest Android Gradle Plugin
* **Flutter 3.24+ Ready**: Tested with latest Flutter stable releases
* **Kotlin 2.x Ready**: Compatible with modern Kotlin compiler and language features
* **Android 15 Ready**: Full support for latest Android version and APIs
* **Web Platform Support**: Added full encryption/decryption capabilities for Flutter web applications.
* **Release Build Ready**: Consumer ProGuard rules ensure zero crashes in production APKs

#### 📦 Dependencies
* **Updated Core Dependencies**: All dependencies updated to latest compatible versions
* **Enhanced Annotations**: Updated androidx.annotation to latest version
* **Maintained Compatibility**: Kept existing encryption library (rncryptor-native) for stability

#### 🎯 User Experience Improvements
* **No More Release Build Crashes**: Consumer ProGuard rules automatically prevent obfuscation issues
* **Zero Configuration**: Users don't need to add any ProGuard rules manually
* **Production Ready**: Release APKs work perfectly without additional setup
* **Reduced Support Issues**: Eliminates common "ClassNotFoundException" problems
