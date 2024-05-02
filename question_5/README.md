# Question 5
## Programming
We ask you to write a program in Python to solve the following problems.
>**__NOTE__**: Please, do not use any external library, just use the Python Standard Library

    Find the minimum number of coins that make a given value
    
    Given a value V, if we want to make change for V cents, and we have an infinite supply of each of C = { C1, C2, .. , Cm} valued coins, what is the minimum number of coins to make the change?

    Examples:
    Input: coins[] = {25, 10, 5}, V = 30
    Output: Minimum 2 coins required
    We can use one coin of 25 cents and one of 5 cents
    Input: coins[] = {9, 6, 5, 1}, V = 11
    Output: Minimum 2 coins required

    We can use one coin of 6 cents and 1 coin of 5 cents
    Write a program that reads V from the standard input and writes to the standard output. We will evaluate the code as intended for production, so, best practices, usage of tests, and code readability, will be taken into account

## Conclusion
Code structure

    - question_5
        ├── arguments.py    <<<<<<<<<< Functions to create some parameters on the run
        ├── run.py          <<<<<<<<<< Main python the will run everything
        ├── script.py       <<<<<<<<<< Actual problem
        └── test.py         <<<<<<<<<< Some testing for the code

To run this code just:

    python3 run.py

There are some arguments that you can pass for this test like this

    python3 run.py --v <desired V value:int> --coins <desired coins:array>

Here is an example

    python3 run.py --v 30 --coins 25,10,5

To run the test just

    python3 test.py