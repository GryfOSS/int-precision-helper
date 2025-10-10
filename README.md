# IntPrecisionHelper

[![Tests](https://github.com/GryfOSS/int-precision-helper/workflows/Tests/badge.svg)](https://github.com/GryfOSS/int-precision-helper/actions)
[![PHP Version](https://img.shields.io/badge/PHP-8.4%2B-blue.svg)](https://www.php.net/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage](https://img.shields.io/badge/Coverage-100%25-brightgreen.svg)](#testing)

A robust PHP library for handling decimal precision by storing floating-point numbers as integers, designed to eliminate floating-point precision issues in database storage and financial calculations.

## Installation

```bash
composer require gryfoss/int-precision-helper
```

## Purpose

This library solves common floating-point precision issues by storing decimal numbers as integers. For example:
- `12.34` is stored as `1234` (multiplied by 100)
- All calculations are performed on integers to maintain precision
- Results are converted back to decimal representation when needed

This approach is particularly useful for:
- **Financial calculations** - Ensuring precise monetary computations
- **Percentage calculations** - Accurate rate and ratio calculations  
- **Database storage** - Consistent decimal representation across systems
- **Scientific calculations** - Where precision is critical

## Why PHP 8.4+ is Required

This library requires **PHP 8.4 or higher** because it utilizes PHP's native `bcround()` function, which was introduced in PHP 8.4. The `bcround()` function provides:
- **High-precision rounding** for decimal calculations
- **Consistent behavior** across different platforms
- **Performance optimization** over custom rounding implementations
- **BCMath integration** for seamless mathematical operations

## Core Functionality

### Input Conversion Methods

#### `fromString(string $value, bool $lessPrecise = false): int`
Converts a string representation of a decimal number to a normalized integer.

**Parameters:**
- `$value` - String representation of a decimal number (e.g., "12.34", "0.05")
- `$lessPrecise` - Optional performance mode for large numbers

**Example:**
```php
$normalized = IntPrecisionHelper::fromString("12.34"); // Returns: 1234
$normalized = IntPrecisionHelper::fromString("0.05");  // Returns: 5
```

**Validation:** Throws `InvalidArgumentException` for invalid input formats.

#### `fromFloat(float $value, bool $lessPrecise = false): int`
Converts a float to a normalized integer representation.

**Parameters:**
- `$value` - Float value to convert
- `$lessPrecise` - Optional performance mode

**Example:**
```php
$normalized = IntPrecisionHelper::fromFloat(12.34); // Returns: 1234
$normalized = IntPrecisionHelper::fromFloat(0.99);  // Returns: 99
```

### Output Conversion Methods

#### `toView(int $value, int $decimalPlaces = 2): string`
Converts a normalized integer back to a human-readable string representation.

**Parameters:**
- `$value` - Normalized integer value
- `decimalPlaces` - Number of decimal places to display (default: 2)

**Example:**
```php
$display = IntPrecisionHelper::toView(1234);    // Returns: "12.34"
$display = IntPrecisionHelper::toView(1234, 3); // Returns: "1.234"
```

#### `toFloat(int $value): float`
Converts a normalized integer back to a float representation.

**Example:**
```php
$float = IntPrecisionHelper::toFloat(1234); // Returns: 12.34
```

### Mathematical Operations

#### `normMul(int ...$numbers): int`
Performs multiplication on normalized integers while maintaining precision.

**Example:**
```php
// 12.34 * 2.00 = 24.68
$result = IntPrecisionHelper::normMul(1234, 200); // Returns: 2468

// Multiple values: 12.34 * 2.00 * 1.50
$result = IntPrecisionHelper::normMul(1234, 200, 150); // Returns: 3702
```

**Protection:** Throws `OverflowException` if result would exceed PHP_INT_MAX.

#### `normDiv(int $dividend, int $divisor): int`
Performs division on normalized integers with precision preservation.

**Example:**
```php
// 12.34 / 2.00 = 6.17
$result = IntPrecisionHelper::normDiv(1234, 200); // Returns: 617
```

**Protection:** Throws `DivisionByZeroError` if divisor is zero.

#### `normAdd(int ...$numbers): int`
Adds multiple normalized integers.

**Example:**
```php
// 12.34 + 5.67 + 8.90 = 26.91
$result = IntPrecisionHelper::normAdd(1234, 567, 890); // Returns: 2691
```

#### `normSub(int $minuend, int $subtrahend): int`
Subtracts two normalized integers.

**Example:**
```php
// 12.34 - 5.67 = 6.67
$result = IntPrecisionHelper::normSub(1234, 567); // Returns: 667
```

### Utility Methods

#### `calculatePercentage(int $value, int $total): ?int`
Calculates percentage as a normalized integer.

**Example:**
```php
// 50 out of 200 = 25.00%
$percentage = IntPrecisionHelper::calculatePercentage(50, 200); // Returns: 2500
$display = IntPrecisionHelper::toView($percentage); // Returns: "25.00"
```

#### `normCompare(int $a, int $b): int`
Compares two normalized integers.

**Returns:**
- `-1` if `$a < $b`
- `0` if `$a == $b`  
- `1` if `$a > $b`

**Example:**
```php
$comparison = IntPrecisionHelper::normCompare(1234, 567); // Returns: 1
```

#### `isValid(mixed $value): bool`
Validates if a value is a valid normalized integer.

**Example:**
```php
$isValid = IntPrecisionHelper::isValid(1234);    // Returns: true
$isValid = IntPrecisionHelper::isValid("1234");  // Returns: false
$isValid = IntPrecisionHelper::isValid(12.34);   // Returns: false
```

## Usage Examples

### Basic Conversions

```php
use GryfOSS\Formatter\IntPrecisionHelper;

// String to normalized integer
$normalized = IntPrecisionHelper::fromString("12.34"); // 1234

// Float to normalized integer
$normalized = IntPrecisionHelper::fromFloat(12.34); // 1234

// Back to string representation
$display = IntPrecisionHelper::toView(1234); // "12.34"

// Back to float
$float = IntPrecisionHelper::toFloat(1234); // 12.34
```

### Mathematical Operations

```php
// Multiplication: 12.34 * 2.00 = 24.68
$result = IntPrecisionHelper::normMul(1234, 200); // 2468

// Division: 12.34 / 2.00 = 6.17
$result = IntPrecisionHelper::normDiv(1234, 200); // 617

// Addition
$result = IntPrecisionHelper::normAdd(1234, 567, 890); // 2691

// Subtraction
$result = IntPrecisionHelper::normSub(1234, 567); // 667
```

## Advanced Features & Error Handling

### Input Validation
The library provides comprehensive input validation with descriptive error messages:

```php
try {
    $result = IntPrecisionHelper::fromString("invalid");
} catch (InvalidArgumentException $e) {
    echo "Invalid input format: " . $e->getMessage();
}

try {
    $result = IntPrecisionHelper::fromString(""); // Empty string
} catch (InvalidArgumentException $e) {
    echo "Input cannot be empty";
}
```

### Division by Zero Protection
All division operations are protected against division by zero:

```php
try {
    $result = IntPrecisionHelper::normDiv(1234, 0);
} catch (DivisionByZeroError $e) {
    echo "Cannot divide by zero";
}

try {
    $percentage = IntPrecisionHelper::calculatePercentage(50, 0);
} catch (DivisionByZeroError $e) {
    echo "Total cannot be zero for percentage calculation";
}
```

### Overflow Protection
The library detects and prevents integer overflow conditions:

```php
try {
    $result = IntPrecisionHelper::normMul(PHP_INT_MAX, PHP_INT_MAX);
} catch (OverflowException $e) {
    echo "Result would exceed maximum integer value";
}
```

### Performance Modes
For performance-critical applications with very large numbers:

```php
// Standard precision (recommended for most use cases)
$result = IntPrecisionHelper::fromString("12.34");

// Less precise but faster for very large numbers
$result = IntPrecisionHelper::fromString("12.34", true);
$result = IntPrecisionHelper::fromFloat(12.34, true);
```

## Breaking Changes from Original

⚠️ **Important**: The legacy `NormMul` and `NormDiv` methods have been removed due to PHP's case-insensitive function names conflicting with the new `normMul` and `normDiv` methods.

**Migration Guide:**
- `NormMul()` → `normMul()`
- `NormDiv()` → `normDiv()`
- `calculatePercentage()` now returns `int|null` instead of `float|null`

## Configuration & Customization

### Custom Precision Factor
You can customize the precision factor by extending the class:

```php
class CustomPrecisionHelper extends IntPrecisionHelper
{
    protected const PRECISION_FACTOR = 1000; // 3 decimal places instead of 2
    protected const DECIMAL_PLACES = 3;
}

// Usage
$normalized = CustomPrecisionHelper::fromString("12.345"); // Returns: 12345
$display = CustomPrecisionHelper::toView(12345);           // Returns: "12.345"
```

### Available Constants
- `PRECISION_FACTOR` - Multiplier for decimal conversion (default: 100)
- `DECIMAL_PLACES` - Default decimal places for output (default: 2)

## Requirements

- **PHP 8.4+** - Required for native `bcround()` function support
- **BCMath extension** - Essential for high-precision mathematical operations
- **64-bit system** - Recommended for handling larger integer values

## Testing & Quality Assurance

This library maintains **100% code coverage** and follows rigorous testing standards to ensure reliability and precision.

### Test Coverage Statistics
- 📊 **100% Code Coverage** - Every line of code is tested
- 🧪 **62 Test Cases** - Comprehensive unit test suite
- ✅ **113 Assertions** - Detailed validation of all functionality
- 🎯 **Edge Case Coverage** - All error conditions and boundary cases tested
- 🚀 **Continuous Integration** - Automated testing on every commit

### Running Tests Locally

#### Unit Tests with Coverage
```bash
# Run complete test suite with coverage report
./vendor/bin/phpunit

# Generate detailed HTML coverage report
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-html coverage-html

# Use the provided coverage script
./test-coverage.sh
```

#### Feature Tests (Behavioral Testing)
```bash
# Run Behat feature tests
./vendor/bin/behat

# Run with detailed output
./vendor/bin/behat --format=pretty
```

#### Quick Test Coverage Check
```bash
# Fast coverage validation
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-text
```

### Test Categories

#### Unit Tests (`tests/IntPrecisionHelperTest.php`)
- ✅ **Conversion Methods** - String/float to integer and back
- ✅ **Mathematical Operations** - Multiplication, division, addition, subtraction
- ✅ **Error Handling** - Invalid inputs, overflow, division by zero
- ✅ **Edge Cases** - Boundary values, special numbers, large integers
- ✅ **Utility Functions** - Comparison, validation, percentage calculations

#### Feature Tests (`features/`)
- ✅ **Division Operations** - Comprehensive division scenarios
- ✅ **Edge Cases** - Boundary conditions and error states
- ✅ **Float Conversion** - Float input/output validation
- ✅ **Multiplication** - Complex multiplication scenarios
- ✅ **String Conversion** - String parsing and formatting
- ✅ **View Conversion** - Display formatting and precision

### Continuous Integration

The project uses GitHub Actions for automated testing:
- **Automated Test Execution** - Runs on every push and pull request
- **Coverage Validation** - Ensures 100% coverage is maintained
- **Multi-environment Testing** - Tests across different PHP configurations
- **Quality Gates** - Prevents merging code that breaks tests or reduces coverage

## Contributing

We welcome contributions from the community! Whether you're fixing bugs, adding features, improving documentation, or reporting issues, your help makes this library better for everyone.

### How to Contribute

#### 🐛 Reporting Issues
Found a bug or have a feature request? Please [open an issue](https://github.com/GryfOSS/int-precision-helper/issues) with:
- **Clear description** of the problem or feature request
- **Steps to reproduce** (for bugs)
- **Expected vs actual behavior**
- **PHP version** and system information
- **Code examples** demonstrating the issue

#### 🔧 Pull Requests
Ready to contribute code? We'd love your help! Please:

1. **Fork the repository** and create a feature branch
2. **Write tests** for any new functionality
3. **Ensure 100% coverage** is maintained
4. **Follow PSR-12** coding standards
5. **Update documentation** as needed
6. **Submit a pull request** with a clear description

#### 📋 Contribution Checklist
Before submitting a pull request, ensure:
- [ ] All tests pass: `./vendor/bin/phpunit`
- [ ] Feature tests pass: `./vendor/bin/behat`
- [ ] 100% code coverage maintained
- [ ] Code follows PSR-12 standards
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated (for notable changes)

#### 🎯 Areas for Contribution
We especially welcome contributions in these areas:
- **Performance optimizations** for large number operations
- **Additional mathematical operations** (modulo, power, etc.)
- **Documentation improvements** and examples
- **Bug fixes** and edge case handling
- **Platform compatibility** testing

#### 💡 Feature Requests
Have an idea for a new feature? We'd love to hear it! Consider:
- **Mathematical operations** that would benefit from precision handling
- **Integration helpers** for popular frameworks
- **Performance improvements** for specific use cases
- **Developer experience** enhancements

### Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/int-precision-helper.git
cd int-precision-helper

# Install dependencies
composer install

# Run tests to ensure everything works
./vendor/bin/phpunit
./vendor/bin/behat
```

### Code of Conduct

Please note that this project follows a **Code of Conduct**. By participating, you agree to:
- Be respectful and inclusive
- Focus on constructive feedback
- Help create a welcoming environment for all contributors

## Getting Help

Need help getting started or have questions?
- 📖 Check the [documentation](README.md) and [TESTING.md](TESTING.md)
- 🐛 Search [existing issues](https://github.com/GryfOSS/int-precision-helper/issues)
- 💬 Open a [new issue](https://github.com/GryfOSS/int-precision-helper/issues/new) for questions
- 📧 Contact the maintainers for complex queries

**Thank you for contributing to IntPrecisionHelper!** 🚀

## License

MIT License