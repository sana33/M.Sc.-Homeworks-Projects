function z = poly3Plot(thetaVec, x, y)
z = y - thetaVec(1) - thetaVec(2)*x - thetaVec(3)*x.^2 - thetaVec(4)*x.^3;