function T_total = DKM(theta1v , theta2v , L1 , L2 , L3)
    syms theta1 theta2 a alpha d
    DH_Table =@(a , alpha , d , theta) [
     cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
        sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
                 0,             sin(alpha),             cos(alpha),           d;
                 0,                      0,                      0,           1
    ];
    A1 = DH_Table(0 , 0 , L1 , theta1);
    A2 = DH_Table(L2 , -pi/2 , L3 , theta2);
    T_total = A1*A2;
    T_total = simplify(subs(T_total , [theta1 , theta2] , [theta1v,theta2v]));
end
