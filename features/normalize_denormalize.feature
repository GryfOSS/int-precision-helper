Feature: Normalize and denormalize value conversion
  In order to work with different value types in a consistent way
  As a developer
  I need to normalize various input types and denormalize back to float

  Background:
    Given I have the IntPrecisionHelper class available

  Scenario Outline: Normalizing different value types
    When I normalize the <type> value <input>
    Then the normalize result should be <expected>

    Examples:
      | type    | input   | expected |
      | float   | 12.34   | 1234     |
      | float   | 0.0     | 0        |
      | float   | -5.67   | -567     |
      | float   | 100.0   | 10000    |
      | string  | "12.34" | 1234     |
      | string  | "0.00"  | 0        |
      | string  | "-5.67" | -567     |
      | string  | "100"   | 10000    |
      | integer | 12      | 1200     |
      | integer | 0       | 0        |
      | integer | -5      | -500     |
      | integer | 100     | 10000    |

  Scenario Outline: Normalizing with less precise mode
    When I normalize the <type> value <input> using less precise mode
    Then the normalize result should be <expected>

    Examples:
      | type   | input   | expected |
      | float  | 12.34   | 1234     |
      | float  | 99.99   | 9999     |
      | string | "12.34" | 1234     |
      | string | "99.99" | 9999     |

  Scenario Outline: Denormalizing normalized integers
    When I denormalize the normalized integer <input>
    Then the denormalize result should be <expected>

    Examples:
      | input | expected |
      | 1234  | 12.34    |
      | 0     | 0.0      |
      | -567  | -5.67    |
      | 100   | 1.0      |
      | 1     | 0.01     |
      | 99    | 0.99     |
      | 10000 | 100.0    |

  Scenario Outline: Round-trip conversion consistency
    When I normalize the <type> value <input>
    And I denormalize the normalized result
    Then the denormalized value should equal the original <expected>

    Examples:
      | type   | input   | expected |
      | float  | 12.34   | 12.34    |
      | float  | 0.0     | 0.0      |
      | float  | -5.67   | -5.67    |
      | float  | 100.0   | 100.0    |
      | string | "12.34" | 12.34    |
      | string | "0.00"  | 0.0      |
      | string | "-5.67" | -5.67    |
      | string | "100"   | 100.0    |

  Scenario Outline: Invalid input types for normalize
    When I attempt to normalize an invalid input type <input>
    Then an InvalidArgumentException should be thrown with message containing "<message_part>"

    Examples:
      | input      | message_part                                  |
      | array      | Input value must be a float, string, or int  |
      | object     | Input value must be a float, string, or int  |
      | boolean    | Input value must be a float, string, or int  |

  Scenario Outline: Invalid string values for normalize
    When I attempt to normalize the string "<input>"
    Then an InvalidArgumentException should be thrown

    Examples:
      | input       |
      | "invalid"   |
      | "1.23e2"    |
      | "abc"       |
      | ""          |
      | "1.2.3"     |

  Scenario Outline: Edge cases for normalize and denormalize
    When I normalize the <type> value <input>
    And I denormalize the normalized result
    Then the round-trip should preserve precision within <tolerance>

    Examples:
      | type   | input     | tolerance |
      | float  | 0.01      | 0.001     |
      | float  | 99.99     | 0.001     |
      | float  | 123.45    | 0.001     |
      | string | "0.01"    | 0.001     |
      | string | "99.99"   | 0.001     |
      | string | "123.45"  | 0.001     |