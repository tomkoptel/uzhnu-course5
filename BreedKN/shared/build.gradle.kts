import org.jetbrains.kotlin.gradle.plugin.mpp.Framework
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("kotlinx-serialization")
    id("com.android.library")
    id("com.squareup.sqldelight")
}

android {
    compileSdkVersion(29)
    defaultConfig {
        minSdkVersion(Versions.min_sdk)
        targetSdkVersion(Versions.target_sdk)
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
}

kotlin {
    android()
    //Revert to just ios() when gradle plugin can properly resolve it
    val onPhone = System.getenv("SDK_NAME")?.startsWith("iphoneos")?:false
    if(onPhone){
        iosArm64("ios")
    }else{
        iosX64("ios")
    }

    version = "1.1"

    sourceSets {
        all {
            languageSettings.apply {
                useExperimentalAnnotation("kotlinx.coroutines.ExperimentalCoroutinesApi")
            }
        }
    }

    sourceSets["commonMain"].dependencies {
        implementation(kotlin("stdlib-common", Versions.kotlin))
        implementation(Deps.SqlDelight.runtime)
        implementation(Deps.SqlDelight.coroutinesExtensions)
        implementation(Deps.stately)
        implementation(Deps.multiplatformSettings)
        implementation(Deps.koinCore)

        implementation(Deps.Coroutines.common)

        implementation(Deps.Ktor.commonCore)
        implementation(Deps.Ktor.commonJson)
        implementation(Deps.Ktor.commonLogging)
        implementation(Deps.Ktor.commonSerialization)
        api(Deps.kermit)
    }

    sourceSets["commonTest"].dependencies {
        implementation(Deps.multiplatformSettingsTest)
        implementation(Deps.KotlinTest.common)
        implementation(Deps.KotlinTest.annotations)
    }

    sourceSets["androidMain"].dependencies {
        implementation(kotlin("stdlib", Versions.kotlin))
        implementation(Deps.SqlDelight.driverAndroid)
        implementation(Deps.Ktor.androidCore)
        implementation(Deps.Coroutines.android)
    }

    sourceSets["androidTest"].dependencies {
        implementation(Deps.KotlinTest.jvm)
        implementation(Deps.KotlinTest.junit)
        implementation(Deps.AndroidXTest.core)
        implementation(Deps.Coroutines.test)
        implementation(Deps.AndroidXTest.runner)
        implementation(Deps.AndroidXTest.rules)
        implementation(Deps.AndroidTest.robolectric)
    }

    sourceSets["iosMain"].dependencies {
        implementation(Deps.SqlDelight.driverIos)
        implementation(Deps.Ktor.ios)

        implementation(Deps.Coroutines.common) {
            version {
                strictly(Versions.coroutines)
            }
        }
    }
    cocoapods {
        summary = "Common library for the KaMP starter kit"
        homepage = "https://github.com/touchlab/KaMPKit"
    }
     // Configure the framework which is generated internally by cocoapods plugin
    targets.withType<KotlinNativeTarget> {
        binaries.withType<Framework> {
            isStatic = true
            export(Deps.kermit)
            transitiveExport = true
        }
    }
}

sqldelight {
    database("BAIDB") {
        packageName = "uzhnu.edu.bai.dialog.db"
    }
    linkSqlite = true
}
