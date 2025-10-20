<?php

declare(strict_types=1);

namespace GryfOSS\Formatter;

/**
 * Helper class for handling decimal precision by storing floats as integers.
 * Designed to avoid floating-point precision issues in database storage and calculations.
 *
 * All "normalized" integers represent values multiplied by PRECISION_FACTOR (100).
 * For example: 12.34 is stored as 1234.
 *
 * @package GryfOSS\Formatter
 * @author IDCT Bartosz Pachołek
 */
abstract class IntPrecisionHelper
{
    protected const PRECISION_FACTOR = 100;
    protected const DECIMAL_PLACES = 2;
    protected const BCMATH_SCALE = 10;

    /**
     * Converts from string to normalized int.
     * For example: "12.34" -> 1234
     *
     * @param string $value The string value to convert
     * @param bool $lessPrecise Less precise mode uses float conversion, which may lead to precision loss for very large numbers, but is faster.
     * @return int The normalized integer value
     * @throws InvalidArgumentException If the input string is not a valid number or contains scientific notation
     */
    public static function fromString(string $value, bool $lessPrecise = false): int
    {
        if (!is_numeric($value)) {
            throw new \InvalidArgumentException("Input value '{$value}' is not a valid number");
        }

        // Check for scientific notation (e.g., 1.23e3, 1.23E-2)
        if (preg_match('/[eE]/', $value)) {
            throw new \InvalidArgumentException("Scientific notation is not supported. Input value '{$value}' contains 'e' or 'E'");
        }

        if ($lessPrecise) {
            return intval(round(floatval($value) * static::PRECISION_FACTOR));
        }

        return intval(bcround(bcmul($value, strval(static::PRECISION_FACTOR), static::BCMATH_SCALE), 0));
    }

    /**
     * Converts from float to normalized int.
     * For example: 12.34 -> 1234
     *
     * @param float $value The float value to convert
     * @param bool $lessPrecise Less precise mode uses float conversion, which may lead to precision loss for very large numbers, but is faster.
     * @return int The normalized integer value
     */
    public static function fromFloat(float $value, bool $lessPrecise = false): int
    {
        if ($lessPrecise) {
            return intval(round($value * static::PRECISION_FACTOR));
        }

        return intval(bcround(bcmul(strval($value), strval(static::PRECISION_FACTOR), static::BCMATH_SCALE), 0));
    }

    /**
     * Multiplies normalized integers and returns normalized integer.
     * For example: normMul(1234, 200) -> 2468
     *
     * @param int $a First normalized integer
     * @param int $b Second normalized integer
     * @param int ...$numbers Additional normalized integers to multiply
     * @return int The result as a normalized integer
     * @throws OverflowException If the calculation would cause an integer overflow
     */
    public static function normMul(int $a, int $b, int ...$numbers): int
    {
        // Use BCMath for precise calculation without intermediate rounding
        $result = bcmul((string) $a, (string) $b, 0);

        foreach ($numbers as $number) {
            $result = bcmul($result, (string) $number, 0);
        }

        // Calculate how many times we need to divide by PRECISION_FACTOR
        $divisorCount = 1 + count($numbers); // 1 for initial multiplication + 1 for each additional number
        $divisor = bcpow((string) static::PRECISION_FACTOR, (string) $divisorCount, 0);

        // Perform the division with proper rounding
        $finalResult = bcdiv($result, $divisor, 10); // Use high precision for intermediate calculation
        $rounded = bcround($finalResult, 0);

        // Check for overflow before converting to int
        if (bccomp($rounded, (string) PHP_INT_MAX) > 0 || bccomp($rounded, (string) PHP_INT_MIN) < 0) {
            throw new \OverflowException('Integer overflow detected in multiplication');
        }

        return (int) $rounded;
    }

    /**
     * Divides normalized integers and returns normalized integer.
     * For example: normDiv(1234, 200) -> 617
     *
     * @param int $a Dividend (normalized integer)
     * @param int $b Divisor (normalized integer)
     * @return int The result as a normalized integer
     * @throws DivisionByZeroError If divisor is zero
     */
    public static function normDiv(int $a, int $b): int
    {
        if ($b === 0) {
            throw new \DivisionByZeroError('Division by zero');
        }

        return intval(round(static::PRECISION_FACTOR * $a / $b));
    }

    /**
     * Converts normalized integer to string with specified decimal places.
     * For example: 1234 -> "12.34"
     *
     * @param int $value The normalized integer to convert
     * @param int $decimalPlaces Number of decimal places to display
     * @return string The formatted string representation
     */
    public static function toView(int $value, int $decimalPlaces = self::DECIMAL_PLACES): string
    {
        $result = bcdiv(strval($value), strval(static::PRECISION_FACTOR), max($decimalPlaces, static::DECIMAL_PLACES));
        return bcround($result, $decimalPlaces);
    }

    /**
     * Converts a normalized integer back to a float.
     * For example: 1234 -> 12.34
     *
     * @param int $value The normalized integer
     * @return float The float representation
     */
    public static function toFloat(int $value): float
    {
        return $value / static::PRECISION_FACTOR;
    }

    /**
     * Calculates percentage of count in totalCount.
     * Returns null if totalCount is 0.
     * For example: calculatePercentage(50, 200) -> 2500 (representing 25.00%)
     *
     * @param int $count The count value (not normalized)
     * @param int $totalCount The total count value (not normalized)
     * @return int|null The percentage as a normalized integer, or null if totalCount is 0
     */
    public static function calculatePercentage(int $count, int $totalCount): ?int
    {
        if ($totalCount === 0) {
            return null;
        }

        return self::normDiv(self::normMul(self::fromFloat(100.0), $count), $totalCount);
    }

    /**
     * Adds multiple normalized integers.
     * For example: normAdd(1234, 567, 890) -> 2691
     *
     * @param int ...$values Normalized integers to add
     * @return int The sum as a normalized integer
     */
    public static function normAdd(int ...$values): int
    {
        return array_sum($values);
    }

    /**
     * Subtracts normalized integers.
     * For example: normSub(1234, 567) -> 667
     *
     * @param int $a Minuend (normalized integer)
     * @param int $b Subtrahend (normalized integer)
     * @return int The difference as a normalized integer
     */
    public static function normSub(int $a, int $b): int
    {
        return $a - $b;
    }

    /**
     * Compares two normalized integers.
     *
     * @param int $a First normalized integer
     * @param int $b Second normalized integer
     * @return int Returns -1 if $a < $b, 0 if $a == $b, 1 if $a > $b
     */
    public static function normCompare(int $a, int $b): int
    {
        return $a <=> $b;
    }

    /**
     * Validates that a value is a valid normalized integer.
     *
     * @param mixed $value The value to validate
     * @return bool True if valid normalized integer
     */
    public static function isValid($value): bool
    {
        return is_int($value) && $value >= PHP_INT_MIN && $value <= PHP_INT_MAX;
    }

    /**
     * Normalizes a value (float, string, or int) to the internal integer representation.
     * This is a convenience method that automatically detects the input type.
     * For example: normalize(12.34) -> 1234, normalize("12.34") -> 1234, normalize(12) -> 1200
     *
     * @param float|string|int $value The value to normalize
     * @param bool $lessPrecise Less precise mode uses float conversion, which may lead to precision loss for very large numbers, but is faster.
     * @return int The normalized integer value
     * @throws InvalidArgumentException If the input is not a valid number
     */
    public static function normalize($value, bool $lessPrecise = false): int
    {
        if (is_int($value)) {
            return $value * static::PRECISION_FACTOR;
        }

        if (is_float($value)) {
            return static::fromFloat($value, $lessPrecise);
        }

        if (is_string($value)) {
            return static::fromString($value, $lessPrecise);
        }

        throw new \InvalidArgumentException(sprintf(
            "Input value must be a float, string, or int. Got %s",
            gettype($value)
        ));
    }

    /**
     * Denormalizes a normalized integer back to its decimal representation as a float.
     * For example: denormalize(1234) -> 12.34
     *
     * @param int $normalizedValue The normalized integer value
     * @return float The denormalized float value
     */
    public static function denormalize(int $normalizedValue): float
    {
        return static::toFloat($normalizedValue);
    }
}
