# حل مشكلة Smart Auth السابقة
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-dontwarn com.google.android.gms.auth.api.credentials.**

# حل مشكلة Play Core الجديدة (Missing classes detected)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# قواعد فلاتر الأساسية
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }