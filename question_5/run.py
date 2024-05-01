from arguments import parse_args
from script import min_coins

args = parse_args()

print("--------------------------")
print("running the script with this arguments: {}".format(args))
print("--------------------------")

print("Minimum number of coins needed:", min_coins(args.coins, args.v))