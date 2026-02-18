pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")

// Fix for isar_flutter_libs and other packages missing namespace
gradle.beforeProject {
    if (this.hasProperty("android")) {
        val androidExtension = this.extensions.findByName("android")
        if (androidExtension is com.android.build.gradle.LibraryExtension) {
            if (androidExtension.namespace == null) {
                androidExtension.namespace = this.group.toString()
            }
        }
    }
}