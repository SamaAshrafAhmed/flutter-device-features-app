# Flutter Device Features App

A small Flutter app that demonstrates common device integrations in one guided flow:

- Read Android model and OS information.
- Select multiple images from the device photo library.
- Record audio to a local `.m4a` file and play it back.
- Display a Google Map with a fixed Cairo marker.

## Requirements

- Flutter SDK with Dart `^3.13.0`
- Android Studio or Xcode for the target platform
- A Google Maps API key enabled for the Android Maps SDK

## Run Locally

```bash
flutter pub get
flutter run
```

The current device-info screen calls the Android implementation of
`device_info_plus`, so run the app on Android for the complete flow. The image,
audio, and map integrations also depend on the platform configuration described
below.

## Permissions and Platform Configuration

The app and its plugins use the following permissions or platform declarations.
Permissions are requested by the operating system only when the related feature
is used.

| Platform | Permission or declaration                   | Why it is needed                                                 | Current status                                                                                                                                         |
| -------- | ------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android  | `android.permission.RECORD_AUDIO`           | The `record` package captures microphone input.                  | Declared in `android/app/src/main/AndroidManifest.xml`; requested by `record.hasPermission()`.                                                         |
| Android  | `android.permission.INTERNET`               | Google Maps downloads map data and tiles.                        | Declared by the Flutter debug/profile manifests. Add it to the main manifest for release builds if it is not supplied by a merged dependency manifest. |
| Android  | `android.permission.ACCESS_FINE_LOCATION`   | Needed only for live location or the Google Maps location layer. | Currently declared, but this app does not read location or enable `myLocation`. Remove it unless live location is added.                               |
| Android  | `android.permission.ACCESS_COARSE_LOCATION` | Needed only for approximate live location.                       | Currently declared, but this app does not read location or enable `myLocation`. Remove it unless live location is added.                               |
| Android  | Google Maps API key metadata                | Authenticates the Google Maps Android SDK.                       | Configured in `android/app/src/main/AndroidManifest.xml`; restrict the key in Google Cloud before distribution.                                        |
| iOS      | `NSPhotoLibraryUsageDescription`            | Explains photo-library access when selecting images.             | Declared in `ios/Runner/Info.plist`.                                                                                                                   |
| iOS      | `NSCameraUsageDescription`                  | Required if image picking is changed to use the camera.          | Declared in `ios/Runner/Info.plist`; the current flow selects from the library only.                                                                   |
| iOS      | `NSMicrophoneUsageDescription`              | Explains microphone access for audio recording.                  | Declared in `ios/Runner/Info.plist`.                                                                                                                   |
| macOS    | Microphone usage description/entitlement    | Required when the recording screen is enabled in a macOS build.  | Configure the macOS runner according to the `record` package requirements before targeting macOS.                                                      |

The following integrations do not require a runtime permission in the current
flow:

- `device_info_plus` reads device metadata exposed by the platform.
- `audioplayers` plays the file created by the recorder and does not capture data.
- `google_maps_flutter` needs the API key and network access, but not location
  permission for this fixed-position map.
- `image_picker` uses the platform picker. Android uses the system picker on
  supported versions rather than requesting broad storage access.

Keep permission declarations aligned with actual features. If a feature starts
accessing location, the app must also request and explain that access at runtime
where required by the platform.

## Google Maps Setup

1. Create or select a Google Cloud project.
2. Enable the Maps SDK for Android and create an API key.
3. Restrict the key by Android application ID and signing certificate.
4. Replace the placeholder value in `android/app/src/main/AndroidManifest.xml`.

Do not commit an unrestricted production API key.

## Project Structure

```text
lib/
	main.dart
	screens/
		device_info_screen.dart
		image_gallery_screen.dart
		record_screen.dart
		google_map_screen.dart
	widgets/
		navigation_text_button.dart
```

## Validation

```bash
flutter analyze
flutter test
```

The included widget test is the default Flutter smoke test. Device integrations
should also be exercised on a physical device or an emulator with the required
platform services configured.
