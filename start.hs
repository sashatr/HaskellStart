module Demo where

-- task 1
mono :: Char -> Char
mono x = x

semiMono :: Char -> a -> Char
semiMono x y = x


-- task 2
sum' :: Integer -> Integer
sum' x = x ^ 2

apply2 f x = f (f x)

flip'' f y x = f x y

-- \x -> 2 * x + 7 lambda f
lenVec = \x y -> sqrt $ x^2 + y^2


-- task 3
p1 = ((1, 2), (3, 4))
p2 = ((3, 4), (5, 6))

sumFstFst = (+) `on` helper
  where helper pp = fst $ fst pp

sumFstFst' = (+) `on` (\pp -> fst $ fst pp)
