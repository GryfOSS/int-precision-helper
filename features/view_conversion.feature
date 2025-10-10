Feature: Conversion to view format
  In order to display normalized integers as human-readable strings
  As a developer
  I need to convert normalized integers to formatted strings

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Converting normalized integers to view format with default precision
    When I convert the normalized integer <input> to view format
    Then the view result should be "<expected>"

    Examples:
      | input  | expected |
      | 0      | 0.00     |
      | 100    | 1.00     |
      | 1234   | 12.34    |
      | 150    | 1.50     |
      | 1      | 0.01     |
      | 99     | 0.99     |
      | 10050  | 100.50   |
      | -150   | -1.50    |
      | -1234  | -12.34   |
      | 200    | 2.00     |
      | 500    | 5.00     |
      | 750    | 7.50     |
      | 1000   | 10.00    |
      | 2500   | 25.00    |
      | 3333   | 33.33    |
      | 4567   | 45.67    |
      | 6789   | 67.89    |
      | 9876   | 98.76    |
      | 12345  | 123.45   |
      | -200   | -2.00    |
      | -500   | -5.00    |
      | -750   | -7.50    |
      | -1000  | -10.00   |
      | -2500  | -25.00   |

  Scenario Outline: Converting normalized integers to view format with custom precision
    When I convert the normalized integer <input> to view format with <precision> decimal places
    Then the view result should be "<expected>"

    Examples:
      | input | precision | expected |
      | 1234  | 0         | 12       |
      | 1234  | 1         | 12.3     |
      | 1234  | 2         | 12.34    |
      | 1234  | 3         | 12.340   |
      | 1234  | 4         | 12.3400  |
      | 1250  | 1         | 12.5     |
      | 1250  | 0         | 13       |
      | 2345  | 0         | 23       |
      | 2345  | 1         | 23.5     |
      | 2345  | 2         | 23.45    |
      | 2345  | 3         | 23.450   |
      | 3456  | 0         | 35       |
      | 3456  | 1         | 34.6     |
      | 3456  | 2         | 34.56    |
      | 4567  | 0         | 46       |
      | 4567  | 1         | 45.7     |
      | 5678  | 0         | 57       |
      | 5678  | 1         | 56.8     |
      | 6789  | 0         | 68       |
      | 6789  | 1         | 67.9     |

  Scenario Outline: Converting edge case values to view format
    When I convert the normalized integer <input> to view format
    Then the view result should be "<expected>"

    Examples:
      | input    | expected   |
      | 99999    | 999.99     |
      | 1        | 0.01       |
      | 5        | 0.05       |
      | 12345678 | 123456.78  |
      | -99999   | -999.99    |
      | 10       | 0.10       |
      | 20       | 0.20       |
      | 30       | 0.30       |
      | 40       | 0.40       |
      | 50       | 0.50       |
      | 60       | 0.60       |
      | 70       | 0.70       |
      | 80       | 0.80       |
      | 90       | 0.90       |
      | 11       | 0.11       |
      | 22       | 0.22       |
      | 33       | 0.33       |
      | 44       | 0.44       |
      | 55       | 0.55       |
      | 999      | 9.99       |
      | 9999     | 99.99      |

  Scenario Outline: Converting small values to view format with different precisions
    When I convert the normalized integer <input> to view format with <precision> decimal places
    Then the view result should be "<expected>"

    Examples:
      | input | precision | expected |
      | 1     | 0         | 0        |
      | 1     | 1         | 0.0      |
      | 1     | 2         | 0.01     |
      | 1     | 3         | 0.010    |
      | 5     | 1         | 0.1      |
      | 50    | 1         | 0.5      |
      | 2     | 0         | 0        |
      | 2     | 1         | 0.0      |
      | 2     | 2         | 0.02     |
      | 3     | 2         | 0.03     |
      | 4     | 2         | 0.04     |
      | 6     | 2         | 0.06     |
      | 7     | 2         | 0.07     |
      | 8     | 2         | 0.08     |
      | 9     | 2         | 0.09     |
      | 10    | 1         | 0.1      |
      | 20    | 1         | 0.2      |
      | 30    | 1         | 0.3      |
      | 25    | 1         | 0.3      |
      | 75    | 1         | 0.8      |