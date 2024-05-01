from script import min_coins

def test_min_coins():
    # Test case 1
    assert min_coins([1], 5) == 5
    # Test case 2
    assert min_coins([1, 2, 5], 11) == 3
    # Test case 3
    assert min_coins([1, 2, -3, 5], 10) == 2 
    # Test case 4
    assert min_coins([], 10) == float('inf')
    # Test case 5
    assert min_coins([-1], 10) == float('inf')
    # Test case 6
    assert min_coins([1, 2, 5], 0) == 0
    print("All test cases passed!")
# Run the test cases
test_min_coins()
