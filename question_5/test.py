from script import min_coins

def test_min_coins():
    # Test case 1
    assert min_coins([1], 5) == 5
    print("Test 1 passed")
    # Test case 2
    assert min_coins([1, 2, 5], 11) == 3
    print("Test 2 passed")
    # Test case 3
    assert min_coins([1, 2, -3, 5], 10) == 2 
    print("Test 3 passed")
    # Test case 4
    assert min_coins([], 10) == float('inf')
    print("Test 4 passed")
    # Test case 5
    assert min_coins([-1], 10) == float('inf')
    print("Test 5 passed")
    # Test case 6
    assert min_coins([1, 2, 5], 0) == 0
    print("Test 6 passed")
    print("All test cases passed!")
# Run the test cases
test_min_coins()
