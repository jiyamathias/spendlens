.PHONY: android-apk android-appbundle ios-release app-icon clean

android-apk:
	flutter build apk --release

android-appbundle:
	flutter build appbundle --release

ios-release:
	flutter build ios --release --no-codesign

app-icon:
	dart run flutter_launcher_icons

clean:
	flutter clean
	flutter pub get

gen-script:
	dart run build_runner build --delete-conflicting-outputs