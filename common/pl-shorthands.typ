// shorthands for typing PL stuff

// imports
#import "@preview/curryst:0.3.0": rule, proof-tree

// greek
#let ctx = $Gamma$
#let Gam = $Gamma$
#let eps = $epsilon.alt$

// symbols
#let partial = $harpoon.rt$
#let defeq = $eq.delta$
#let bequiv = $scripts(equiv)_beta$
#let aequiv = $scripts(equiv)_alpha$
#let equivb = $scripts(equiv)_beta$
#let equiva = $scripts(equiv)_alpha$
#let tac = $scripts(tack.r)$
#let step = $arrow.r.long.bar$
#let steps = $arrow.r.long.bar$
#let subst = $\/$
#let sub = $\/$
#let trir = $gt.tri$
#let tril = $lt.tri$
#let timesc = $times.circle$
#let wavydiv = $#move(rotate($tilde.dot$, 0deg), dy: -0.09em) #h(-0.78em) #move(rotate($tilde.dot$, 180deg), dy: 0.09em)$
#let hook = $arrow.r.hook$

// draw
#let ub = math.underbracket
#let layer(top, bottom, name) = align(center)[
  #proof-tree(rule(
    name: name,
    bottom,
    top,
  ),)
]

// judgements
#let val = math.sans("val")
#let ok = math.sans("ok")
#let proc = math.sans("proc")
#let action = math.sans("action")
#let final = math.sans("final")

// mono
#let fun = math.mono("fun")
#let ap = math.mono("ap")
#let null = math.mono("null")
#let unit = math.mono("unit")
#let pair = math.mono("pair")
#let proj = math.mono("proj")
#let proj1 = $mono("proj")〈 1 〉$
#let proj2 = $mono("proj")〈 2 〉$
#let inj = math.mono("inj")
#let inj1 = $mono("inj")〈 1 〉$
#let inj2 = $mono("inj")〈 2 〉$
#let void = math.mono("void")
#let absurd = math.mono("absurd")
#let case = math.mono("case")
#let letcc = math.mono("letcc")
#let cont = math.mono("cont")
#let bind = math.mono("bind")
#let comp = math.mono("comp")
#let throw = math.mono("throw")
#let ret = math.mono("ret")
#let nat = math.mono("nat")
#let mret = math.mono("mret")
#let dcl = math.mono("dcl")
#let mobile = math.mono("mobile")
#let inn = math.mono("in")
#let bnd = math.mono("bnd")
#let lett = math.mono("let")
#let get = math.mono("get")
#let sett = math.mono("set")
#let cmd = math.mono("cmd")
#let sync = math.mono("sync")
#let chref = math.mono("chref")
#let do = math.mono("do")
#let emitref = math.mono("emitref")
#let split = math.mono("split")
#let ifz = math.mono("ifz")

// subscripts
#let a1 = $a_1$
#let b1 = $b_1$
#let c1 = $c_1$
#let d1 = $d_1$
#let e1 = $e_1$
#let f1 = $f_1$
#let g1 = $g_1$
#let h1 = $h_1$
#let i1 = $i_1$
#let j1 = $j_1$
#let k1 = $k_1$
#let l1 = $l_1$
#let m1 = $m_1$
#let o1 = $o_1$
#let p1 = $p_1$
#let q1 = $q_1$
#let r1 = $r_1$
#let s1 = $s_1$
#let t1 = $t_1$
#let u1 = $u_1$
#let v1 = $v_1$
#let w1 = $w_1$
#let x1 = $x_1$
#let y1 = $y_1$
#let z1 = $z_1$

#let a2 = $a_2$
#let b2 = $b_2$
#let c2 = $c_2$
#let d2 = $d_2$
#let e2 = $e_2$
#let f2 = $f_2$
#let g2 = $g_2$
#let h2 = $h_2$
#let i2 = $i_2$
#let j2 = $j_2$
#let k2 = $k_2$
#let l2 = $l_2$
#let m2 = $m_2$
#let o2 = $o_2$
#let p2 = $p_2$
#let q2 = $q_2$
#let r2 = $r_2$
#let s2 = $s_2$
#let t2 = $t_2$
#let u2 = $u_2$
#let v2 = $v_2$
#let w2 = $w_2$
#let x2 = $x_2$
#let y2 = $y_2$
#let z2 = $z_2$

#let a3 = $a_3$
#let b3 = $b_3$
#let c3 = $c_3$
#let d3 = $d_3$
#let e3 = $e_3$
#let f3 = $f_3$
#let g3 = $g_3$
#let h3 = $h_3$
#let i3 = $i_3$
#let j3 = $j_3$
#let k3 = $k_3$
#let l3 = $l_3$
#let m3 = $m_3$
#let o3 = $o_3$
#let p3 = $p_3$
#let q3 = $q_3$
#let r3 = $r_3$
#let s3 = $s_3$
#let t3 = $t_3$
#let u3 = $u_3$
#let v3 = $v_3$
#let w3 = $w_3$
#let x3 = $x_3$
#let y3 = $y_3$
#let z3 = $z_3$

#let a4 = $a_4$
#let b4 = $b_4$
#let c4 = $c_4$
#let d4 = $d_4$
#let e4 = $e_4$
#let f4 = $f_4$
#let g4 = $g_4$
#let h4 = $h_4$
#let i4 = $i_4$
#let j4 = $j_4$
#let k4 = $k_4$
#let l4 = $l_4$
#let m4 = $m_4$
#let o4 = $o_4$
#let p4 = $p_4$
#let q4 = $q_4$
#let r4 = $r_4$
#let s4 = $s_4$
#let t4 = $t_4$
#let u4 = $u_4$
#let v4 = $v_4$
#let w4 = $w_4$
#let x4 = $x_4$
#let y4 = $y_4$
#let z4 = $z_4$


#let A1 = $A_1$
#let B1 = $B_1$
#let C1 = $C_1$
#let D1 = $D_1$
#let E1 = $E_1$
#let F1 = $F_1$
#let G1 = $G_1$
#let H1 = $H_1$
#let I1 = $I_1$
#let J1 = $J_1$
#let K1 = $K_1$
#let L1 = $L_1$
#let M1 = $M_1$
#let O1 = $O_1$
#let P1 = $P_1$
#let Q1 = $Q_1$
#let R1 = $R_1$
#let S1 = $S_1$
#let T1 = $T_1$
#let U1 = $U_1$
#let V1 = $V_1$
#let W1 = $W_1$
#let X1 = $X_1$
#let Y1 = $Y_1$
#let Z1 = $Z_1$

#let A2 = $A_2$
#let B2 = $B_2$
#let C2 = $C_2$
#let D2 = $D_2$
#let E2 = $E_2$
#let F2 = $F_2$
#let G2 = $G_2$
#let H2 = $H_2$
#let I2 = $I_2$
#let J2 = $J_2$
#let K2 = $K_2$
#let L2 = $L_2$
#let M2 = $M_2$
#let O2 = $O_2$
#let P2 = $P_2$
#let Q2 = $Q_2$
#let R2 = $R_2$
#let S2 = $S_2$
#let T2 = $T_2$
#let U2 = $U_2$
#let V2 = $V_2$
#let W2 = $W_2$
#let X2 = $X_2$
#let Y2 = $Y_2$
#let Z2 = $Z_2$

#let A3 = $A_3$
#let B3 = $B_3$
#let C3 = $C_3$
#let D3 = $D_3$
#let E3 = $E_3$
#let F3 = $F_3$
#let G3 = $G_3$
#let H3 = $H_3$
#let I3 = $I_3$
#let J3 = $J_3$
#let K3 = $K_3$
#let L3 = $L_3$
#let M3 = $M_3$
#let O3 = $O_3$
#let P3 = $P_3$
#let Q3 = $Q_3$
#let R3 = $R_3$
#let S3 = $S_3$
#let T3 = $T_3$
#let U3 = $U_3$
#let V3 = $V_3$
#let W3 = $W_3$
#let X3 = $X_3$
#let Y3 = $Y_3$
#let Z3 = $Z_3$

#let A4 = $A_4$
#let B4 = $B_4$
#let C4 = $C_4$
#let D4 = $D_4$
#let E4 = $E_4$
#let F4 = $F_4$
#let G4 = $G_4$
#let H4 = $H_4$
#let I4 = $I_4$
#let J4 = $J_4$
#let K4 = $K_4$
#let L4 = $L_4$
#let M4 = $M_4$
#let O4 = $O_4$
#let P4 = $P_4$
#let Q4 = $Q_4$
#let R4 = $R_4$
#let S4 = $S_4$
#let T4 = $T_4$
#let U4 = $U_4$
#let V4 = $V_4$
#let W4 = $W_4$
#let X4 = $X_4$
#let Y4 = $Y_4$
#let Z4 = $Z_4$

