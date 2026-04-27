# 纤瘦的小学数学

# 《纤瘦的小学数学》(Lean Elementary Math) 
## 教学方案：从 LeanBlock 到 LeanNatural

本项目旨在通过重新设计 Lean 4 的交互体验，为初学者（尤其是学龄儿童或编程新手）提供一条完美的逻辑启蒙路径。

---

### 1. 语言版本定义

#### **LeanBlock (启蒙版)**
*   **形态**：积木式视觉编程界面（类似于 Scratch/Snap!）。
*   **核心逻辑**：
    *   **策略即积木**：`Induction`、`Rewrite`、`Reflexivity` 被具象化为带插槽的积木块。
    *   **空间可视化**：目标状态（Goal）通过图形化的“逻辑天平”或“嵌套容器”实时呈现。
*   **目标**：消除语法障碍，建立对“逻辑结构”和“递归流转”的直觉。

#### **LeanNatural (进阶版)**
*   **形态**：遵循 **Better Lean** 规范的高级文本代码。
*   **核心准则**：
    *   **全称主义**：严禁使用 `rw`, `rfl`, `ih` 等缩写，必须使用 `rewrite`, `reflexivity`, `induction_hypothesis`。
    *   **显式声明**：顶级定义必须标注输入输出类型。
    *   **叙事结构**：代码缩进和注释模仿数学论文的推导步骤。
*   **目标**：从“玩积木”平滑过渡到“写证明”，培养严谨的数学表达能力。

---

### 2. 课程示例：证明 $0 + n = n$

#### **第一阶段：LeanBlock 操作**
学生在左侧拖动一个【归纳法】大积木块到变量 `n` 上：
1.  在 `[基础情况]` 插槽中放入【自反性】积木。
2.  在 `[递归步骤]` 插槽中，依次放入【根据定义重写】积木和【根据归纳假设重写】积木。
3.  最后放入【确认相等】积木。

#### **第二阶段：LeanNatural 对照**
右侧编辑器实时同步生成以下代码：

```lean
/-- 自定义宏，确保 LeanNatural 的可读性 -/
macro "reflexivity" : tactic => `(tactic| rfl)
macro "simplify" : tactic => `(tactic| simp)

/-- 
证明：对于任何自然数 n，0 + n = n。
这是《纤瘦的小学数学》中的第一个正式定理。
-/
theorem zero_add_natural (n : Nat) : 0 + n = n := by
  -- 对 n 执行归纳操作
  induction n with
  | zero => 
    -- 基础情况：0 + 0 = 0 是定义的自然结果
    reflexivity
  | succ n_minus_one induction_hypothesis => 
    -- 归纳步骤：利用加法的递归定义进行展开
    rewrite [Nat.add_succ]
    -- 应用我们的归纳假设
    rewrite [induction_hypothesis]
    -- 最终逻辑闭合
    reflexivity
```

---

### 3. 核心哲学
> **“先看清骨架 (LeanBlock)，再描绘轮廓 (LeanNatural)，最后赋予灵魂 (Logic)。”**

通过这两个版本的并行协作，我们将原本高不可攀的定理证明器转变为一款“大脑健身器材”，让小学数学重新焕发逻辑的光芒。

LeanBlock LeanNatural