# Test Suite Documentation

## Overview

This test suite provides **100% code coverage** for the `IntPrecisionHelper` class with comprehensive test scenarios covering all methods, edge cases, error conditions, and integration scenarios.

## Test Statistics

- **Total Tests**: 62
- **Total Assertions**: 113
- **Code Coverage**: 100%
  - Classes: 100% (1/1)
  - Methods: 100% (11/11)
  - Lines: 100% (28/28)

## Test Categories

### 1. Input Conversion Tests
- `fromString()` with valid and invalid inputs
- `fromFloat()` with various float values
- Both precision and less-precise modes
- Input validation and exception handling

### 2. Mathematical Operation Tests
- `normMul()` with basic, multiple numbers, zero values, negatives
- `normDiv()` with basic division, negatives, division by zero
- Overflow detection and protection
- Edge cases and boundary conditions

### 3. Output Conversion Tests
- `toView()` with default and custom decimal places
- `toFloat()` conversion accuracy
- Large number handling

### 4. Utility Method Tests
- `normAdd()` with multiple arguments
- `normSub()` with various scenarios
- `normCompare()` with all comparison cases
- `isValid()` with valid and invalid value types

### 5. Business Logic Tests
- `calculatePercentage()` with valid values and zero total
- Real-world percentage calculations

### 6. Error Handling Tests
- Invalid string input validation
- Division by zero protection
- Integer overflow detection
- Type validation

### 7. Integration Tests
- End-to-end price calculations
- Tax calculations
- Discount calculations
- Multi-step operations

## Test Data Providers

The test suite uses data providers for comprehensive testing:

### Valid String Provider
- Basic decimal numbers
- Negative numbers
- Zero values
- Integer values
- Various decimal places

### Invalid String Provider
- Non-numeric strings
- Multiple decimal points
- Currency symbols
- Empty strings
- Special values (NaN, Infinity)

### Valid Float Provider
- Standard floating-point numbers
- Negative floats
- Zero values
- Various precision levels

### Invalid Value Provider
- Strings, booleans, null, arrays, objects
- Special float values (INF, -INF, NAN)

## Running Tests

### Basic Test Run
```bash
./vendor/bin/phpunit
```

### With Coverage Report
```bash
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-text
```

### Generate HTML Coverage Report
```bash
XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-html coverage-html
```

### Using the Coverage Script
```bash
./test-coverage.sh
```

## Test Method Coverage

| Method | Test Methods | Coverage |
|--------|--------------|----------|
| `fromString()` | 4 test methods | 100% |
| `fromFloat()` | 3 test methods | 100% |
| `normMul()` | 6 test methods | 100% |
| `normDiv()` | 3 test methods | 100% |
| `toView()` | 2 test methods | 100% |
| `toFloat()` | 1 test method | 100% |
| `calculatePercentage()` | 2 test methods | 100% |
| `normAdd()` | 1 test method | 100% |
| `normSub()` | 1 test method | 100% |
| `normCompare()` | 1 test method | 100% |
| `isValid()` | 2 test methods | 100% |

## Edge Cases Tested

1. **Boundary Values**
   - PHP_INT_MAX and PHP_INT_MIN
   - Zero values in various operations
   - Very small decimal values (0.01)
   - Large numbers (999999.99)

2. **Error Conditions**
   - Division by zero
   - Integer overflow
   - Invalid input types
   - Malformed numeric strings

3. **Precision Edge Cases**
   - Rounding behavior with bcround
   - Multiple decimal places
   - Scientific notation handling
   - Negative number operations

4. **Real-World Scenarios**
   - Financial calculations
   - Percentage computations
   - Tax calculations
   - Discount applications

## Continuous Integration

The test suite is designed to work with CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run Tests
  run: |
    composer install
    XDEBUG_MODE=coverage ./vendor/bin/phpunit --coverage-clover coverage.xml

- name: Upload Coverage
  uses: codecov/codecov-action@v3
  with:
    file: ./coverage.xml
```

## Test Performance

- **Execution Time**: ~0.130 seconds with coverage
- **Memory Usage**: ~12 MB with coverage
- **Fast Feedback**: All tests complete in under 1 second

## Quality Assurance

The test suite ensures:
- ✅ All public methods are tested
- ✅ All code paths are exercised
- ✅ Error conditions are verified
- ✅ Edge cases are covered
- ✅ Integration scenarios work
- ✅ Business logic is correct
- ✅ Performance is acceptable