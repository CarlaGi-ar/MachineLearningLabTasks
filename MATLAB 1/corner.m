function y = corner(x)
[n,m] =size(x);

y = [ x(1,1) x(1,m) ; x(n,1) x(n,m) ];

