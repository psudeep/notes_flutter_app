# notes_lelo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### details of files:

- `note.dart`: Model file defining the structure of a note.
- `note_service.dart`: Service file handling CRUD operations related to notes.
- `settings_service.dart`: Service file handling settings-related operations.
- `note_repository.dart`: Repository file implementing methods to interact with note data from services.
- `settings_repository.dart`: Repository file implementing methods to interact with settings data from services.
- `home_screen.dart`: Screen widget for the main screen containing bottom navigation.
- `note_list_screen.dart`: Screen widget displaying the list of notes.
- `add_note_screen.dart`: Screen widget for adding a new note.
- `note_detail_screen.dart`: Screen widget showing details of a specific note.
- `settings_screen.dart`: Screen widget for app settings.
- `note_item.dart`: Widget file for displaying a single note item.
- `main.dart`: Entry point of your Flutter app.

### hot reload

To relaunch your Flutter app in the emulator after making code changes, you have a few options:

- Hot Reload: If you're making small changes and want to see them reflected in the running app without restarting it, you can use hot reload. Simply save your changes in the code editor, and then press the "R" key twice in your terminal or press the hot reload button in your IDE.
- Stop and Restart: If you've made significant changes or if hot reload isn't working as expected, you can stop the currently running app and restart it. You can do this by pressing "Ctrl+C" in your terminal to stop the running Flutter process, and then running flutter run again.
- Rerun: If you want to ensure a clean build and start the app from scratch, you can use the flutter run command again without stopping the current process. This will rebuild and rerun the app.

### get APK code App code

- Ensure Flutter SDK is Installed: Make sure you have Flutter SDK installed on your system. You can download it from the official Flutter website.
- Update Flutter SDK and Packages: Run the following commands in your terminal to ensure you have the latest Flutter SDK and packages:

- prerequisites command 
-- `flutter upgrade`
-- `flutter pub get`

- `flutter build apk --release`
- `flutter build apk --debug`
- If you have device connected using the command `flutter install`
