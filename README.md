# IntPrecisionHelper

A PHP library for handling decimal precision by storing floating-point numbers as integers, designed to avoid floating-point precision issues in database storage and calculations.

## Installation

```bash
composer require gryfoss/int-precision-helper
```

## Purpose

This library solves common floating-point precision issues by storing decimal numbers as integers. For example:
- `12.34` is stored as `1234` (multiplied by 100)
- All calculations are performed on integers
- Results are converted back to decimal representation when needed

This approach is particularly useful for financial calculations, percentages, and any scenario where precision is critical.

## Key Features

- ✅ **Fixed Typo**: `DIVISIOR` → `PRECISION_FACTOR` (with backward compatibility)
- ✅ **Input Validation**: Throws exceptions for invalid inputs
- ✅ **Overflow Protection**: Detects potential integer overflows
- ✅ **Division by Zero Protection**: Throws appropriate exceptions
- ✅ **Comprehensive Documentation**: Full PHPDoc with examples
- ✅ **Additional Utility Methods**: Add, subtract, compare, validate
- ✅ **Flexible Precision**: Configurable decimal places in output
- ✅ **Native bcround**: Uses PHP 8.4+ native `bcround()` function for precision
- ✅ **100% Test Coverage**: Comprehensive test suite with 62 tests

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

### Advanced Features

```php
// Input validation
try {
    $result = IntPrecisionHelper::fromString("invalid");
} catch (InvalidArgumentException $e) {
    // Handle invalid input
}

// Division by zero protection
try {
    $result = IntPrecisionHelper::normDiv(1234, 0);
} catch (DivisionByZeroError $e) {
    // Handle division by zero
}

// Overflow protection
try {
    $result = IntPrecisionHelper::normMul(PHP_INT_MAX, PHP_INT_MAX);
} catch (OverflowException $e) {
    // Handle overflow
}

// Percentage calculation
$percentage = IntPrecisionHelper::calculatePercentage(50, 200); // 2500 (25.00%)

// Comparison
$comparison = IntPrecisionHelper::normCompare(1234, 567); // 1 (first is greater)

// Validation
$isValid = IntPrecisionHelper::isValid(1234); // true
```

## Breaking Changes from Original

⚠️ **Important**: The legacy `NormMul` and `NormDiv` methods have been removed due to PHP's case-insensitive function names conflicting with the new `normMul` and `normDiv` methods.

**Migration Guide:**
- `NormMul()` → `normMul()`
- `NormDiv()` → `normDiv()`
- `calculatePercentage()` now returns `int|null` instead of `float|null`

## Configuration

The precision factor can be customized by extending the class:

```php
class CustomPrecisionHelper extends IntPrecisionHelper
{
    protected const PRECISION_FACTOR = 1000; // 3 decimal places
    protected const DECIMAL_PLACES = 3;
}
```

## Performance Modes

For performance-critical applications, you can use the `$lessPrecise` mode:

```php
// Faster but potentially less precise for very large numbers
$result = IntPrecisionHelper::fromString("12.34", true);
$result = IntPrecisionHelper::fromFloat(12.34, true);
```

## Requirements

- PHP 8.4+
- BCMath extension

## Testing

This library includes a comprehensive test suite with **100% code coverage**:

```bash
# Run tests
./vendor/bin/phpunit

# Run tests with coverage report
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-text

# Generate HTML coverage report
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-html coverage-html

# Use the provided coverage script
./test-coverage.sh
```

**Test Statistics:**
- 62 test cases
- 113 assertions
- 100% code coverage (classes, methods, and lines)
- All edge cases and error conditions covered

See [TESTING.md](TESTING.md) for detailed test documentation.

## Contributing

Please ensure all changes include:
- Proper PHPDoc documentation
- Unit tests
- Backward compatibility considerations
- Performance impact assessment

## License

MIT License

TODO: 1,368852459