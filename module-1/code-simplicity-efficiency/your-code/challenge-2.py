"""
The code below generates a given number of random strings that consists of numbers and 
lower case English letters. You can also define the range of the variable lengths of
the strings being generated.

The code is functional but has a lot of room for improvement. Use what you have learned
about simple and efficient code, refactor the code.
"""

def RandomStringGenerator(l=12, a=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9']):
    p = 0
    s = ''
    while p<l:
        import random
        s += random.choice(a)
        p += 1
    return s

def BatchStringGenerator(n, a=8, b=12):
    r = []
    for i in range(n):
        c = None
        if a < b:
            import random
            c = random.choice(range(a, b))
        elif a == b:
            c = a
        else:
            import sys
            sys.exit('Incorrect min and max string lengths. Try again.')
        r.append(RandomStringGenerator(c))
    return r

a = input('Enter minimum string length: ')
b = input('Enter maximum string length: ')
n = input('How many random strings to generate? ')

print(BatchStringGenerator(int(n), int(a), int(b)))

#Refactored version

import random
import string

def random_string_generator(length=12, chars=string.ascii_lowercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(length))

def batch_string_generator(num_strings, min_length=8, max_length=12):
    if min_length > max_length:
        raise ValueError('Incorrect min and max string lengths. Min length cannot be greater than max length.')

    return [random_string_generator(random.randint(min_length, max_length)) for _ in range(num_strings)]

def main():
    min_length = int(input('Enter minimum string length: '))
    max_length = int(input('Enter maximum string length: '))
    num_strings = int(input('How many random strings to generate? '))

    strings = batch_string_generator(num_strings, min_length, max_length)
    print(strings)

if __name__ == "__main__":
    main()

