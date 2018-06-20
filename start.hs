module Start where

import Data.Char

-- task #1
lenVec3 x y z = sqrt( x ^ 2 + y ^ 2 + z ^ 2   )

-- task #2
my_if x = if x > 0 then 1 else (-1)

-- task #3
sign x = if x > 0 then 1 else if x == 0 then 0 else (-1)

-- task #4
infixl 6 *+*
(*+*) a b = a ^ 2 + b ^ 2

infixl 6 |-|
(|-|) a b = abs( a - b)

-- task #5
factorial n = if n == 0 then 1 else n * factorial  (n - 1)
