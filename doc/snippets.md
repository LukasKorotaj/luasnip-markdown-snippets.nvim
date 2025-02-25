# Luasnip Markdown & TeX Snippets Documentation

This document provides an overview of the snippets available for Markdown files with TeX support. Each snippet entry includes:

- **Name**: The snippet’s name.
- **Trigger**: The key (or regex) that activates the snippet.
- **Type**: Whether it’s a regular snippet or an autosnippet.
- **Description**: A short explanation.
- **Output**: The text (with placeholders) inserted when the snippet is triggered.

---

## 1. Delimiter Snippets

### left right
- **Trigger**: `lr([aAbBcmp])`  
  *(Note: This is a regex trigger.)*
- **Type**: Autosnippet  
- **Description**: Left right delimiters.  
- **Output**:
  ```tex
  \left<> <> \right<><>
  ```
  The placeholders (`<>`) are replaced by dynamic content (e.g. based on the captured bracket type and visual selection).

---

## 2. Superscript Snippets

### sr
- **Trigger**: `sr`
- **Type**: Autosnippet  
- **Description**: Inserts a superscript 2.  
- **Output**:
  ```tex
  ^2
  ```

### cb
- **Trigger**: `cb`
- **Type**: Autosnippet  
- **Description**: Inserts a superscript 3.  
- **Output**:
  ```tex
  ^3
  ```

### compl
- **Trigger**: `compl`
- **Type**: Autosnippet  
- **Description**: Inserts a complement superscript.  
- **Output**:
  ```tex
  ^{c}
  ```

### vtr
- **Trigger**: `vtr`
- **Type**: Autosnippet  
- **Description**: Inserts a transpose superscript.  
- **Output**:
  ```tex
  ^{T}
  ```

### inv
- **Trigger**: `inv`
- **Type**: Autosnippet  
- **Description**: Inserts an inverse superscript.  
- **Output**:
  ```tex
  ^{-1}
  ```

---

## 3. Fraction Snippets

### fraction (general)
- **Trigger**: `//`
- **Type**: Autosnippet  
- **Description**: A general fraction snippet.  
- **Output**:
  ```tex
  \frac{<>}{<>}<>
  ```
  Here, the first two `<>` are for numerator and denominator and the final placeholder for any trailing text.

### fraction (auto fraction 1)
- **Trigger**:  
  ```
  ((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\d+\}|\d))*)\/
  ```
- **Type**: Autosnippet  
- **Description**: Auto-detects a fraction from the captured pattern (auto fraction 1).  
- **Output**:
  ```tex
  \frac{<>}{<>}<>
  ```
  The first placeholder is filled with the captured text from the trigger.

### fraction (auto fraction 2)
- **Trigger**: `(^.*\))\/`
- **Type**: Autosnippet  
- **Description**: Auto-detects a fraction using a different pattern (auto fraction 2).  
- **Output**:  
  The output is generated dynamically by a function (typically inserting a fraction where part of the trigger is used as the numerator).

---

## 4. Limit Snippets

### lim(sup|inf)
- **Trigger**: `lim`
- **Type**: Autosnippet  
- **Description**: Inserts a limit expression with optional “sup” or “inf” variants.  
- **Output**:
  ```tex
  \lim<><><>
  ```
  – The first placeholder lets you choose between nothing, `sup`, or `inf`.  
  – The second lets you optionally add a subscript (e.g. `_{n \to \infty}`).  
  – The final placeholder is for any trailing text.

---

## 5. Summation, Product, and Related Snippets

### summation
- **Trigger**: `sum`
- **Type**: Autosnippet  
- **Description**: Inserts a summation symbol with limits.  
- **Output**:
  ```tex
  \sum<> <>
  ```
  The first placeholder offers a choice to insert limits (defaulting to `_ {i = 0}^{\infty}`) and the second for extra content.

### product
- **Trigger**: `prod`
- **Type**: Autosnippet  
- **Description**: Inserts a product symbol with limits.  
- **Output**:
  ```tex
  \prod<> <>
  ```

### coproduct
- **Trigger**: `cprod`
- **Type**: Autosnippet  
- **Description**: Inserts a coproduct symbol with limits.  
- **Output**:
  ```tex
  \coprod<> <>
  ```

### set
- **Trigger**: `set`
- **Type**: Autosnippet  
- **Description**: Inserts set delimiters, with optional set-builder notation.  
- **Output**:
  ```tex
  \{<>\}<>
  ```

### bigcap
- **Trigger**: `nnn`
- **Type**: Autosnippet  
- **Description**: Inserts a big intersection symbol with limits.  
- **Output**:
  ```tex
  \bigcap<> <>
  ```

### bigcup
- **Trigger**: `uuu`
- **Type**: Autosnippet  
- **Description**: Inserts a big union symbol with limits.  
- **Output**:
  ```tex
  \bigcup<> <>
  ```

### binomial
- **Trigger**: `bnc`
- **Type**: Autosnippet  
- **Description**: Inserts a binomial coefficient (nCR).  
- **Output**:
  ```tex
  \binom{<>}{<>}<>
  ```

### partial derivative
- **Trigger**: `pd`
- **Type**: Autosnippet  
- **Description**: Inserts a partial derivative expression.  
- **Output**:
  ```tex
  \frac{\partial <>}{\partial <>}<>
  ```

---

## 6. Auto Backslash Snippets

These snippets automatically insert a backslash before common TeX functions when in math mode. They cover the following triggers:

- `arcsin`, `sin`, `arccos`, `cos`, `arctan`, `tan`, `cot`, `csc`, `sec`, `log`, `ln`, `exp`, `ast`, `star`, `perp`, `sup`, `inf`, `det`, `max`, `min`, `argmax`, `argmin`, `deg`, `angle`.

Each of these snippets automatically converts the trigger into its corresponding TeX command (e.g. triggering `sin` will insert `\sin`).

---

## 7. Greek Letter Snippets

Each Greek letter snippet inserts the corresponding TeX command. For example:

- **alpha**
  - **Trigger**: `alpha`
  - **Type**: Autosnippet (via a symbol snippet)
  - **Output**:
    ```tex
    \alpha
    ```

- **beta**
  - **Trigger**: `beta`
  - **Output**: `\beta`

- **gam**  
  - **Trigger**: `gam`  
  - **Output**: `\gamma`

- **Gam**  
  - **Trigger**: `Gam`  
  - **Output**: `\Gamma`

- **delta**  
  - **Trigger**: `delta`  
  - **Output**: `\delta`

- **DD**  
  - **Trigger**: `DD`  
  - **Output**: `\Delta`

- **eps**  
  - **Trigger**: `eps`  
  - **Output**: `\epsilon`

- **veps**  
  - **Trigger**: `veps`  
  - **Output**: `\varepsilon`

- **zeta**  
  - **Trigger**: `zeta`  
  - **Output**: `\zeta`

- **eta**  
  - **Trigger**: `eta`  
  - **Output**: `\eta`

- **theta**  
  - **Trigger**: `theta`  
  - **Output**: `\theta`

- **Theta**  
  - **Trigger**: `Theta`  
  - **Output**: `\Theta`

- **iota**  
  - **Trigger**: `iota`  
  - **Output**: `\iota`

- **kappa**  
  - **Trigger**: `kappa`  
  - **Output**: `\kappa`

- **lmbd**  
  - **Trigger**: `lmbd`  
  - **Output**: `\lambda`

- **Lmbd**  
  - **Trigger**: `Lmbd`  
  - **Output**: `\Lambda`

- **mu**  
  - **Trigger**: `mu`  
  - **Output**: `\mu`

- **nu**  
  - **Trigger**: `nu`  
  - **Output**: `\nu`

- **xi**  
  - **Trigger**: `xi`  
  - **Output**: `\xi`

- **pi**  
  - **Trigger**: `pi`  
  - **Output**: `\pi`

- **rho**  
  - **Trigger**: `rho`  
  - **Output**: `\rho`

- **sig**  
  - **Trigger**: `sig`  
  - **Output**: `\sigma`

- **Sig**  
  - **Trigger**: `Sig`  
  - **Output**: `\Sigma`

- **tau**  
  - **Trigger**: `tau`  
  - **Output**: `\tau`

- **ups**  
  - **Trigger**: `ups`  
  - **Output**: `\upsilon`

- **phi**  
  - **Trigger**: `phi`  
  - **Output**: `\phi`

- **vphi**  
  - **Trigger**: `vphi`  
  - **Output**: `\varphi`

- **chi**  
  - **Trigger**: `chi`  
  - **Output**: `\chi`

- **psi**  
  - **Trigger**: `psi`  
  - **Output**: `\psi`

- **omega**  
  - **Trigger**: `omega`  
  - **Output**: `\omega`

- **Omega**  
  - **Trigger**: `Omega`  
  - **Output**: `\Omega`

---

## 8. Symbol/Command Snippets

These snippets insert various mathematical symbols:

- **!=**
  - **Trigger**: `!=`
  - **Output**:
    ```tex
    \neq
    ```

- **<=**
  - **Trigger**: `<=`
  - **Output**: `\leq`

- **>=**
  - **Trigger**: `>=`
  - **Output**: `\geq`

- **<<**
  - **Trigger**: `<<`
  - **Output**: `\ll`

- **>>**
  - **Trigger**: `>>`
  - **Output**: `\gg`

- **~~**
  - **Trigger**: `~~`
  - **Output**: `\sim`

- **~=**
  - **Trigger**: `~=`
  - **Output**: `\approx`

- **~-**
  - **Trigger**: `~-`
  - **Output**: `\simeq`

- **-~**
  - **Trigger**: `-~`
  - **Output**: `\backsimeq`

- **-=**
  - **Trigger**: `-=`
  - **Output**: `\equiv`

- **=~**
  - **Trigger**: `=~`
  - **Output**: `\cong`

- **:=**
  - **Trigger**: `:=`
  - **Output**: `\coloneqq`

- **\*\***
  - **Trigger**: `**`
  - **Output**: `\cdot`

- **xx**
  - **Trigger**: `xx`
  - **Output**: `\times`

- **!+**
  - **Trigger**: `!+`
  - **Output**: `\oplus`

- **!***
  - **Trigger**: `!*`
  - **Output**: `\otimes`

- **NN**
  - **Trigger**: `NN`
  - **Output**: `\mathbb{N}`

- **ZZ**
  - **Trigger**: `ZZ`
  - **Output**: `\mathbb{Z}`

- **QQ**
  - **Trigger**: `QQ`
  - **Output**: `\mathbb{Q}`

- **RR**
  - **Trigger**: `RR`
  - **Output**: `\mathbb{R}`

- **CC**
  - **Trigger**: `CC`
  - **Output**: `\mathbb{C}`

- **OO**
  - **Trigger**: `OO`
  - **Output**: `\emptyset`

- **pwr**
  - **Trigger**: `pwr`
  - **Output**: `\powerset`

- **cc**
  - **Trigger**: `cc`
  - **Output**: `\subset`

- **cq**
  - **Trigger**: `cq`
  - **Output**: `\subseteq`

- **qq**
  - **Trigger**: `qq`
  - **Output**: `\supset`

- **qc**
  - **Trigger**: `qc`
  - **Output**: `\supseteq`

- **\\\ (triple backslash)**
  - **Trigger**: `\\\\\`
  - **Output**: `\setminus`

- **Nn**
  - **Trigger**: `Nn`
  - **Output**: `\cap`

- **UU**
  - **Trigger**: `UU`
  - **Output**: `\cup`

- **::**
  - **Trigger**: `::`
  - **Output**: `\colon`

- **AA**
  - **Trigger**: `AA`
  - **Output**: `\forall`

- **EE**
  - **Trigger**: `EE`
  - **Output**: `\exists`

- **inn**
  - **Trigger**: `inn`
  - **Output**: `\in`

- **notin**
  - **Trigger**: `notin`
  - **Output**: `\not\in`

- **!-**
  - **Trigger**: `!-`
  - **Output**: `\lnot`

- **VV**
  - **Trigger**: `VV`
  - **Output**: `\lor`

- **WW**
  - **Trigger**: `WW`
  - **Output**: `\land`

- **!W**
  - **Trigger**: `!W`
  - **Output**: `\bigwedge`

- **=>**
  - **Trigger**: `=>`
  - **Output**: `\implies`

- **=<**
  - **Trigger**: `=<`
  - **Output**: `\impliedby`

- **iff**
  - **Trigger**: `iff`
  - **Output**: `\iff`

- **->**
  - **Trigger**: `->`
  - **Output**: `\to`

- **!>**
  - **Trigger**: `!>`
  - **Output**: `\mapsto`

- **<-**
  - **Trigger**: `<-`
  - **Output**: `\gets`

- **dp**
  - **Trigger**: `dp`
  - **Output**: `\partial`

- **-->**
  - **Trigger**: `-->`
  - **Output**: `\longrightarrow`

- **<->**
  - **Trigger**: `<->`
  - **Output**: `\leftrightarrow`

- **2>**
  - **Trigger**: `2>`
  - **Output**: `\rightrightarrows`

- **upar**
  - **Trigger**: `upar`
  - **Output**: `\uparrow`

- **dnar**
  - **Trigger**: `dnar`
  - **Output**: `\downarrow`

- **ooo**
  - **Trigger**: `ooo`
  - **Output**: `\infty`

- **lll**
  - **Trigger**: `lll`
  - **Output**: `\ell`

- **dag**
  - **Trigger**: `dag`
  - **Output**: `\dagger`

- **+-**
  - **Trigger**: `+-`
  - **Output**: `\pm`

- **-+**
  - **Trigger**: `-+`
  - **Output**: `\mp`

---

## 9. Single Command Math Snippets

These snippets insert a single TeX command (often wrapping an argument).

### tt
- **Trigger**: `tt`
- **Type**: Autosnippet  
- **Description**: Inserts text in math mode.
- **Output**:
  ```tex
  \text
  ```

### sbf
- **Trigger**: `sbf`
- **Type**: Autosnippet  
- **Description**: Inserts bold math text.
- **Output**:
  ```tex
  \symbf
  ```

### syi
- **Trigger**: `syi`
- **Type**: Autosnippet  
- **Description**: Inserts italic math text.
- **Output**:
  ```tex
  \symit
  ```

### udd
- **Trigger**: `udd`
- **Type**: Autosnippet  
- **Description**: Inserts underlined text in math mode.
- **Output**:
  ```tex
  \underline
  ```

### conj
- **Trigger**: `conj`
- **Type**: Autosnippet  
- **Description**: Inserts a conjugate (overline).
- **Output**:
  ```tex
  \overline
  ```

### __
- **Trigger**: `__`
- **Type**: Autosnippet  
- **Description**: Auto subscript.
- **Output**:
  ```tex
  _
  ```

### td
- **Trigger**: `td`
- **Type**: Autosnippet  
- **Description**: Auto superscript (alternative).
- **Output**:
  ```tex
  ^
  ```

### sbt
- **Trigger**: `sbt`
- **Type**: Autosnippet  
- **Description**: Inserts a substack for sums/products.
- **Output**:
  ```tex
  \substack
  ```

### sq
- **Trigger**: `sq`
- **Type**: Autosnippet  
- **Description**: Inserts a square root.
- **Output**:
  ```tex
  \sqrt
  ```

### bxd
- **Trigger**: `bxd`
- **Type**: Autosnippet  
- **Description**: Inserts a boxed expression.
- **Output**:
  ```tex
  \boxed
  ```

---

## 10. Postfix Math Snippets

These snippets wrap an existing expression with a command.

### mbb
- **Trigger**: `mbb`
- **Type**: Autosnippet  
- **Description**: Wraps text in a math blackboard bold:  
- **Output**:  
  ```tex
  \mathbb{ ... }
  ```

### mcal
- **Trigger**: `mcal`
- **Type**: Autosnippet  
- **Description**: Wraps text in math calligraphic.
- **Output**:
  ```tex
  \mathcal{ ... }
  ```

### mscr
- **Trigger**: `mscr`
- **Type**: Autosnippet  
- **Description**: Wraps text in math script.
- **Output**:
  ```tex
  \mathscr{ ... }
  ```

### mfr
- **Trigger**: `mfr`
- **Type**: Autosnippet  
- **Description**: Wraps text in mathfrak.
- **Output**:
  ```tex
  \mathfrak{ ... }
  ```

### hat
- **Trigger**: `hat`
- **Type**: Autosnippet  
- **Description**: Wraps text with a hat accent.
- **Output**:
  ```tex
  \hat{ ... }
  ```

### bar
- **Trigger**: `bar`
- **Type**: Autosnippet  
- **Description**: Wraps text with an overline.
- **Output**:
  ```tex
  \overline{ ... }
  ```

### tld
- **Trigger**: `tld`
- **Type**: Autosnippet  
- **Description**: Wraps text with a tilde.
- **Output**:
  ```tex
  \tilde{ ... }
  ```

---

## 11. Math Environment Snippets

These snippets provide common math environments.

### Inline Math
- **Name**: `$..$`
- **Trigger**: `mk`
- **Type**: Snippet  
- **Description**: Inserts inline math delimiters.
- **Output**:
  ```tex
  $<>$<>
  ```
  (The first placeholder is for the math content and the second for any trailing text.)

### Display Math
- **Name**: `$$..$$`
- **Trigger**: `dm`
- **Type**: Snippet  
- **Description**: Inserts display math delimiters.
- **Output**:
  ```tex
  $$
  <>
  $$
  <>
  ```

### Align Math
- **Name**: `align(|*|ed)`
- **Trigger**: `ali`
- **Type**: Snippet  
- **Description**: Inserts an align environment with optional starred or “ed” variants.
- **Output**:
  ```tex
  \begin{align<>}
  <>
  .\end{align<>}
  ```
  The first placeholder is a choice (e.g. `*`, empty, or `ed`), the second for the content, and then repeats the choice.

### &= Align
- **Name**: `&= align`
- **Trigger**: `==`
- **Type**: Snippet  
- **Description**: Inserts a line with an alignment symbol.
- **Output**:
  ```tex
  &<> <> \\
  ```
  (The first placeholder allows choosing between `=`, `\leq`, or a custom value.)

### Gather Math
- **Name**: `gather(|*|ed)`
- **Trigger**: `gat`
- **Type**: Snippet  
- **Description**: Inserts a gather environment.
- **Output**:
  ```tex
  \begin{gather<>}
  <>
  .\end{gather<>}
  ```

### Equation Math
- **Name**: `equation(|*)`
- **Trigger**: `eqn`
- **Type**: Snippet  
- **Description**: Inserts an equation environment.
- **Output**:
  ```tex
  \begin{equation<>}
  <>
  .\end{equation<>}
  ```

### Matrix Snippet
- **Name**: `[bBpvV]matrix`
- **Trigger**: `([bBpvV])mat(%d+)x(%d+)([ar])`  
  *(Regex trigger for different matrix types.)*
- **Type**: Snippet  
- **Description**: Inserts a matrix environment.  
- **Output**:
  ```tex
  \begin{<matrix type>}<optional column spec>
  <>
  \end{<matrix type>}
  ```
  The matrix type is constructed from the capture (e.g. `bmatrix`, `pmatrix`, etc.) and the column alignment may be added if specified.

### Cases
- **Name**: `cases`
- **Trigger**: `(%d?)cases`  
  *(Regex trigger allowing an optional number to specify rows.)*
- **Type**: Autosnippet  
- **Description**: Inserts a cases environment.
- **Output**:
  ```tex
  \begin{cases}
  <>
  .\end{cases}
  ```
  The dynamic node generates a table-like structure for the cases.
