# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2025-10-20

### Added
- ✅ **Universal Conversion Methods**: `normalize()` and `denormalize()` for simplified type handling
- ✅ **Auto-Type Detection**: `normalize()` automatically detects and converts float, string, or integer inputs
- ✅ **Enhanced Developer Experience**: Unified API that eliminates need for type-specific method selection
- ✅ **Round-Trip Precision**: Perfect precision preservation in normalize → denormalize operations
- ✅ **Comprehensive Validation**: Enhanced error handling with descriptive messages for invalid types
- ✅ **Feature Tests**: Added 45 new Behat scenarios specifically for normalize/denormalize functionality
- ✅ **Quick Reference Guide**: Added method selection guide and performance recommendations
- ✅ **Extended Documentation**: Comprehensive examples and usage patterns for new methods

### Features
- **`normalize(mixed $value, bool $lessPrecise = false): int`** - Universal input conversion with auto-type detection
- **`denormalize(int $normalizedValue): float`** - Clean float output method
- **Error Handling**: Throws `InvalidArgumentException` for unsupported types (arrays, objects, etc.)
- **Performance Modes**: Support for less precise mode with all input types
- **Type Safety**: Comprehensive input validation with specific error messages

### Technical Improvements
- 🧪 **10 new unit tests** for normalize/denormalize functionality (total: 74 tests)
- 🎯 **45 new feature scenarios** covering all normalize/denormalize use cases (total: 556 scenarios)
- ✅ **100% code coverage maintained** across all new functionality
- 📖 **Enhanced documentation** with comprehensive examples and migration guidance
- 🛡️ **Robust error handling** for edge cases and invalid inputs

### Backward Compatibility
- ✅ **Zero breaking changes** - all existing methods work unchanged
- ✅ **Full API compatibility** with v1.0.x
- ✅ **Migration optional** - new methods complement existing functionality

## [2.0.0] - 2025-10-10

### Added
- ✅ **New Methods**: `normAdd()`, `normSub()`, `normCompare()`, `isValid()`, `toFloat()`
- ✅ **Input Validation**: `fromString()` now validates input and throws `InvalidArgumentException` for invalid numbers
- ✅ **Error Handling**: `normDiv()` now throws `DivisionByZeroError` for division by zero
- ✅ **Overflow Protection**: `normMul()` now detects and throws `OverflowException` for potential integer overflows
- ✅ **Native bcround**: Now uses PHP 8.4+ native `bcround()` function instead of custom implementation
- ✅ **Flexible Precision**: `toView()` now accepts configurable decimal places parameter
- ✅ **Comprehensive Documentation**: Added detailed PHPDoc comments with examples for all methods
- ✅ **Constants**: Added `PRECISION_FACTOR` and `DECIMAL_PLACES` constants for better code clarity

### Changed
- 🔄 **Method Naming**: Renamed `NormMul()` → `normMul()` and `NormDiv()` → `normDiv()` to follow PSR-12 camelCase standards
- 🔄 **Return Types**: `calculatePercentage()` now returns `int|null` instead of `float|null` for consistency
- 🔄 **Better Examples**: Updated all method examples with more realistic values and clearer explanations

### Fixed
- 🐛 **Critical Typo**: Fixed `DIVISIOR` → `PRECISION_FACTOR` (kept `DIVISOR` constant for backward compatibility)
- 🐛 **Logic Issues**: Fixed percentage calculation logic and improved mathematical accuracy

### Removed
- ❌ **Legacy Methods**: Removed `NormMul()` and `NormDiv()` due to PHP's case-insensitive function names conflicting with new methods

### Security
- 🔒 **Input Validation**: All input parameters are now properly validated
- 🔒 **Exception Handling**: Proper exceptions thrown for edge cases (division by zero, overflow, invalid input)

### Migration Guide
- Replace `NormMul()` calls with `normMul()`
- Replace `NormDiv()` calls with `normDiv()`
- Update code expecting `calculatePercentage()` to return float - it now returns int|null
- Consider using new utility methods like `normAdd()`, `normSub()`, `normCompare()` for cleaner code

### Technical Improvements
- Requires PHP 8.4+ for native `bcround()` function
- Added BCMath extension requirement in composer.json
- Improved code documentation and examples
- Added comprehensive test coverage
- Better error messages and exception handling
- Performance optimizations in mathematical operations

## [1.0.0] - Original Release

### Features
- Basic conversion between string/float and normalized integers
- Simple multiplication and division operations
- Percentage calculation functionality
- String representation output