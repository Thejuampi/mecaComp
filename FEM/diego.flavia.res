Gid Post Results File 1.0 
### 
# MAT_FEM  V.1.0 
# 
Result "Temperatures" "Load Analysis"  1  Scalar OnNodes 
ComponentNames "Temperature" 
Values 
     1         00010 
     2   5.50000e+01 
     3         00010 
     4   5.50000e+01 
     5         00010 
     6         00100 
     7   5.50000e+01 
     8         00100 
     9         00100 
End Values 
# 
Result "ReactiveFluxes" "Load Analysis"  1  Scalar OnNodes 
ComponentNames "Fx" 
Values 
     1 -1.75000e+01 
     2        00000 
     3 -3.50000e+01 
     4        00000 
     5 -1.75000e+01 
     6  7.25000e+01 
     7        00000 
     8  1.45000e+02 
     9  7.25000e+01 
End Values 
# 
Result "Fluxes" "Load Analysis"  1  Vector OnNodes 
ComponentNames "Fx", "Fy", "Fz" 
Values 
     1  9.00000e+01        00000  0.0 
     2  9.00000e+01        00000  0.0 
     3  9.00000e+01  2.42655e-15  0.0 
     4  9.00000e+01 -6.50192e-16  0.0 
     5  9.00000e+01  4.85310e-15  0.0 
     6  9.00000e+01        00000  0.0 
     7  9.00000e+01 -1.30038e-15  0.0 
     8  9.00000e+01  2.42655e-15  0.0 
     9  9.00000e+01  4.85310e-15  0.0 
End Values 
