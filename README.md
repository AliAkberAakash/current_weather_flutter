# Current Weather

Developed by: Ali Akber

## Table of Contents

0. [Overview](#0-overview)
1. [Setup Instructions](#1-setup-instructions)
2. [Design_System](#2-design-system)
3. [Architecture Overview](#3-architecture-overview)
5. [Final Notes](#5-final-notes)

## 0. Overview

A Flutter application to view current Weather & Forecasts.

### Video Showcase

todo: add video link

## 1. Setup Instructions

This project was developed using the following Flutter version:

`Flutter 3.24.4 • channel stable • Dart 3.5.4`

### steps
- Clone the repo into your local machine
- Open the project in you favourite IDE
- Add an `env.dart` file under the lib folder
- Add you API key in the `env.dart` file
- Run the app using flutter run command

## 2. Design System

I have created a very small design system for this project, which contains color tokens, fonts, sizing tokens, icons etc. I purposely didn't create any components trying to make this as simple as possible. 
The app also contains a dark theme and light theme thanks to the design system.

## 3. Architecture Overview

The architecture of this Flutter application follows the **Clean Architecture principles**, which promotes separation of concerns. For the sake of simplicity the application uses a monolithic structure with some aspects of multi-modular architecture. Multi-modularization can be achieved relatively easily with the current architecture.

The architecture for the features consists of the following layers:

### Presentation Layer

- **UI Components**: Implement the user interface using Flutter widgets.
- **BLoCs**: Manage the presentation logic and interacts with the domain layer.

### Domain Layer

- **Use Cases**: Contain the business logic independent of any external concerns.
- **Entities**: Represent the core data models and business entities.
- **Repositories**: Defining the Repositories interface so that the data layer can implement it.

### Data Layer

- **Repositories**: Implements the Repository Interface from the domain layer and fulfilling its API 
- **Data Sources**: Provide concrete implementations for interacting with external data sources.
- **Mappers**: Convert data between different layers of the application, such as from raw data obtained from external sources to domain entities.
- **DTO**: Contain data models representing the structure of data fetched from external sources.]()

## 4. Final Notes

#### Doing this assignment was fun!

With my solution I tried to be pragmatic and strike a good balance between simulating production-ready code and keeping it simple.
There are still many functionalities, ux improvements and tests that could be added but were left out for the sake of simplicity.

#### Thank you for taking the time to review and read through :)

I would be more than happy to discuss the solution further with you.