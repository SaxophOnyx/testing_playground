# Medication Tracker

## Overview

This Flutter project is a simple medication tracker that allows users to:

- **Add medication batches**
- **View added medication batches**
- **Consume medications from automatically picked batch**

The primary goal of this project is to serve as a testing playground for Flutter apps. It includes
various types of tests to ensure code quality and functionality.

## Testing

This project includes:

- **Unit tests**
- **Widget tests**
- **BLoC tests**
- **Integration (E2E) tests using Patrol**

## Important Scripts

The project includes several important scripts that must be executed:

- **`prebuild.sh`** and **`fast_prebuild_mac.sh`**: Either of these scripts must be run before
  launching the project.
- **`run_all_tests.sh`** (Unix) and **`run_all_tests.bat`** (Windows): These scripts will run all
  tests in this project.

## Notes

- This project uses **Patrol** for integration tests. You will need to install it to be able to run
  the tests. For installation instructions, visit
  the [Patrol Documentation](https://patrol.leancode.co/documentation).
- The first launch of integration tests may take some time.
- If the necessary tools are not installed, Patrol may hang when calling `gradlew` instead of
  exiting with an error. For more information,
  see [Issue #2364](https://github.com/leancodepl/patrol/issues/2364).
- There may be some issues with running integration tests on Android API 35 due to Patrol issues