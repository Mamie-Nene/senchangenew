-keepclassmembers class ai.deepar.ar.DeepAR { *; }
-dontwarn android.**
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Play Core classes used by Flutter even if unused
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**
