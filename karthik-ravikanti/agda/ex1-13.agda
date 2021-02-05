{--

This isn't really a proof, just an Agda comment so that I can use quail in emacs XD

Given:
------

fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

ϕ = (1 + sqrt 5) / 2

ψ = (1 - sqrt 5) / 2

To Prove:
---------

fib n = (ϕ^n - ψ^n) / sqrt 5

Proof:
------

(ϕ^0 - ψ^0) / sqrt 5
  = 0
  = fib 0

(ϕ^1 - ψ^1) / sqrt 5
  = 1
  = fib 1

(ϕ^2 - ψ^2) / sqrt 5
  = ((1 + 5 + 2 * sqrt 5) / 4 - (1 + 5 - 2 * sqrt 5) / 4) / sqrt 5
  = 1
  = 1 + 0
  = fib 1 + fib 0
  = fib 2

(ϕ^n - ψ^n) / sqrt 5
  = (ϕ^(n - 1) * ϕ - ψ^(n - 1) * ψ) / sqrt 5
  = ((fib (n - 1) * sqrt 5 + ψ^(n - 1)) * ϕ - (ϕ^(n - 1) - fib (n - 1) * sqrt 5) * ψ) / sqrt 5
  = fib (n - 1) * ϕ + ψ^(n - 1) * ϕ / sqrt 5 - ϕ^(n - 1) * ψ / sqrt 5 - fib (n - 1) * ψ
  = fib (n - 1) * (ϕ + ψ) + (ψ^(n - 1) * ϕ - ϕ^(n - 1) * ψ) / sqrt 5
  = fib (n - 1) + (ψ^(n - 2) * ψ * ϕ - ϕ^(n - 2) * ϕ * ψ) / sqrt 5
  = fib (n - 1) + (ψ^(n - 2) * (-1) - ϕ^(n - 2) * (-1)) / sqrt 5
  = fib (n - 1) + (ϕ^(n - 2) - ψ^(n - 2)) / sqrt 5
  = fib (n - 1) + fib (n - 2)
  = fib n

∎

To Prove:
---------  

fib n  = round (ϕ^n / sqrt 5)

⇒

|fib n - ϕ^n / sqrt 5| ≤ 1 / 2


Proof:
------

fib n
  = (ϕ^n - ψ^n) / sqrt 5
  = ϕ^n / sqrt 5 - ψ^n / sqrt 5

⇒

fib n - ϕ^n / sqrt 5
  = - ψ^n / sqrt 5

⇒

|fib n - ϕ^n / sqrt 5|
  = |ψ^n| / sqrt 5
  < 1 / sqrt 5
  < 1 / sqrt 5
  < 1 / 2

∎
--}



