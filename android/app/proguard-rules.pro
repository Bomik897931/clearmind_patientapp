# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Agora
-keep class io.agora.**{*;}
-dontwarn io.agora.**

# GetX
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Gson
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Retrofit
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep models
-keep class com.example.video_call_app.data.models.** { *; }

# General
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile