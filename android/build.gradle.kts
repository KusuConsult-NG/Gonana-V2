allprojects {
    repositories {
        google()
        mavenCentral()
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

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.configureEach {
        if (this.javaClass.name.contains("com.android.build.gradle.LibraryPlugin")) {
            val android = project.extensions.findByName("android")
            if (android != null) {
                try {
                    val method = android.javaClass.getMethod("setNamespace", String::class.java)
                    val getMethod = android.javaClass.getMethod("getNamespace")
                    if (getMethod.invoke(android) == null) {
                        method.invoke(android, "farm.gonana.${project.name.replace("-", ".")}")
                    }
                } catch (e: Exception) { }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
