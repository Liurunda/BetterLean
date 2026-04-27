# Better Lean

There are many anti-patterns in the popular lean style, which stops beginners from learning it. This document establishes a set of "Better Lean" conventions to improve readability, maintainability, and pedagogical value.

We must manage the cogitive load for human user and for AI.

```lean
def a := 42 
def my_const:Nat := 42
```

```lean
def double_value (input_number : Nat) : Nat :=
  input_number * 2
```

## 1. Descriptive Naming

### Hypotheses
*   **Anti-pattern**: `h`, `h1`, `h2`, `ha`
*   **Better Lean**: Use `hypothesis` or descriptive names like `hyp_P`, `is_ordered`, `n_pos`.
*   **Why**: Self-documenting code reduces the cognitive load of tracking the InfoView.

### Induction
*   **Anti-pattern**: `ih`, `ih_1`
*   **Better Lean**: Use `induction_hypothesis`.
*   **Why**: Clearly identifies the core mechanism of the inductive step.

### Variables
*   **Anti-pattern**: `x`, `y`, `z`, `i`, `j`
*   **Better Lean**: Use `element`, `index`, `list_tail`, `count`.
*   **Why**: Makes the purpose of the data structure or algorithm clearer.

## 2. Structured Proofs

*   **Explicit Goals**: Use `case` or named goals to make the proof structure visible in the code.
*   **Tactic Comments**: For non-trivial proof steps, add a brief comment explaining the logic.
    ```lean
    -- Split the goal into base case and inductive step
    induction n with
    | zero => 
      -- Base case: 0 is the neutral element
      rfl
    | succ n induction_hypothesis => 
      -- Apply the induction hypothesis after rewriting
      rw [Nat.add_succ, induction_hypothesis]
    ```

## 3. Explicit Types

*   **Function Signatures**: Always specify input and output types for top-level definitions.
*   **Let Bindings**: Consider adding types to `let` bindings if the inferred type is complex.

## 4. Avoiding "Magic" Tactics

*   While `simp` and `aesop` are powerful, in educational contexts or critical proofs, prefer explicit steps (`rw`, `apply`) to show the logic clearly.

---
*Inspired by the philosophy that Lean should be as readable as a well-written mathematical paper.*

