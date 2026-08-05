# ReadNBill Mobile App

## Project Description

ReadNBill is a mobile application developed with Flutter, designed to streamline the process of recording and managing utility readings and billing information. It provides a user-friendly interface for field personnel to input meter readings, track consumer data, and manage billing-related information efficiently.

## Features (Inferred)

Based on the `tempreading_model.dart` file, this application likely includes functionalities such as:

*   **Consumer Data Management**: Store and retrieve consumer details like name, address, account number, route, and sequence number.
*   **Meter Reading Entry**: Record previous and current meter readings, including power readings and demand readings.
*   **Billing Information**: Handle calculations and storage for various billing components such as KWH consumption, core loss, additional KWH, TSF rental, and different types of amounts (QC, PC, EP, BC, ARR).
*   **Status Tracking**: Keep track of account status, discount status (e.g., school tag, senior citizen discount), and update statuses.
*   **Date Management**: Record reading dates, service period end dates, and connection dates.
*   **Read-by Tracking**: Identify who performed the meter reading.
*   **Field Findings and Remarks**: Capture notes and observations from the field.
*   **Offline Capability**: Potentially store data locally using SQLite (inferred from `fromMap` and `toMap` methods).

## Technologies Used

*   **Flutter**: For building native Android and iOS applications from a single codebase.
*   **Dart**: The programming language used by Flutter.
*   **SQLite**: Likely used for local data persistence (inferred from `fromMap` and `toMap` methods).

## Getting Started

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured.
*   A code editor like VS Code or Android Studio with Flutter and Dart plugins.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd readnbill
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the application:**
    ```bash
    flutter run
    ```
    Ensure you have an active device or emulator running.

## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
