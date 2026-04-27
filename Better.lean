/-!
# Better Lean: 编写可读、严谨且具备教学价值的 Lean 代码

Lean 社区中存在许多“单字母变量”或“隐式推断”的习惯，
这些习惯对于初学者和 AI 来说都极大地增加了认知负载。
本文件建立了一套 **Better Lean** 规范，
旨在提高代码的可读性、可维护性和教学价值。


“递归数据结构”和“数学归纳法”在范畴论/群论上是等价的，
你总得选一种作为基本假设。
Lean作为一门编程语言，用递归数据结构作为基本假设、
数学归纳法作为演绎出来的结果，更加自然一些。

Lean是一门函数式语言
函数式语言的基本假设是“同一个函数，同一个输入，总得到同一个输出”
函数式语言毫无疑问，必须在某个层面上，借助某个“非函数式语言”的东西，
来获取随机数、日期时间等等天然需要“每次输入得到不一样的结果”的数据。

显然，函数式语言是通过在语言心智模型里牺牲了“时间维度”来处理更复杂的结构。
人脑在普通的编程语言里需要处理时空。
当人脑不需要处理时间的时候，就能多出来一维的大脑算力，来理解更复杂的空间结构。

“结构清晰性”和“时间高效性”是一对trade off,
在编程语言设计、具体的程序设计中都有体现。
-/

/-- 自定义 Better Lean 宏：使用全称代替缩写 -/
macro "reflexivity" : tactic => `(tactic| rfl)
macro "simplify" : tactic => `(tactic| simp)

/-!
---

## 核心原则：管理认知负载 (Managing Cognitive Load)

无论是人类用户还是 AI，都需要明确的上下文来理解代码意图。

### 1. 显式类型声明 (Explicit Types)

**反模式**：依赖隐式类型推断。
**Better Lean**：始终为顶级定义声明输入和输出类型。
-/

/-- ❌ 反模式：缺乏类型信息 -/
def a_bad := 42

/-- ✅ Better Lean：类型清晰，语义明确 -/
def my_const : Nat := 42

/--
计算一个自然数的两倍。
显式标注 `: Nat` 返回值类型有助于 AI 更好地理解函数契约。
-/
def double_value (input_number : Nat) : Nat :=
  input_number * 2

/-!
## 一、 命名规范 (Descriptive Naming)

### 1.1 假设 (Hypotheses)
*   **反模式**: `h`, `h1`, `h2`, `ha`
*   **Better Lean**: 使用 `hypothesis` 或命题描述（如 `hyp_P`, `is_ordered`, `n_pos`）。
*   **理由**: 自解释的命名减少了频繁查看 InfoView 诊断栏的需求。

### 1.2 归纳假设 (Induction)
*   **反模式**: `ih`, `ih_1`
*   **Better Lean**: 使用 `induction_hypothesis`。
*   **理由**: 明确标识出归纳步骤的核心逻辑来源。

### 1.3 变量 (Variables)
*   **反模式**: `x`, `y`, `z`, `i`, `j`
*   **Better Lean**: 使用 `element`, `index`, `list_tail`, `count`。
*   **理由**: 让算法的意图一目了然。

---

## 二、 结构化证明 (Structured Proofs)

*   **明确目标**: 使用 `case` 或命题模式匹配来显式隔离子目标。
*   **策略注释**: 在非平凡的证明步骤前增加简短注释。
-/

-- 反模式：过于简洁的证明，缺乏结构和注释
theorem zero_add_minimal (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl
  | succ n ih => rw [Nat.add_succ, ih]

/-- Better Lean：尽可能展开，更加清晰 -/
theorem zero_add_structured (n : Nat) : 0 + n = n := by
  -- 开启归纳证明，并显式命名归纳假设
  induction n with
  | zero =>
    -- 基础情况：0 + 0 = 0
    reflexivity
  | succ n induction_hypothesis =>
    -- 归纳步骤：利用加法的定义展开并应用假设
    rewrite [Nat.add_succ]
    rewrite [induction_hypothesis]
    reflexivity
/-!
## 三、 显式类型与绑定 (Explicit Bindings)

*   **函数签名**: 顶级定义必须标注类型。
*   **Let 绑定**: 当推断结果复杂时，建议为 `let` 绑定手动标注类型。

## 四、 避免“魔法”策略 (Avoiding "Magic" Tactics)

虽然 `simp` 和 `aesop` 非常强大，但在教学场景或关键证明中，应优先使用显式的 `rw` 和 `apply`，以展示清晰的逻辑链条。

---
*设计哲学：Lean 代码应该像一篇写得非常漂亮的数学论文一样易读。*
-/
