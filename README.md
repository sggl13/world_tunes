# World Tunes

World Tunes is a Flutter web application that allows users to explore and listen to radio stations from around the world.

## Features

- User authentication (login and account creation)
- Fetch and display radio stations based on the user's selected region
- Interactive map for selecting countries
- Play and control radio stations
- Manage favorite radio stations with local storage
- Responsive design for different screen sizes

## Project Structure

- `lib/core`: Contains the core logic of the application, including providers, services, models, enums, routing, and utilities.
- `lib/ui`: Contains the UI components of the application, including screens, views, and widgets.

## Setup Instructions

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.2.3 or later)
- [Firebase CLI](https://firebase.google.com/docs/cli) (for Firebase setup)
- [Git](https://git-scm.com/) (for version control)

### Clone the Repository

```bash
git clone https://github.com/your-username/world-tunes.git
cd world-tunes

1. **Open the Project**
- Open Android Studio or VS Code, or another Flutter-compatible IDE
- Select 'Open an Existing Project' and navigate to your project's directory.

2. **Get Dependencies**
- Open the terminal within the IDE.
- Run:
  ```
  flutter pub get
  ```

3. **Start an Emulator or Connect a Device**
- Use the device manager in your IDE to start an emulator.
- Or, connect a physical device via USB.

4. **Run the App**
- Click the 'Run' button in your IDE.

## Troubleshooting

If you encounter issues, verify that:
- Your Flutter SDK installation is correct and up-to-date.
- All dependencies are installed via `flutter pub get`.

For more detailed troubleshooting, refer to Flutter's official documentation.

