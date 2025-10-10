Feature: Edge cases and precision settings
  In order to handle various edge cases and precision scenarios
  As a developer
  I need comprehensive coverage of boundary conditions

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Very large numbers conversion
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input          | expected    |
      | "999999.99"    | 99999999    |
      | "1000000.00"   | 100000000   |
      | "-999999.99"   | -99999999   |
      | "500000.50"    | 50000050    |
      | "750000.75"    | 75000075    |
      | "123456.78"    | 12345678    |
      | "987654.32"    | 98765432    |
      | "-500000.50"   | -50000050   |
      | "-750000.75"   | -75000075   |
      | "-123456.78"   | -12345678   |
      | "99999.00"     | 9999900     |
      | "100000.01"    | 10000001    |
      | "200000.20"    | 20000020    |
      | "300000.33"    | 30000033    |

  Scenario Outline: Very small decimal places
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input    | expected |
      | "0.001"  | 0        |
      | "0.004"  | 0        |
      | "0.005"  | 1        |
      | "0.009"  | 1        |
      | "0.014"  | 1        |
      | "0.015"  | 2        |
      | "0.002"  | 0        |
      | "0.003"  | 0        |
      | "0.006"  | 1        |
      | "0.007"  | 1        |
      | "0.008"  | 1        |
      | "0.011"  | 1        |
      | "0.012"  | 1        |
      | "0.013"  | 1        |
      | "0.016"  | 2        |
      | "0.017"  | 2        |
      | "0.018"  | 2        |
      | "0.019"  | 2        |

  Scenario Outline: Rounding edge cases in string conversion
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input    | expected |
      | "1.004"  | 100      |
      | "1.005"  | 101      |
      | "1.994"  | 199      |
      | "1.995"  | 200      |
      | "1.999"  | 200      |
      | "2.004"  | 200      |
      | "2.005"  | 201      |
      | "2.994"  | 299      |
      | "2.995"  | 300      |
      | "3.004"  | 300      |
      | "3.005"  | 301      |
      | "4.994"  | 499      |
      | "4.995"  | 500      |
      | "5.004"  | 500      |
      | "5.005"  | 501      |
      | "9.994"  | 999      |
      | "9.995"  | 1000     |
      | "10.004" | 1000     |
      | "10.005" | 1001     |

  Scenario Outline: Scientific notation should throw InvalidArgumentException
    When I attempt to convert the string "<input>" to a normalized integer
    Then an InvalidArgumentException should be thrown with message "<expected_message>"

    Examples:
      | input     | expected_message                                                            |
      | "1.23e2"  | "Scientific notation is not supported. Input value '1.23e2' contains 'e' or 'E'"  |
      | "1.23E2"  | "Scientific notation is not supported. Input value '1.23E2' contains 'e' or 'E'"  |
      | "1.23e1"  | "Scientific notation is not supported. Input value '1.23e1' contains 'e' or 'E'"  |
      | "1.23E1"  | "Scientific notation is not supported. Input value '1.23E1' contains 'e' or 'E'"  |
      | "1.23e0"  | "Scientific notation is not supported. Input value '1.23e0' contains 'e' or 'E'"  |
      | "1.23E0"  | "Scientific notation is not supported. Input value '1.23E0' contains 'e' or 'E'"  |
      | "1.23e-1" | "Scientific notation is not supported. Input value '1.23e-1' contains 'e' or 'E'" |
      | "1.23E-1" | "Scientific notation is not supported. Input value '1.23E-1' contains 'e' or 'E'" |
      | "2.34e2"  | "Scientific notation is not supported. Input value '2.34e2' contains 'e' or 'E'"  |
      | "2.34E2"  | "Scientific notation is not supported. Input value '2.34E2' contains 'e' or 'E'"  |
      | "5.67e-2" | "Scientific notation is not supported. Input value '5.67e-2' contains 'e' or 'E'" |
      | "5.67E-2" | "Scientific notation is not supported. Input value '5.67E-2' contains 'e' or 'E'" |
      | "9.99e3"  | "Scientific notation is not supported. Input value '9.99e3' contains 'e' or 'E'"  |
      | "9.99E3"  | "Scientific notation is not supported. Input value '9.99E3' contains 'e' or 'E'"  |

  Scenario Outline: Leading and trailing zeros
    When I convert the string "<input>" to a normalized integer
    Then the result should be <expected>

    Examples:
      | input      | expected |
      | "001.23"   | 123      |
      | "1.230"    | 123      |
      | "01.230"   | 123      |
      | "000.01"   | 1        |
      | "0001.23"  | 123      |
      | "1.2300"   | 123      |
      | "001.2300" | 123      |
      | "0000.01"  | 1        |
      | "002.34"   | 234      |
      | "2.340"    | 234      |
      | "02.340"   | 234      |
      | "000.02"   | 2        |
      | "003.45"   | 345      |
      | "3.450"    | 345      |
      | "03.450"   | 345      |
      | "000.03"   | 3        |
      | "004.56"   | 456      |
      | "4.560"    | 456      |
      | "04.560"   | 456      |
      | "000.04"   | 4        |

  Scenario Outline: Precision comparison between modes
    When I convert the string "<input>" to a normalized integer
    And I convert the string "<input>" to a normalized integer using less precise mode
    Then both results should be equal for simple cases

    Examples:
      | input   |
      | "1.23"  |
      | "0.99"  |
      | "100.5" |
      | "-1.5"  |
      | "2.34"  |
      | "0.88"  |
      | "200.7" |
      | "-2.6"  |
      | "3.45"  |
      | "0.77"  |
      | "300.8" |
      | "-3.7"  |
      | "4.56"  |
      | "0.66"  |
      | "400.9" |
      | "-4.8"  |

  Scenario: Validation of normalized integer values
    When I validate the value 1234 as a normalized integer
    Then the validation should return true
    When I validate the value "invalid" as a normalized integer
    Then the validation should return false

  Scenario Outline: Converting back to float
    Given I have a normalized integer <normalized>
    When I convert it back to a float
    Then the float result should be <expected>

    Examples:
      | normalized | expected |
      | 0          | 0.0      |
      | 100        | 1.0      |
      | 1234       | 12.34    |
      | -150       | -1.5     |
      | 200        | 2.0      |
      | 500        | 5.0      |
      | 750        | 7.5      |
      | 1000       | 10.0     |
      | 2500       | 25.0     |
      | 3333       | 33.33    |
      | 4567       | 45.67    |
      | -200       | -2.0     |
      | -500       | -5.0     |
      | -750       | -7.5     |
      | -1000      | -10.0    |
      | -2500      | -25.0    |
      | 1          | 0.01     |
      | 5          | 0.05     |
      | 10         | 0.1      |
      | 25         | 0.25     |
      | 50         | 0.5      |
      | 75         | 0.75     |
      | 99         | 0.99     |