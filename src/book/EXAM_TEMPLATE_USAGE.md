# 试卷模板使用说明

这个项目里的试卷源码整体非常统一，可以按下面的规则继续新增。

## 1. 文件组织

- 根文件是 `main.tex`，负责按 `\part` 分类汇总所有试卷。
- 每一份试卷都放在 `files/` 目录下，单独一个 `.tex` 文件。
- 每一份试卷文件都使用 `subfiles`，开头固定为：

```tex
\documentclass[../Main.tex]{subfiles}
\begin{document}
```

## 2. 一份试卷的固定骨架

每份试卷基本都是两大章：

1. 题面章节：`\chapter{...考试}`
2. 答案章节：`\chapter{...考试参考答案}`

题面和答案章节中的 `\section{...}` 名称、顺序、分值说明通常保持一致。

## 3. 题号编号约定

项目里普遍要求题号在不同题型之间连续编号，因此第二个及之后的 `enumerate` 都会手动接续编号，例如：

```tex
\section{综合题(每小题 6 分，共 30 分)}
\begin{enumerate}
  \setcounter{enumi}{10}
  \item ...
\end{enumerate}
```

常见续号方式：

- 10 道基础题后，综合题从 11 开始：`\setcounter{enumi}{10}`
- 期末卷填空题一般从 7 开始：`\setcounter{enumi}{6}`
- 期末卷计算题一般从 11 开始：`\setcounter{enumi}{10}`
- 期末卷综合题一般从 17 开始：`\setcounter{enumi}{16}`
- 期末卷证明题一般从 19 开始：`\setcounter{enumi}{18}`

## 4. 答案书写约定

- 普通题统一写成 `\textbf{Solution}.`
- 证明题统一写成 `\textbf{Proof}.`
- 选择题答案通常直接写成 `\textbf{Solution}. A.` 这种形式

## 5. 版式约定

- 题面中的答题空白主要通过 `\vspace{...}` 控制。
- 近年期中卷常见留白在 `8em` 到 `13em` 之间。
- 期末选择题和填空题通常只留 `1em` 左右。
- 如果题目含图，图文件通常放在 `files/` 下，并与试卷文件同名前缀，例如：
  - `2025x.tex`
  - `2025x-figure.pdf`
  - `2025x-figure2.pdf`
- 期中卷的答案部分可以适度添加积分区域或几何区域示意图，但不必每个重积分题都加图。优先给“区域边界容易看错”“需要换序或拆分区域”“题目本身提到如图所示”的题加图。
- 插图风格建议保持统一：用 `standalone` + `tikz` 生成 PDF，区域用 `cyan!20` 或相近浅青色填充，边界用 `thick` 黑线，辅助线用 `dashed`，只标必要坐标、曲线方程和区域名。
- 答案中插图优先使用左右 `minipage` 排版，不推荐用 `figure` 环境再配合负 `\vspace`。负间距容易让图片覆盖正文，也会受浮动位置影响。

常用插图嵌入方式：

```tex
\noindent
\begin{minipage}[c]{0.60\textwidth}
  这里写解答文字和公式。
\end{minipage}
\hfill
\begin{minipage}[c]{0.30\textwidth}
  \includegraphics[width=\linewidth]{2026x-figure1.pdf} % 引入图片源
\end{minipage}
```

左右两个 `minipage` 的宽度加起来建议不超过 `0.90\textwidth`，给 `\hfill`、中文标点和行内公式留一点余量。图片宽度优先写 `width=\linewidth`，这样会自动适配右侧栏宽；如果图片仍然太大，先调小右侧 `minipage` 或 TikZ 图源的 `scale`，不要用负 `\vspace` 硬压。

## 6. 常见三种结构

### 上学期 / 下学期期中

- 基本计算题
- 综合题
- 证明题（有些卷没有）

### 上学期期末

- 单项选择题
- 填空题
- 计算题
- 综合题
- 证明题

### 下学期期中（空间解析几何、多元积分等）

- 基本计算题
- 综合题
- 通常没有单独证明题

## 7. 推荐新增流程

1. 复制 `files/exam-template.tex`
2. 重命名为新年份文件，例如 `files/2026.tex`
3. 修改最上方元信息
4. 保留对应的章节结构，只替换题目与答案
5. 若有插图，把图文件一并放入 `files/`
6. 最后在 `main.tex` 对应 `\part` 中加入 `\subfile{files/2026}`

## 8. 为什么单独做这个模板

我对现有试卷做了横向比对后，发现真正稳定的不是具体题目内容，而是：

- subfile 组织方式
- 双章节结构
- 连续编号方式
- `Solution / Proof` 的答案标记
- `\vspace` 留白策略
- 插图命名方式

所以模板重点保留这些“不会变的格式层”，这样以后新增试卷时只需要改内容，不需要再重新摸索排版规则。
