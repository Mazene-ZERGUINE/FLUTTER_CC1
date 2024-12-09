# Flutter Posts Application

This project is a simple Flutter application designed to manage a list of posts using BLOC architecture and Repository pattern. The app interacts with a mock data source that simulates CRUD operations on a list of posts

## Features

1. **Posts List Page**:
    - Displays a list of posts with titles and descriptions.
    - Allows users to swipe left to delete posts.

2. **Post Details Page**:
    - View and edit an existing post.

3. **New Post Creation**:
    - A floating action button navigates to a form for creating a new post.

4. **State Management using Bloc**:
    - Handles all potential states, including:
        - Loading
        - Success
        - Empty list
        - Error


## Mock Data Source

The application uses a `FakePostsDataSource` class to simulate CRUD operations with:
- Fake data for posts.
- Delays to mimic real-world API calls.
- Full support for success, empty, and error scenarios.

## Getting Started

To run the application locally:

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ````

2. Navigate to the project directory:
   ```bash
   cd <project_directory>
   ````

3. Install dependencies:
   ```bash
   flutter pub get
   ````

4. Run the application
   ```bash
   flutter pub run
   ````

