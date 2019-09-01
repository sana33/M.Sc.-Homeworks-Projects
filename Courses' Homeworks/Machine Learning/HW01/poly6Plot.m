function z = poly6Plot(thetaVec, x, y)
z = y - thetaVec(1) - thetaVec(2)*x - thetaVec(3)*x.^2 - thetaVec(4)*x.^3 - thetaVec(5)*x.^4 - thetaVec(6)*x.^5 - thetaVec(7)*x.^6;