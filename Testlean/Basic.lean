def head? (xs: List Nat) : Option Nat :=
  match xs with
  | [] => none
  | x :: _ => some x

 