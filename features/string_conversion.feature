Feature: String conversion to normalized integers
  In order to handle decimal precision accurately
  As a developer
  I need to convert string values to normalized integers

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Converting valid string values to normalized integers
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input      | expected |
      | "0"        | 0        |
      | "0.0"      | 0        |
      | "0.00"     | 0        |
      | "1"        | 100      |
      | "1."       | 100      |
      | "1.0"      | 100      |
      | "1.00"     | 100      |
      | "1.5"      | 150      |
      | "2.5"      | 250      |
      | "3.75"     | 375      |
      | "12.34"    | 1234     |
      | "56.78"    | 5678     |
      | "0.01"     | 1        |
      | "0.02"     | 2        |
      | "0.05"     | 5        |
      | "0.10"     | 10       |
      | "0.25"     | 25       |
      | "0.50"     | 50       |
      | "0.75"     | 75       |
      | "0.99"     | 99       |
      | "100.50"   | 10050    |
      | "200.25"   | 20025    |
      | "500.00"   | 50000    |
      | "1000.99"  | 100099   |
      | "-0.01"    | -1       |
      | "-1"       | -100     |
      | "-1.5"     | -150     |
      | "-12.34"   | -1234    |
      | "-100.50"  | -10050   |
      | "-999.99"  | -99999   |

  Scenario Outline: Converting valid string values with less precise mode
    When I convert the string "<input>" to a normalized integer using less precise mode
    Then the result should be <expected>

    Examples:
      | input     | expected |
      | "0"       | 0        |
      | "0.0"     | 0        |
      | "1"       | 100      |
      | "1.0"     | 100      |
      | "2.5"     | 250      |
      | "12.34"   | 1234     |
      | "56.78"   | 5678     |
      | "100.50"  | 10050    |
      | "0.01"    | 1        |
      | "0.99"    | 99       |
      | "-1"      | -100     |
      | "-1.5"    | -150     |
      | "-12.34"  | -1234    |
      | "-100.99" | -10099   |

  Scenario Outline: Converting invalid string values should throw exceptions
    When I attempt to convert the invalid string "<input>" to a normalized integer
    Then an InvalidArgumentException should be thrown

    Examples:
      | input       |
      | "abc"       |
      | "12.34a"    |
      | "a12.34"    |
      | "12a.34"    |
      | ""          |
      | " "         |
      | "  "        |
      | "1.2.3"     |
      | "1..2"      |
      | ".."        |
      | ".1."       |
      | "12.34.56"  |
      | "null"      |
      | "undefined" |
      | "NaN"       |
      | "Infinity"  |
      | "-"         |
      | "+"         |
      | "--1"       |
      | "++1"       |
      | "1.2.3.4"   |

  Scenario Outline: Converting string values with high precision
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input         | expected    |
      | "999.99"      | 99999       |
      | "1000.00"     | 100000      |
      | "9999.99"     | 999999      |
      | "10000.00"    | 1000000     |
      | "0.001"       | 0           |
      | "0.004"       | 0           |
      | "0.005"       | 1           |
      | "0.009"       | 1           |
      | "0.014"       | 1           |
      | "0.015"       | 2           |
      | "0.019"       | 2           |
      | "0.024"       | 2           |
      | "0.025"       | 3           |
      | "123456.78"   | 12345678    |
      | "987654.32"   | 98765432    |
      | "1234567.89"  | 123456789   |
      | "-999999.99"  | -99999999   |
      | "-1000000.00" | -100000000  |