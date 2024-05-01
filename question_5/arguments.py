import argparse

def parse_positive_int(v_str):
    try:
        value = int(v_str)
        if value <= 0:
            raise ValueError("Value must be a positive integer")
        return value
    except ValueError:
        raise argparse.ArgumentTypeError("Invalid value for --v. Please provide a positive integer.")

def parse_coins(coins_str):
    try:
        coins = [int(coin) for coin in coins_str.split(',')]
        return coins
    except ValueError:
        raise argparse.ArgumentTypeError("Invalid coins format. Please provide comma-separated integers.")

def v_input(prompt):
    v_str = input(prompt)
    return parse_positive_int(v_str)

def coins_input(prompt):
    coins_str = input(prompt)
    return parse_coins(coins_str)

def parse_args() -> argparse.Namespace:
    # Receiving the arguments
    parser = argparse.ArgumentParser(description="How to run the code directly from the CLI")
    parser.add_argument("--v", help="Enter the V as a positive number", type = parse_positive_int)
    parser.add_argument("--coins", help="Enter the coins separated by commas:  'C1,C2,..,Cn'", type=parse_coins)

    args = parser.parse_args()

    if args.v is None:
        args.v = v_input("Please enter the V as a positive number: ")
    if args.coins is None:
        args.coins = coins_input("Please enter the coins separated by commas: ")
    
    # Sort the coins so that the code can run smoothly
    args.coins.sort()

    print(args)
    return args
