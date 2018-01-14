function out = converged(input1,input2,threshhold)

%defult threshold
if (nargin < 3)
  threshhold = 1.0e-3;
end

if (difference(input1, input2) < threshhold)
  out = true;
else
  out = false;
end
