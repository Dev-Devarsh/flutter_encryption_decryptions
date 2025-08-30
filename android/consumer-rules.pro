# Add project specific ProGuard rules here.
# These rules will be applied to consuming applications.

# Keep encryption related classes for consumers
-keep class com.encryption.encryption_decryptions.** { *; }
-keep class com.github.tgio.** { *; }

# Flutter plugin specific
-keep class io.flutter.plugin.common.** { *; } 