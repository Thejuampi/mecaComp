Gid Post Results File 1.0 
### 
# MAT_FEM  V.1.0 
# 
Result "Temperatures" "Load Analysis"  1  Scalar OnNodes 
ComponentNames "Temperature" 
Values 
     1         00100 
     2         00000 
     3         00100 
End Values 
# 
Result "ReactiveFluxes" "Load Analysis"  1  Scalar OnNodes 
ComponentNames "Fx" 
Values 
     1  1.90833e+02 
     2 -4.09167e+02 
     3  1.95833e+02 
End Values 
# 
Result "Fluxes" "Load Analysis"  1  Vector OnNodes 
ComponentNames "Fx", "Fy", "Fz" 
Values 
     1        00040        00040  0.0 
     2        00040        00040  0.0 
     3        00040        00040  0.0 
End Values 
