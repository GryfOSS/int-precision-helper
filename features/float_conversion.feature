Feature: Converting float values to normalized integers
  In order to work with precise decimal calculations
  As a developer
  I need to convert float values to normalized integers

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Converting valid float values to normalized integers
    When I convert the float <input> to a normalized integer
    Then the result should be <expected>

    Examples:
      | input      | expected |
      | 1.23       | 123      |
      | 0.99       | 99       |
      | 12.34      | 1234     |
      | 100.50     | 10050    |
      | 0.01       | 1        |
      | 0.00       | 0        |
      | 999.99     | 99999    |
      | 0.05       | 5        |
      | 50.25      | 5025     |
      | 2.34       | 234      |
      | 3.45       | 345      |
      | 4.56       | 456      |
      | 5.67       | 567      |
      | 6.78       | 678      |
      | 7.89       | 789      |
      | 8.90       | 890      |
      | 9.01       | 901      |
      | 10.12      | 1012     |
      | 11.23      | 1123     |
      | 15.75      | 1575     |
      | 25.50      | 2550     |
      | 33.33      | 3333     |
      | 45.67      | 4567     |
      | 67.89      | 6789     |
      | 87.65      | 8765     |
      | 123.45     | 12345    |
      | 234.56     | 23456    |
      | 345.67     | 34567    |
      | 456.78     | 45678    |
      | 567.89     | 56789    |
      | 678.90     | 67890    |
      | 789.01     | 78901    |

  Scenario Outline: Converting float values with less precise mode
    When I convert the float <input> to a normalized integer using less precise mode
    Then the result should be <expected>

    Examples:
      | input  | expected |
      | 1.23   | 123      |
      | 0.99   | 99       |
      | 12.34  | 1234     |
      | 100.50 | 10050    |
      | 2.34   | 234      |
      | 3.45   | 345      |
      | 4.56   | 456      |
      | 5.67   | 567      |
      | 6.78   | 678      |
      | 7.89   | 789      |
      | 15.75  | 1575     |
      | 25.50  | 2550     |
      | 35.25  | 3525     |
      | 45.75  | 4575     |
      | 55.25  | 5525     |

  Scenario Outline: Converting edge case float values
    When I convert the float <input> to a normalized integer
    Then the result should be <expected>

    Examples:
      | input        | expected   |
      | 999.99       | 99999      |
      | 9999.99      | 999999     |
      | 12345.67     | 1234567    |
      | 123456.78    | 12345678   |
      | 0.001        | 0          |
      | 0.004        | 0          |
      | 0.005        | 1          |
      | 0.009        | 1          |
      | 0.995        | 100        |
      | 1.005        | 101        |
      | 1.995        | 200        |
      | 2.005        | 201        |
      | 9.995        | 1000       |
      | 10.005       | 1001       |
      | 99.995       | 10000      |
      | 100.005      | 10001      |
      | 999.995      | 100000     |
      | 1000.005     | 100001     |
      | 9999.995     | 1000000    |
      | 10000.005    | 1000001    |