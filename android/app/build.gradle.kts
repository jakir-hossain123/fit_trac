plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fit_trac"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget ="17"
    }

    defaultConfig {
        applicationId = "com.example.fit_trac"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {

        release {
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("debug")
        }

    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-auth:21.4.0")

    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    implementation("com.google.firebase:firebase-auth")

    implementation("com.google.firebase:firebase-analytics")

    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}