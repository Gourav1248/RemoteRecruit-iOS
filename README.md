# RemoteRecruit-iOS
A SwiftUI-based job browsing app built with MVVM architecture, async/await, and the Jobicy API.

## Features

- Browse remote jobs
- Search jobs by title or company
- View detailed job information
- Loading, Empty and Error states
- Async/Await networking
- MVVM architecture
- Dependency Injection
- Unit Tests

## Tech Stack

- Swift 5
- SwiftUI
- MVVM Architecture
- async/await
- URLSession
- XCTest

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture.

- Models represent API response objects.
- Services handle networking.
- ViewModels contain business logic and state management.
- Views are responsible for rendering UI.
- Dependency Injection is used to improve modularity and testability.

## Setup

1. Clone the repository.

2. Open RemoteRecruit.xcodeproj

3. Build and run using Xcode 14+

4. No additional setup is required.


## Project Structure

RemoteRecruit

- Models
- Services
- ViewModels
- Views
- State
- Tests

## Assumptions

- Remotive Public API is used as the data source.
- Search functionality supports job title and company name.
- Jobs with missing salary information display "Not disclosed".
- HTML descriptions are rendered as plain text.

## Testing

Unit tests have been implemented for the ViewModel layer to validate the core business logic.

### Test Coverage

The following scenarios are covered:

- Successful job fetching
- Error handling
- Empty response handling
- Search by job title
- Search by company name
- Empty search behavior

The implemented tests cover the primary business logic and satisfy the required minimum coverage expectations.

## Screenshots

### Job Listing Screen
<img width="300" height="650" alt="RemoteRecruit Listing" src="https://github.com/user-attachments/assets/cdb01f63-294c-488d-84a2-192f3fca8c3f" />

### Job Detail Screen
<img width="300" height="650" alt="RemoteRecruit Detail" src="https://github.com/user-attachments/assets/e0f4714e-0767-480a-a983-1c5f2d4b2e92" />


