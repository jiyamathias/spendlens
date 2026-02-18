// android/build.gradle.kts
allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // Fix for packages missing namespace (isar_flutter_libs)
    afterEvaluate {
        if (this.hasProperty("android")) {
            val androidExtension = this.extensions.findByName("android")
            if (androidExtension is com.android.build.gradle.LibraryExtension) {
                if (androidExtension.namespace == null || androidExtension.namespace!!.isEmpty()) {
                    androidExtension.namespace = this.group.toString().ifEmpty {
                        "com.fallback.${this.name}"
                    }
                }
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
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