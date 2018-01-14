function out = normal_r_to_dim(m,doc)


%defult condition
if nargin < 2
  doc = 1;
end
sumation = sum(m,doc);
if doc == 1
  out = m * diag(1 ./ sumation);
elseif doc == 2
  out = diag(1 ./ sumation') * m;
end
