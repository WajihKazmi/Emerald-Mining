# Preserve the MainActivity class to prevent it from being obfuscated
-keep class com.emerald.emerald_mining.MainActivity {
    *;
}

# Preserve all Flutter-related classes and methods to avoid issues
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Example of keeping all classes and methods in the specified package
-keep class com.emerald.emerald_mining.** { *; }

# Flutter uses reflection, so this prevents issues with reflective access
-keepattributes *Annotation*, InnerClasses, EnclosingMethod, Signature

# Add more specific rules here as needed for third-party libraries
# Keep native libraries (.so files)
-keepclasseswithmembers class * {
    native <methods>;
}

# Prevent ProGuard from stripping JNI libraries
-keep class * extends java.lang.Exception

# Google Play Core Library
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.**
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }