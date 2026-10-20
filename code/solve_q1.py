# -*- coding: utf-8 -*-
# 本程序及代码是在人工智能工具辅助下完成的。
# 人工智能工具名称：XXX；版本/型号：X.X；开发机构/公司：XXX；版本颁布日期：2026-XX-XX
# （若未使用 AI 工具辅助编程，删除以上注释即可）
"""问题一求解程序。"""
import numpy as np


def solve(c, A, b):
    """求解线性规划 min c^T x  s.t. A x <= b, x >= 0。"""
    from scipy.optimize import linprog
    res = linprog(c, A_ub=A, b_ub=b, bounds=(0, None), method="highs")
    return res.x, res.fun


if __name__ == "__main__":
    c = np.array([1.0, 2.0])
    A = np.array([[1.0, 1.0], [1.0, -1.0]])
    b = np.array([4.0, 1.0])
    x, f = solve(c, A, b)
    print("x* =", x, "f* =", f)
