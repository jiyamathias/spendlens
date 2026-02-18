# SpendLens

A premium offline-first personal finance intelligence engine built with Flutter.

## Features

### Plan Mode
- Input planned income with visual allocation
- Create categories with types (fixed, flexible, growth)
- Set priorities (1-5) and scalability flags
- Real-time unallocated balance tracking
- Savings rate warnings (&lt; 20%)

### Income Confirmation
- Actual vs planned income comparison
- Auto-adjustment for income shortfalls
- Priority-based category reduction
- Surplus allocation suggestions

### Live Mode
- Transaction logging with mood tags
- Real-time category balance updates
- Runway calculation (days remaining)
- Usage percentage indicators

### Reflect Mode
- Planned vs actual comparison
- Budget drift analysis per category
- Lifestyle creep detection (&gt;20% increase)
- Volatility index calculation
- Income stability score
- Financial discipline score (0-100)

### Security & Data
- Biometric authentication (Face ID/Touch ID)
- Local CSV export
- Local backup creation
- Offline-first with Isar database

## Architecture

- **Clean Architecture**: Separation of concerns with layers
- **State Management**: Flutter BLoC pattern
- **Database**: Isar (fast, offline-first)
- **UI**: Glassmorphism design with smooth animations

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get