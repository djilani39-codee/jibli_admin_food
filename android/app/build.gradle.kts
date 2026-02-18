import org.gradle.api.tasks.compile.JavaCompile

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.jibli_admin_food"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.jibli_admin_food"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

  buildTypes {
        release {
            // لاحظ الأقواس وعلامات التساوي (هذا هو فرق Kotlin)
            setProguardFiles(listOf(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"))
            
            isMinifyEnabled = true
            isShrinkResources = true
            
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    // الأقواس ضرورية هنا في ملفات .kts
    implementation("com.google.android.play:core:1.10.3")
}

// Show deprecation warnings during Java compilation to get precise locations
tasks.withType<JavaCompile> {
    options.compilerArgs.add("-Xlint:deprecation")
}

apply(plugin = "com.google.gms.google-services")

flutter {
    source = "../.."
}
