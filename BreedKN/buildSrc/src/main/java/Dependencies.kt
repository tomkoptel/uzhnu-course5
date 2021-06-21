object Versions {
    val min_sdk = 21
    val target_sdk = 29
    val compile_sdk = 29

    val kotlin = "1.5.10"
    val android_x = "1.1.0"
    val android_gradle_plugin = "3.6.2"
    val buildToolsVersion = "29.0.0"
    val junit = "4.12"
    val sqlDelight = "1.5.0"
    val ktor = "1.6.0"
    val stately = "1.0.2"
    val multiplatformSettings = "0.7.7"
    val coroutines = "1.5.0-native-mt"
    val koin = "3.1.0"
    val serialization = "1.2.1"
    val cocoapodsext = "0.6"
    val kermit = "0.1.9"
}

object Deps {
    val kermit = "co.touchlab:kermit:${Versions.kermit}"    
    val app_compat_x = "androidx.appcompat:appcompat:${Versions.android_x}"
    val material_x = "com.google.android.material:material:${Versions.android_x}"
    val core_ktx = "androidx.core:core-ktx:${Versions.android_x}"
    val constraintlayout = "androidx.constraintlayout:constraintlayout:${Versions.android_x}"
    val android_gradle_plugin = "com.android.tools.build:gradle:${Versions.android_gradle_plugin}"
    val junit = "junit:junit:${Versions.junit}"
    val stately = "co.touchlab:stately-common:${Versions.stately}"
    val multiplatformSettings = "com.russhwolf:multiplatform-settings:${Versions.multiplatformSettings}"
    val multiplatformSettingsTest = "com.russhwolf:multiplatform-settings-test:${Versions.multiplatformSettings}"
    val koinAndroid = "io.insert-koin:koin-android:${Versions.koin}"
    val koinCore = "io.insert-koin:koin-core:${Versions.koin}"
    val cocoapodsext = "co.touchlab:kotlinnativecocoapods:${Versions.cocoapodsext}"

    object AndroidXTest {
        val core =  "androidx.test:core:${Versions.android_x}"
        val junit =  "androidx.test.ext:junit:${Versions.android_x}"
        val runner = "androidx.test:runner:${Versions.android_x}"
        val rules = "androidx.test:rules:${Versions.android_x}"
    }

    object AndroidTest {
        val robolectric = "org.robolectric:robolectric:4.3"
    }

    object AndroidUI {
        val recyclerView = "androidx.recyclerview:recyclerview:1.1.0"
        val appcompat = "androidx.appcompat:appcompat:1.1.0"
        val constraintlayout = "androidx.constraintlayout:constraintlayout:1.1.3"
    }

    object KotlinTest {
        val common =      "org.jetbrains.kotlin:kotlin-test-common:${Versions.kotlin}"
        val annotations = "org.jetbrains.kotlin:kotlin-test-annotations-common:${Versions.kotlin}"
        val jvm =         "org.jetbrains.kotlin:kotlin-test:${Versions.kotlin}"
        val junit =       "org.jetbrains.kotlin:kotlin-test-junit:${Versions.kotlin}"
        val reflect =     "org.jetbrains.kotlin:kotlin-reflect:${Versions.kotlin}"
    }
    object Coroutines {
        val common = "org.jetbrains.kotlinx:kotlinx-coroutines-core:${Versions.coroutines}"
        val android = "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.coroutines}"
        val test = "org.jetbrains.kotlinx:kotlinx-coroutines-test:${Versions.coroutines}"
    }
    object SqlDelight{
        val gradle = "com.squareup.sqldelight:gradle-plugin:${Versions.sqlDelight}"
        val runtime = "com.squareup.sqldelight:runtime:${Versions.sqlDelight}"
        val coroutinesExtensions = "com.squareup.sqldelight:coroutines-extensions:${Versions.sqlDelight}"
        val runtimeJdk = "com.squareup.sqldelight:runtime-jvm:${Versions.sqlDelight}"
        val driverIos = "com.squareup.sqldelight:native-driver:${Versions.sqlDelight}"
        val driverAndroid = "com.squareup.sqldelight:android-driver:${Versions.sqlDelight}"
    }
    object Ktor {
        val commonCore = "io.ktor:ktor-client-core:${Versions.ktor}"
        val commonJson = "io.ktor:ktor-client-json:${Versions.ktor}"
        val commonLogging = "io.ktor:ktor-client-logging:${Versions.ktor}"
        val androidCore = "io.ktor:ktor-client-okhttp:${Versions.ktor}"
        val ios = "io.ktor:ktor-client-ios:${Versions.ktor}"
        val commonSerialization = "io.ktor:ktor-client-serialization:${Versions.ktor}"
    }

}
