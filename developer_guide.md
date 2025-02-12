**LLM Developer Guide**

## Table of Contents
1. [Base Prompt & Preferences](#base-prompt--preferences)  
2. [Coding Style Guide](#coding-style-guide)  
3. [Project Goals](#project-goals)  
4. [Testing Guidelines](#testing-guidelines)

---

## Base Prompt & Preferences

### Base Prompt

Application for doing data analysis on Wikipedia articles.

### Code Preferences
  - **Language**: Swift
  - **Package Manager**: SwiftPM
  - **Testing**: XCTest
  - **Documentation**: Google-style docstrings

## Project Architecture
- .aider.tags.cache.v3
- app_journaling
  - app_journaling
  - app_journaling.xcodeproj
  - app_journalingTests
  - app_journalingUITests
- .aider.chat.history.md
- .aider.input.history
- .env
- .gitignore
- architect_prompt.md
- developer_guide.md
- README.md

## Coding Style Guide
- **Formatting**:
  - 4 spaces for indentation
  - 2 blank lines between top-level definitions, 1 between functions
  - Imports: standard library → third-party → local; one import per line
- **Naming**:
  - Variables/Functions: `snake_case`
  - Classes: `PascalCase`
  - Constants: `UPPER_SNAKE_CASE`
  - Private: `_leading_underscore`
- **Documentation**:
  - Use Google-style docstrings
  - Include type hints in docstrings
- **Type Annotations**:
  - Use Python type hints consistently
  - Use Optional[] for nullable fields

### Error Handling
- **Error Handling**:
  - Use consistent error response formats
  - Include error codes and messages
  - Log errors with appropriate severity levels
- **Security**:
  - Validate all inputs
  - Sanitize outputs
  - Use environment variables for sensitive data