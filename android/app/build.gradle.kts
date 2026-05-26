plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.app_educativa"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // CORREGIDO: Volvemos a la sintaxis clásica compatible con tu plugin de Kotlin
    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.app_educativa"
        
        // Mantener números fijos para evitar problemas de referencias
        minSdk = flutter.minSdkVersion 
        targetSdk = 36
        
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // --- AGREGA ESTA LÍNEA PARA EVITAR QUE LA APP SE QUEDE PEGADA ---
        multiDexEnabled = true 
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.1.0"))
    implementation("com.google.firebase:firebase-analytics")
    
    // --- AGREGA ESTA LÍNEA PARA PODER GUARDAR LOS DATOS ---
    implementation("com.google.firebase:firebase-firestore")
}
