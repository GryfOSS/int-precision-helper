<?php

require_once __DIR__ . '/vendor/autoload.php';

use GryfOSS\Formatter\IntPrecisionHelper;

echo "=== IntPrecisionHelper Test Suite ===\n\n";

// Test basic conversions
echo "1. Basic Conversions:\n";
$stringValue = "12.34";
$floatValue = 12.34;

$fromString = IntPrecisionHelper::fromString($stringValue);
$fromFloat = IntPrecisionHelper::fromFloat($floatValue);

echo "fromString('$stringValue') = $fromString\n";
echo "fromFloat($floatValue) = $fromFloat\n";
echo "toView($fromString) = " . IntPrecisionHelper::toView($fromString) . "\n";
echo "toFloat($fromString) = " . IntPrecisionHelper::toFloat($fromString) . "\n\n";

// Test mathematical operations
echo "2. Mathematical Operations:\n";
$a = 1234; // 12.34
$b = 200;  // 2.00

$mulResult = IntPrecisionHelper::normMul($a, $b);
$divResult = IntPrecisionHelper::normDiv($a, $b);
$addResult = IntPrecisionHelper::normAdd($a, $b);
$subResult = IntPrecisionHelper::normSub($a, $b);

echo "normMul($a, $b) = $mulResult (" . IntPrecisionHelper::toView($mulResult) . ")\n";
echo "normDiv($a, $b) = $divResult (" . IntPrecisionHelper::toView($divResult) . ")\n";
echo "normAdd($a, $b) = $addResult (" . IntPrecisionHelper::toView($addResult) . ")\n";
echo "normSub($a, $b) = $subResult (" . IntPrecisionHelper::toView($subResult) . ")\n\n";

// Test percentage calculation
echo "3. Percentage Calculation:\n";
$percentage = IntPrecisionHelper::calculatePercentage(50, 200);
echo "calculatePercentage(50, 200) = $percentage (" . IntPrecisionHelper::toView($percentage) . "%)\n\n";

// Test comparison
echo "4. Comparison:\n";
$comp1 = IntPrecisionHelper::normCompare($a, $b);
$comp2 = IntPrecisionHelper::normCompare($b, $a);
$comp3 = IntPrecisionHelper::normCompare($a, $a);

echo "normCompare($a, $b) = $comp1\n";
echo "normCompare($b, $a) = $comp2\n";
echo "normCompare($a, $a) = $comp3\n\n";

// Test validation
echo "5. Validation:\n";
echo "isValid(1234) = " . (IntPrecisionHelper::isValid(1234) ? 'true' : 'false') . "\n";
echo "isValid('string') = " . (IntPrecisionHelper::isValid('string') ? 'true' : 'false') . "\n\n";

// Test error handling
echo "6. Error Handling:\n";

try {
    IntPrecisionHelper::fromString("invalid");
} catch (InvalidArgumentException $e) {
    echo "✓ InvalidArgumentException caught: " . $e->getMessage() . "\n";
}

try {
    IntPrecisionHelper::normDiv(1234, 0);
} catch (DivisionByZeroError $e) {
    echo "✓ DivisionByZeroError caught: " . $e->getMessage() . "\n";
}

try {
    IntPrecisionHelper::calculatePercentage(50, 0);
    echo "✓ calculatePercentage(50, 0) returned null safely\n";
} catch (Exception $e) {
    echo "✗ Unexpected error: " . $e->getMessage() . "\n";
}

// Test specific value: "1.368852459" should give 137
echo "7. Specific Test Case:\n";
$testValue = "1.368852459";

// Test with default bcmath scale
bcscale(0);
$result_scale0 = IntPrecisionHelper::fromString($testValue);

// Test with higher bcmath scale
bcscale(10);
$result_scale10 = IntPrecisionHelper::fromString($testValue);

echo "fromString('$testValue') with bcscale(0) = $result_scale0\n";
echo "fromString('$testValue') with bcscale(10) = $result_scale10\n";
echo "Expected: 137\n";
echo "Match (bcscale 0): " . ($result_scale0 === 137 ? "✓ YES" : "✗ NO") . "\n";
echo "Match (bcscale 10): " . ($result_scale10 === 137 ? "✓ YES" : "✗ NO") . "\n\n";

echo "\n=== All tests completed ===\n";