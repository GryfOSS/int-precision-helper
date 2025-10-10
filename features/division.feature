Feature: Division operations with normalized integers
  In order to perform accurate division calculations
  As a developer
  I need to divide normalized integers and get normalized results

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Basic division operations
    When I divide the normalized integer <dividend> by <divisor>
    Then the division result should be <expected>

    Examples:
      | dividend | divisor | expected |
      | 1000     | 100     | 1000     |
      | 2000     | 200     | 1000     |
      | 1500     | 300     | 500      |
      | 2500     | 500     | 500      |
      | 3000     | 600     | 500      |
      | 4000     | 800     | 500      |
      | 5000     | 1000    | 500      |
      | 1234     | 617     | 200      |
      | 2468     | 1234    | 200      |
      | 3702     | 1851    | 200      |
      | 4936     | 2468    | 200      |
      | 6170     | 3085    | 200      |
      | 7404     | 3702    | 200      |
      | 8638     | 4319    | 200      |
      | 9872     | 4936    | 200      |
      | 1111     | 1111    | 100      |
      | 2222     | 2222    | 100      |
      | 3333     | 3333    | 100      |
      | 4444     | 4444    | 100      |
      | 5555     | 5555    | 100      |

  Scenario Outline: Division with negative numbers
    When I divide the normalized integer <dividend> by <divisor>
    Then the division result should be <expected>

    Examples:
      | dividend | divisor | expected |
      | -1000    | 100     | -1000    |
      | -2000    | 100     | -2000    |
      | -5000    | 250     | -2000    |
      | 1000     | -100    | -1000    |
      | 2000     | -200    | -1000    |
      | 5000     | -250    | -2000    |
      | -1000    | -100    | 1000     |
      | -2000    | -200    | 1000     |
      | -5000    | -250    | 2000     |
      | -1234    | 200     | -617     |
      | -2468    | 400     | -617     |
      | 1234     | -200    | -617     |
      | 2468     | -400    | -617     |
      | -1500    | -300    | 500      |
      | -3000    | -600    | 500      |

  Scenario Outline: Division resulting in fractions
    When I divide the normalized integer <dividend> by <divisor>
    Then the division result should be <expected>

    Examples:
      | dividend | divisor | expected |
      | 100      | 300     | 33       |
      | 200      | 300     | 67       |
      | 300      | 400     | 75       |
      | 500      | 600     | 83       |
      | 700      | 800     | 88       |
      | 150      | 400     | 38       |
      | 250      | 600     | 42       |
      | 350      | 700     | 50       |
      | 450      | 900     | 50       |
      | 125      | 250     | 50       |
      | 175      | 350     | 50       |
      | 225      | 450     | 50       |
      | 375      | 750     | 50       |
      | 425      | 850     | 50       |
      | 333      | 100     | 333      |
      | 167      | 300     | 56       |

  Scenario: Division by zero should throw an exception
    When I attempt to divide the normalized integer 1000 by 0
    Then a DivisionByZeroError should be thrown with message "Division by zero"

  Scenario Outline: Edge case divisions
    When I divide the normalized integer <dividend> by <divisor>
    Then the division result should be <expected>

    Examples:
      | dividend | divisor | expected |
      | 0        | 100     | 0        |
      | 0        | 200     | 0        |
      | 0        | 500     | 0        |
      | 0        | 1000    | 0        |
      | 1        | 100     | 1        |
      | 1        | 200     | 1        |
      | 1        | 500     | 0        |
      | 1        | 1000    | 0        |
      | 99       | 100     | 99       |
      | 199      | 200     | 100      |
      | 499      | 500     | 100      |
      | 999      | 1000    | 100      |
      | 9999     | 100     | 9999     |
      | 9999     | 10000   | 100      |
      | 1        | 1       | 100      |
      | 2        | 2       | 100      |
      | 50       | 50      | 100      |
      | 1000     | 1000    | 100      |