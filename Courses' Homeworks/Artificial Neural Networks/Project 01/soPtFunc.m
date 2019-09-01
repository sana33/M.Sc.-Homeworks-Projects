function z = soPtFunc(w1,w2,w3,w4,x,y,th)
z = w1*x + w2*y + w3*x.^2 + w4*y.^2 - th;