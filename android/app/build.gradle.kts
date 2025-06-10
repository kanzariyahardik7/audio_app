plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.my_audio_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.my_audio_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}



dependencies {
    // --- START: Corrected Kotlin DSL syntax for just_audio's ExoPlayer dependencies ---
    // Make sure to use a stable and relatively recent version of ExoPlayer.
    // As of my last update, a common stable version might be 2.18.7 or later.
    // Always check the just_audio pub.dev page or ExoPlayer's official releases for the latest stable version.
    val exoplayer_version = "2.18.7" // Use 'val' for variable declaration in Kotlin DSL

    // Use the function call syntax for adding dependencies in Kotlin DSL
    implementation("com.google.android.exoplayer:exoplayer-core:$exoplayer_version")
    implementation("com.google.android.exoplayer:exoplayer-dash:$exoplayer_version")
    implementation("com.google.android.exoplayer:exoplayer-hls:$exoplayer_version")
    implementation("com.google.android.exoplayer:exoplayer-smoothstreaming:$exoplayer_version")
    // --- END: ExoPlayer dependencies ---
}
