# Topics List Application

## Overview
This project is a simplified SwiftUI/Compose iOS/Android application that interacts with a mock backend service to fetch and display data about various topics. 
The backend provides information about topics via two separate RESTful API endpoints: one for listing topics and another for fetching details about a specific topic.

The app fetches and combines the results of two API calls to display a list of topics with additional details.

## Objective
The goal is to build a SwiftUI/Compose-based iOS/Android application that displays a list of topics, each including:
- The topic's title
- A description
- A publication date (formatted as a human-readable date)

### Features:
1. **Single Screen Application:** The app consists of a single screen showing a list of topics with their titlaes, descriptions, and published dates.
2. **Asynchronous Data Fetching:** The app fetches topic data from two endpoints, combining them into a single list item view.
3. **Mock API:** The app uses a protocol to simulate the API interactions, returning mock data to simulate network responses.
4. **Loading and Error Handling:** The app should handle loading states and errors gracefully, showing appropriate user feedback when necessary.

***NOTE*** Application should consist of ONLY 1 screen with list of elements where data is combined from 2 endpoint into single list item. ***NOTE***

## API Endpoints

### 1. **List of Topics**
- **Endpoint:** `GET /api/topics`
- **Description:** Fetches a list of topics, each containing a unique identifier and title.

#### Example Response:
```json
[
    {
        "id": "topic_1",
        "title": "SwiftUI Best Practices"
    },
    {
        "id": "topic_2",
        "title": "Combine Framework"
    },
    {
        "id": "topic_3",
        "title": "Concurrency in Swift"
    }
]
```

### 2. **Topic Details**
- **Endpoint:** `GET /api/topics/{id}`
- **Description:** Fetches a specific topic details.

#### Example Response:
```json
{
    "id": "topic_3",
    "published_at": 123123123,
    "description": "Concurrency in Swift"
}
```

### Topics Table

---------------------------------------------------------------------------------------------------------------
| **Column Name**  | **Data Type**   | **Constraints**         | **Description**                              |
|------------------|-----------------|-------------------------|----------------------------------------------|
| `id`             | `VARCHAR(50)`   | `PRIMARY KEY`           | Unique identifier for the topic.             |
| `title`          | `VARCHAR(255)`  | `NOT NULL`              | The title of the topic.                      |
| `description`    | `TEXT`          | `NOT NULL`              | Detailed description of the topic.           |
| `published_at`   | `BIGINT`        | `NOT NULL`              | UNIX timestamp representing the publish date.|



 MVVM
