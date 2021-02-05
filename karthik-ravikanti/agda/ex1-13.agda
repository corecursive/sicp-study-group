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

fib n = (ϕⁿ - ψⁿ) / sqrt 5

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

(ϕⁿ - ψⁿ) / sqrt 5
  = (ϕ⁽ⁿ⁻¹⁾ * ϕ - ψ⁽ⁿ⁻¹⁾ * ψ) / sqrt 5
  = ((fib (n - 1) * sqrt 5 + ψ⁽ⁿ⁻¹⁾) * ϕ - (ϕ⁽ⁿ⁻¹⁾ - fib (n - 1) * sqrt 5) * ψ) / sqrt 5
  = fib (n - 1) * ϕ + ψ⁽ⁿ⁻¹⁾ * ϕ / sqrt 5 - ϕ⁽ⁿ⁻¹⁾ * ψ / sqrt 5 - fib (n - 1) * ψ
  = fib (n - 1) * (ϕ + ψ) + (ψ⁽ⁿ⁻¹⁾ * ϕ - ϕ⁽ⁿ⁻¹⁾ * ψ) / sqrt 5
  = fib (n - 1) + (ψ⁽ⁿ⁻²⁾ * ψ * ϕ - ϕ⁽ⁿ⁻²⁾ * ϕ * ψ) / sqrt 5
  = fib (n - 1) + (ψ⁽ⁿ⁻²⁾ * (-1) - ϕ⁽ⁿ⁻²⁾ * (-1)) / sqrt 5
  = fib (n - 1) + (ϕ⁽ⁿ⁻²⁾ - ψ⁽ⁿ⁻²⁾) / sqrt 5
  = fib (n - 1) + fib (n - 2)
  = fib n

∎

To Prove:
---------  

fib n  = round (ϕⁿ / sqrt 5)

⇒

|fib n - ϕⁿ / sqrt 5| ≤ 1 / 2


Proof:
------

fib n
  = (ϕⁿ - ψⁿ) / sqrt 5
  = ϕⁿ / sqrt 5 - ψⁿ / sqrt 5

⇒

fib n - ϕⁿ / sqrt 5
  = - ψⁿ / sqrt 5

⇒

|fib n - ϕⁿ / sqrt 5|
  = |ψⁿ| / sqrt 5
  < 1 / sqrt 5
  < 1 / sqrt 5
  < 1 / 2

∎
--}
