# Rick and Morty iOS App

## Overview
This iOS application was built as part of a take-home test, designed to interact with the [Rick and Morty API](https://rickandmortyapi.com/documentation/). It fetches a list of characters and displays them in a paginated list. The app demonstrates clean code practices, modular architecture, and scalability, aligning with the concept of a **"Super App"** where different teams own and manage various features or mini-apps independently.

### Architecture Design
The architecture has been thoughtfully designed to support the **"Super App"** concept, preparing for scalability and modular team-based feature ownership. It promotes encapsulation by dividing the app into independent modules, each managed by separate teams. The modules can be easily integrated into the main app while retaining separation of concerns.

### Modules Overview

- **Character Module:** Handles all character-related features, including the list, filtering, and detailed view.
- **Core Module:** Contains common utilities, helpers, and foundational services.
- **UIToolkit Module:** Provides reusable UI components that can be used across different modules.
- **Networking Module:** Manages API calls and network-related operations, utilizing async/await for clean and efficient code execution.

### Flow Controller
A key design element is the use of a `FlowController` in the `Character` Module. This controller encapsulates the navigation logic for the character feature and is exposed to the main app through an `AppFlowController`, which initiates the character flow. This clean separation promotes modularity and maintainability, ensuring that each module operates independently while the super app consumes and coordinates them.

### API Integration
The app uses **async/await** for asynchronous API calls, providing a modern, clean approach to handling data fetching, which improves readability and performance. The paginated data is fetched from the `Rick and Morty API`, and the app efficiently handles loading and displaying the data with pagination.

### Technologies
- **MVVM Architecture:** Follows the **MVVM pattern with FlowController**, promoting clean code, testability, and modularity.
- **Swift:** The core language used for the app’s development.
- **SwiftUI:** Implemented for small view components, such as `CharacterListView` and `FilterButtonView`.
- **UIKit:** Used for essential views like `Navigation`, `UITableViews`, and `ViewControllers`.
- **Modular Architecture:** The app is designed with a modular structure, promoting scalability for larger apps and teams.
- **XCTest:** Comprehensive unit tests covering `Services`, `ViewModels`, and `Critical` use cases.

### Clean Code & Testing
Throughout the project, I followed clean code architecture principles, focusing on separation of concerns and ensuring maintainability. Each module was developed to function independently, with high cohesion and low coupling. I ensured that almost all essential use cases were covered with appropriate unit tests, ensuring robustness and preventing regressions.

## Challenges and Solutions
### Designing for a Super App
Given the scope of this project and the super app concept, one challenge was to ensure that the architecture would be flexible enough to support independent teams working on different modules. I tackled this by creating a modular structure, allowing different teams to manage their modules separately and push updates to the main app without dependencies.

## How to Build and Run
1. Clone the repository:
   ```ruby
   git clone https://github.com/wajahathassan64/RickAndMorty.git
   ```
2. Open the project in Xcode using terminal:
   ```ruby
   cd RickAndMorty
   open RickAndMortyApp.xcodeproj
   ```
## Assumptions and Decisions
The app was designed with scalability in mind, anticipating future growth into a super app.
Modular design was chosen to allow independent teams to manage their features (modules) without conflicting with others.
Used UIKit for larger views like the character list (UITableView) and SwiftUI for smaller components to demonstrate familiarity with both frameworks.
