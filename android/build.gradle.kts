// Project-level build.gradle.kts (Kotlin DSL)

buildscript {
    val kotlin_version by extra("1.9.22")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // ✅ Android Gradle Plugin
        classpath("com.android.tools.build:gradle:8.4.1")

        // ✅ Kotlin Gradle Plugin
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")

        // FlutterFire (if needed)
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ↓↓↓ Flutter Build Directory Override (Keep this unchanged)
val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
