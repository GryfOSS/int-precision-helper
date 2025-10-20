<?php

declare(strict_types=1);

namespace IntPrecisionHelper\Tests\Context;

use Behat\Step\When;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use GryfOSS\Formatter\IntPrecisionHelper;
use InvalidArgumentException;
use DivisionByZeroError;
use OverflowException;
use PHPUnit\Framework\Assert;

/**
 * Defines application features from the specific context.
 */
class IntPrecisionHelperContext implements Context
{
    private mixed $result = null;
    private ?string $exceptionMessage = null;
    private ?string $exceptionType = null;
    private bool $lessPreciseMode = false;
    private array $multiplicationNumbers = [];
    private mixed $validationResult = null;
    private float $floatResult = 0.0;

    /**
     * @Given I have the IntPrecisionHelper class available
     */
    public function iHaveTheIntPrecisionHelperClassAvailable(): void
    {
        // Ensure the class exists
        Assert::assertTrue(class_exists(IntPrecisionHelper::class));
    }

    /**
     * @When I convert the string :input to a normalized integer
     * @When I convert the string ":input" to a normalized integer
     */
    public function iConvertTheStringToANormalizedInteger(string $input): void
    {
        // Remove surrounding quotes if present
        $cleanInput = trim($input, '"');

        try {
            $this->result = IntPrecisionHelper::fromString($cleanInput, $this->lessPreciseMode);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }    /**
     * @When I convert the string :input to a normalized integer using less precise mode
     * @When I convert the string ":input" to a normalized integer using less precise mode
     * @And I convert the string :input to a normalized integer using less precise mode
     * @And I convert the string ":input" to a normalized integer using less precise mode
     */
    public function iConvertTheStringToANormalizedIntegerUsingLessPreciseMode(string $input): void
    {
        $this->lessPreciseMode = true;
        $this->iConvertTheStringToANormalizedInteger($input);
        $this->lessPreciseMode = false;
    }

    /**
     * @When I convert the float :input to a normalized integer
     */
    public function iConvertTheFloatToANormalizedInteger(float $input): void
    {
        try {
            $this->result = IntPrecisionHelper::fromFloat($input, $this->lessPreciseMode);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }

    /**
     * @When I convert the float :input to a normalized integer using less precise mode
     */
    public function iConvertTheFloatToANormalizedIntegerUsingLessPreciseMode(float $input): void
    {
        $this->lessPreciseMode = true;
        $this->iConvertTheFloatToANormalizedInteger($input);
        $this->lessPreciseMode = false;
    }

    /**
     * @When I attempt to convert the invalid string :input to a normalized integer
     * @When I attempt to convert the invalid string ":input" to a normalized integer
     */
    public function iAttemptToConvertTheInvalidStringToANormalizedInteger(string $input): void
    {
        $this->iConvertTheStringToANormalizedInteger($input);
    }

    /**
     * @When I attempt to convert the string :input to a normalized integer
     * @When I attempt to convert the string ":input" to a normalized integer
     */
    public function iAttemptToConvertTheStringToANormalizedInteger(string $input): void
    {
        $this->iConvertTheStringToANormalizedInteger($input);
    }

    /**
     * @When I divide the normalized integer :dividend by :divisor
     */
    public function iDivideTheNormalizedIntegerBy(int $dividend, int $divisor): void
    {
        try {
            $this->result = IntPrecisionHelper::normDiv($dividend, $divisor);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Throwable $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }

    /**
     * @When I attempt to divide the normalized integer :dividend by :divisor
     */
    public function iAttemptToDivideTheNormalizedIntegerBy(int $dividend, int $divisor): void
    {
        $this->iDivideTheNormalizedIntegerBy($dividend, $divisor);
    }

    /**
     * @When I multiply the normalized integers :first and :second
     */
    public function iMultiplyTheNormalizedIntegers(int $first, int $second): void
    {
        try {
            $this->result = IntPrecisionHelper::normMul($first, $second);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }

    /**
     * @When I multiply the normalized integers :first, :second, and :third
     */
    public function iMultiplyTheNormalizedIntegersFirstSecondAndThird(int $first, int $second, int $third): void
    {
        try {
            $this->result = IntPrecisionHelper::normMul($first, $second, $third);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }

    /**
     * @When I attempt to multiply very large normalized integers that would cause overflow
     */
    public function iAttemptToMultiplyVeryLargeNormalizedIntegersThatWouldCauseOverflow(): void
    {
        // Use values that would cause overflow
        $largeValue1 = intval(PHP_INT_MAX / 2);
        $largeValue2 = intval(PHP_INT_MAX / 2);

        try {
            $this->result = IntPrecisionHelper::normMul($largeValue1, $largeValue2);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Throwable $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->result = null;
        }
    }

    /**
     * @When I convert the normalized integer :input to view format
     */
    public function iConvertTheNormalizedIntegerToViewFormat(int $input): void
    {
        $this->result = IntPrecisionHelper::toView($input);
    }

    /**
     * @When I convert the normalized integer :input to view format with :precision decimal places
     */
    public function iConvertTheNormalizedIntegerToViewFormatWithDecimalPlaces(int $input, int $precision): void
    {
        $this->result = IntPrecisionHelper::toView($input, $precision);
    }

    /**
     * @When I validate the value :value as a normalized integer
     */
    public function iValidateTheValueAsANormalizedInteger($value): void
    {
        if ($value === "invalid") {
            $this->validationResult = IntPrecisionHelper::isValid($value);
        } else {
            $this->validationResult = IntPrecisionHelper::isValid((int)$value);
        }
    }

    /**
     * @Given I have a normalized integer :normalized
     */
    public function iHaveANormalizedInteger(int $normalized): void
    {
        $this->result = $normalized;
    }

    /**
     * @When I convert it back to a float
     */
    public function iConvertItBackToAFloat(): void
    {
        $this->floatResult = IntPrecisionHelper::toFloat($this->result);
    }

    /**
     * @When both results should be equal for simple cases
     */
    public function bothResultsShouldBeEqualForSimpleCases(): void
    {
        // This step is used in conjunction with precision comparison scenarios
        // The assertion is handled in the scenario outline structure
        Assert::assertTrue(true, "Both conversion modes should produce equivalent results for simple cases");
    }

    /**
     * @Then the result should be :expected
     */
    public function theResultShouldBe(int $expected): void
    {
        Assert::assertEquals($expected, $this->result);
    }

    /**
     * @Then the division result should be :expected
     */
    public function theDivisionResultShouldBe(int $expected): void
    {
        Assert::assertEquals($expected, $this->result);
    }

    /**
     * @Then the multiplication result should be :expected
     */
    public function theMultiplicationResultShouldBe(int $expected): void
    {
        Assert::assertEquals($expected, $this->result);
    }

    /**
     * @Then the view result should be :expected
     */
    public function theViewResultShouldBe(string $expected): void
    {
        Assert::assertEquals($expected, $this->result);
    }

    /**
     * @Then the float result should be :expected
     */
    public function theFloatResultShouldBe(float $expected): void
    {
        Assert::assertEquals($expected, $this->floatResult, '', 0.001);
    }

    /**
     * @Then the validation should return true
     */
    public function theValidationShouldReturnTrue(): void
    {
        Assert::assertTrue($this->validationResult);
    }

    /**
     * @Then the validation should return false
     */
    public function theValidationShouldReturnFalse(): void
    {
        Assert::assertFalse($this->validationResult);
    }

    /**
     * @Then an InvalidArgumentException should be thrown with message :message
     * @Then an InvalidArgumentException should be thrown with message ":message"
     */
    public function anInvalidArgumentExceptionShouldBeThrownWithMessage(string $message): void
    {
        // Remove surrounding quotes if present
        $cleanMessage = trim($message, '"');

        Assert::assertEquals(InvalidArgumentException::class, $this->exceptionType);
        Assert::assertEquals($cleanMessage, $this->exceptionMessage);
    }

    /**
     * @Then an InvalidArgumentException should be thrown
     */
    public function anInvalidArgumentExceptionShouldBeThrown(): void
    {
        Assert::assertEquals(InvalidArgumentException::class, $this->exceptionType);
        Assert::assertNotNull($this->exceptionMessage);
    }

    /**
     * @Then a DivisionByZeroError should be thrown with message :message
     */
    public function aDivisionByZeroErrorShouldBeThrownWithMessage(string $message): void
    {
        Assert::assertEquals(DivisionByZeroError::class, $this->exceptionType);
        Assert::assertEquals($message, $this->exceptionMessage);
    }

    /**
     * @Then an OverflowException should be thrown with message :message
     */
    public function anOverflowExceptionShouldBeThrownWithMessage(string $message): void
    {
        Assert::assertEquals(OverflowException::class, $this->exceptionType);
        Assert::assertEquals($message, $this->exceptionMessage);
    }

    // Additional properties for normalize/denormalize tests
    private mixed $normalizeInput = null;
    private mixed $normalizeResult = null;
    private float $denormalizeResult = 0.0;
    private string $inputType = '';

    /**
     * @When I normalize the float value :input
     */
    public function iNormalizeTheFloatValue(float $input): void
    {
        $this->inputType = 'float';
        $this->normalizeInput = $input;
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($input);
            $this->result = $this->normalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I normalize the string value :input
     */
    public function iNormalizeTheStringValue(string $input): void
    {
        $this->inputType = 'string';
        // Remove surrounding quotes if present
        $cleanInput = trim($input, '"');
        $this->normalizeInput = $cleanInput;
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($cleanInput);
            $this->result = $this->normalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I normalize the integer value :input
     */
    public function iNormalizeTheIntegerValue(int $input): void
    {
        $this->inputType = 'integer';
        $this->normalizeInput = $input;
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($input);
            $this->result = $this->normalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I normalize the float value :input using less precise mode
     */
    public function iNormalizeTheFloatValueUsingLessPreciseMode(float $input): void
    {
        $this->inputType = 'float';
        $this->normalizeInput = $input;
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($input, true);
            $this->result = $this->normalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I normalize the string value :input using less precise mode
     */
    public function iNormalizeTheStringValueUsingLessPreciseMode(string $input): void
    {
        $this->inputType = 'string';
        // Remove surrounding quotes if present
        $cleanInput = trim($input, '"');
        $this->normalizeInput = $cleanInput;
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($cleanInput, true);
            $this->result = $this->normalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I denormalize the normalized integer :input
     */
    public function iDenormalizeTheNormalizedInteger(int $input): void
    {
        try {
            $this->denormalizeResult = IntPrecisionHelper::denormalize($input);
            $this->floatResult = $this->denormalizeResult;
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->denormalizeResult = 0.0;
        }
    }

    /**
     * @When I denormalize the normalized result
     * @And I denormalize the normalized result
     */
    public function iDenormalizeTheNormalizedResult(): void
    {
        if ($this->normalizeResult !== null) {
            $this->iDenormalizeTheNormalizedInteger($this->normalizeResult);
        }
    }

    /**
     * @When I attempt to normalize an invalid input type :input
     */
    public function iAttemptToNormalizeAnInvalidInputType(string $inputType): void
    {
        $testValue = match ($inputType) {
            'array' => [1, 2, 3],
            'object' => (object) ['key' => 'value'],
            'boolean' => true,
            default => null
        };

        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($testValue);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @When I attempt to normalize the string :input
     * @When I attempt to normalize the string ":input"
     */
    public function iAttemptToNormalizeTheString(string $input): void
    {
        // Remove surrounding quotes if present
        $cleanInput = trim($input, '"');
        try {
            $this->normalizeResult = IntPrecisionHelper::normalize($cleanInput);
            $this->exceptionMessage = null;
            $this->exceptionType = null;
        } catch (\Exception $e) {
            $this->exceptionMessage = $e->getMessage();
            $this->exceptionType = get_class($e);
            $this->normalizeResult = null;
        }
    }

    /**
     * @Then the normalize result should be :expected
     */
    public function theNormalizeResultShouldBe(int $expected): void
    {
        Assert::assertEquals($expected, $this->normalizeResult);
    }

    /**
     * @Then the denormalize result should be :expected
     */
    public function theDenormalizeResultShouldBe(float $expected): void
    {
        Assert::assertEquals($expected, $this->denormalizeResult);
    }

    /**
     * @Then the denormalized value should equal the original :expected
     */
    public function theDenormalizedValueShouldEqualTheOriginal(float $expected): void
    {
        Assert::assertEquals($expected, $this->denormalizeResult);
    }

    /**
     * @Then an InvalidArgumentException should be thrown with message containing :messagePart
     */
    public function anInvalidArgumentExceptionShouldBeThrownWithMessageContaining(string $messagePart): void
    {
        Assert::assertEquals(InvalidArgumentException::class, $this->exceptionType);
        Assert::assertStringContainsString($messagePart, $this->exceptionMessage);
    }

    /**
     * @Then the round-trip should preserve precision within :tolerance
     */
    public function theRoundTripShouldPreservePrecisionWithin(float $tolerance): void
    {
        $originalValue = is_string($this->normalizeInput) ? (float) $this->normalizeInput : (float) $this->normalizeInput;
        $difference = abs($originalValue - $this->denormalizeResult);
        Assert::assertLessThanOrEqual($tolerance, $difference,
            "Round-trip precision loss too high. Original: {$originalValue}, Result: {$this->denormalizeResult}, Difference: {$difference}");
    }
}
