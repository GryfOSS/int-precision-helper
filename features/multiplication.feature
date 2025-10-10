Feature: Multiplication operations with normalized integers
  In order to perform accurate multiplication calculations
  As a developer
  I need to multiply normalized integers and get normalized results

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Basic multiplication operations
    When I multiply the normalized integers <first> and <second>
    Then the multiplication result should be <expected>

    Examples:
      | first | second | expected |
      | 100   | 100    | 100      |
      | 200   | 150    | 300      |
      | 1234  | 200    | 2468     |
      | 500   | 250    | 1250     |
      | 100   | 1000   | 1000     |
      | 50    | 400    | 200      |
      | 300   | 200    | 600      |
      | 150   | 400    | 600      |
      | 250   | 300    | 750      |
      | 125   | 800    | 1000     |
      | 75    | 400    | 300      |
      | 350   | 200    | 700      |
      | 425   | 150    | 638      |
      | 175   | 300    | 525      |
      | 225   | 250    | 563      |
      | 325   | 180    | 585      |
      | 450   | 120    | 540      |
      | 375   | 160    | 600      |
      | 275   | 220    | 605      |
      | 625   | 140    | 875      |

  Scenario Outline: Multiplication with negative numbers
    When I multiply the normalized integers <first> and <second>
    Then the multiplication result should be <expected>

    Examples:
      | first | second | expected |
      | -100  | 100    | -100     |
      | 100   | -100   | -100     |
      | -100  | -100   | 100      |
      | -200  | 150    | -300     |
      | -300  | 200    | -600     |
      | 250   | -150   | -375     |
      | -150  | 400    | -600     |
      | 300   | -250   | -750     |
      | -125  | -800   | 1000     |
      | -350  | -200   | 700      |
      | -425  | 150    | -638     |
      | 175   | -300   | -525     |
      | -225  | -250   | 563      |
      | -325  | 180    | -585     |
      | 450   | -120   | -540     |

  Scenario Outline: Multiplication with zero
    When I multiply the normalized integers <first> and <second>
    Then the multiplication result should be <expected>

    Examples:
      | first | second | expected |
      | 0     | 100    | 0        |
      | 100   | 0      | 0        |
      | 0     | 0      | 0        |
      | 0     | -100   | 0        |
      | -100  | 0      | 0        |
      | 0     | 1000   | 0        |
      | 1000  | 0      | 0        |
      | 0     | -1000  | 0        |
      | -1000 | 0      | 0        |
      | 0     | 1      | 0        |
      | 1     | 0      | 0        |
      | 0     | -1     | 0        |
      | -1    | 0      | 0        |

  Scenario Outline: Multiple number multiplication
    When I multiply the normalized integers <first>, <second>, and <third>
    Then the multiplication result should be <expected>

    Examples:
      | first | second | third | expected |
      | 100   | 100    | 100   | 100      |
      | 200   | 150    | 100   | 300      |
      | 100   | 200    | 300   | 600      |
      | 50    | 200    | 400   | 400      |
      | 150   | 100    | 200   | 300      |
      | 125   | 200    | 160   | 400      |
      | 250   | 100    | 120   | 300      |
      | 175   | 150    | 133   | 349      |
      | 300   | 100    | 150   | 450      |
      | 400   | 125    | 100   | 500      |
      | 500   | 100    | 110   | 550      |
      | 225   | 150    | 133   | 449      |
      | 325   | 125    | 123   | 500      |
      | 375   | 120    | 111   | 500      |

  Scenario Outline: Edge case multiplications
    When I multiply the normalized integers <first> and <second>
    Then the multiplication result should be <expected>

    Examples:
      | first | second | expected |
      | 1     | 100    | 1        |
      | 100   | 1      | 1        |
      | 1     | 1      | 0        |
      | 10    | 10     | 1        |
      | 2     | 50     | 1        |
      | 50    | 2      | 1        |
      | 5     | 20     | 1        |
      | 20    | 5      | 1        |
      | 25    | 4      | 1        |
      | 4     | 25     | 1        |
      | 1     | 200    | 2        |
      | 200   | 1      | 2        |
      | 1     | 1000   | 10       |
      | 1000  | 1      | 10       |
      | 3     | 33     | 1        |
      | 33    | 3      | 1        |
      | 7     | 14     | 1        |
      | 14    | 7      | 1        |

  Scenario: Multiplication overflow should throw an exception
    When I attempt to multiply very large normalized integers that would cause overflow
    Then an OverflowException should be thrown with message "Integer overflow detected in multiplication"