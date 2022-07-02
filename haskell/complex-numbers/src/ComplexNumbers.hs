module ComplexNumbers
  ( Complex,
    conjugate,
    abs,
    exp,
    real,
    imaginary,
    mul,
    add,
    sub,
    div,
    complex,
  )
where

import Prelude hiding (abs, div, exp)
import qualified Prelude as P

-- Data definition -------------------------------------------------------------
data Complex a = Complex a a deriving (Eq, Show)

complex :: (a, a) -> Complex a
complex (a, b) = Complex a b

-- unary operators -------------------------------------------------------------
conjugate :: Num a => Complex a -> Complex a
conjugate (Complex a b) = Complex a (- b)

abs :: Floating a => Complex a -> a
abs (Complex a b) = sqrt (a * a + b * b)

real :: Num a => Complex a -> a
real (Complex a _) = a

imaginary :: Num a => Complex a -> a
imaginary (Complex _ b) = b

exp :: Floating a => Complex a -> Complex a
exp (Complex a b) = Complex (e ** a * cos b) (sin b)
  where
    e = P.exp 1

-- binary operators ------------------------------------------------------------
mul :: Num a => Complex a -> Complex a -> Complex a
mul (Complex a b) (Complex c d) = Complex (a * c - b * d) (b * c + a * d)

add :: Num a => Complex a -> Complex a -> Complex a
add (Complex a b) (Complex c d) = Complex (a + c) (b + d)

sub :: Num a => Complex a -> Complex a -> Complex a
sub (Complex a b) (Complex c d) = Complex (a - c) (b - d)

div :: Fractional a => Complex a -> Complex a -> Complex a
div (Complex a b) (Complex c d) =
  Complex ((a * c + b * d) / (c * c + d * d)) ((b * c - a * d) / (c * c + d * d))
