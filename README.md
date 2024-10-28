# Event Booking App

A feature-rich Flutter application for event listing and booking, implementing native API integration with advanced caching and state management.

📱 App Preview
<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/0.png" alt="Home Screen" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/1.png" alt="Event Details" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/2.png" alt="Booking Flow" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/3.png" alt="Payment Screen" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/4.png" alt="Confirmation" width="200"/></td>
    <td><p align="center">📱 Check out the app flow video <a href="https://raw.githubusercontent.com/hurbes/color_extractor/main/screenshots/v1.mp4">here</a>!</p></td>
  </tr>
</table>

## 🎯 Project Context & Challenges

First, I would like to apologize for the delay in submission. Several technical challenges and architectural decisions led to extended development time:

1. **Stripe Integration Challenges**:
   - Native side stripe card creation was removed in the latest SDK
   - Limited customization options with their card form
   - Live mode configuration made testing particularly challenging

2. **API Integration Issues**:
   - Order creation API couldn't be called from Postman
   - Event data filtering documentation gaps (status parameter in query params wasn't working as expected)

3. **Architecture Decisions**:
   - Time invested in building robust caching system
   - Focus on making the codebase extensible and maintainable
   - Implementation of advanced features beyond requirements

Despite these challenges, the final product demonstrates a well-structured, performant, and user-friendly application.

## 🌟 Key Features

- **Native Implementation**: Full native development with complete MVVM architecture and SOLID principles
- **Advanced Caching**: Stream-based local persistent storage with LRU cache
- **Smart Pagination**: Facebook/Instagram-style smooth data loading
- **Offline Support**: Local data persistence for seamless user experience
- **Dynamic Forms**: Flexible attendee information collection system
- **Clean Architecture**: Modular, testable, and maintainable codebase
- **Stripe Integration**: Payment processing implementation (partial)
- **Animations**: Smooth transitions and micro-interactions

## 🏗️ Architecture & Technical Highlights

### Advanced Data Layer Implementation
- **Innovative Caching Solution**:
  - Stream-based local persistent storage with LRU cache
  - Similar to Facebook/Instagram's data loading approach
  - Data always available on app launch
  - Smooth UI transitions without loading states
  - API remains source of truth with parallel background updates

- **Repository Pattern Excellence**:
  - Generic type implementation for easy extension
  - Automated background handling of:
    - Local storage access
    - API calls
    - Cache management
  - Future-ready for Dart macro implementation to reduce boilerplate

### UI Layer
- **MVVM Pattern**: Clear separation of concerns
- **Dynamic Form Generation**: Sophisticated attendee information collection
- **Responsive Design**: Based on provided UI kit with custom enhancements
- **Animation Integration**: Subtle micro-interactions for better UX

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- `.env` file with `STRIPE_PUBLISHABLE_KEY` (extracted from provided web app)

### Installation
1. Clone the repository
2. Create `.env` file in project root
3. Add your Stripe publishable key:
   ```
   STRIPE_PUBLISHABLE_KEY=your_key_here
   ```
4. Run `flutter pub get`
5. Run `flutter run`

## 🧪 Testing Approach

While TDD wasn't fully implemented due to time constraints, significant testing coverage includes:
- Unit tests for core business logic
- Widget tests for UI components
- Integration tests for data flow
- Test coverage focused on critical path functionality

## 🐛 Known Issues & Limitations

1. **Image Persistence**: Images not visible on second launch in home screen (issue identified but pending fix)
2. **Dynamic Form Synchronization**: Attendee form occasionally shows synchronization issues
   - Solution identified: Needs service layer implementation with single callback
   - Current index-based mapping needs refactoring
3. **Event Filtering**: Status-based filtering pending due to API limitations
4. **Stripe Integration**: Limited to SDK invocation due to live server constraints
5. **Test Data Images**: Using default images for clean UI due to inconsistent test data

## 🔄 Future Improvements

1. **Code Generation**:
   - Planning standalone package for data type generation
   - Will reduce boilerplate compared to DTO pattern
   - Awaiting Dart macro launch

2. **Technical Improvements**:
   - Enhanced dynamic form synchronization
   - Optimized image data handling
   - Extended test coverage for local and cache layers
   - Implementation of event filtering by status
   - More efficient image data handling
   - Enhanced testing for local and cache layer duplication

## 🏗️ Technical Decisions

### Why ObjectBox?
- Reduced SQL query complexity
- Better performance for CRUD operations
- Simpler implementation compared to raw SQLite

### LRU Cache Implementation
Benefits:
- Improved app responsiveness
- Reduced API calls
- Better offline experience
- Complex UI updates without loading states

### Architecture Choices
- Repository pattern with generics for extensibility
- Stream-based data flow for reactive updates
- Clear separation between data and presentation layers

## 📋 Requirements Coverage

### Implemented
- ✅ Event listing with pagination
- ✅ Event details view
- ✅ Dynamic attendee form
- ✅ Stripe SDK integration
- ✅ Local data persistence
- ✅ Smooth animations
- ✅ Complex UI with pagination simulation

### Pending/Partial
- ⏳ Event filtering by status (API limitation)
- ⏳ Complete payment flow (Live server constraint)
- ⏳ Order API integration (Post-payment)

## 🛠️ Technical Stack

- Flutter SDK
- ObjectBox
- Stripe SDK
- MVVM Architecture
- Custom caching layer

## 📝 Development Focus

The project prioritizes:
1. Robust Architecture: Focus on clean, maintainable code
2. Future Extensibility: Easy to add new features
3. Performance: Advanced caching and smooth UI
4. User Experience: Offline support and animations
5. Code Quality: SOLID principles and modular design

Despite some implementation challenges and delays, the final product demonstrates advanced architectural patterns and features beyond the initial requirements, creating a solid foundation for future development.