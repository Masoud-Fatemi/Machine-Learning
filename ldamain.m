function [alpha,beta,lambda,phi,sentiment_gamma] = ldamain(train,k)
tic

offset = 0;
m = {};
j = 0;

%----------------------------------------------
%-----------------load data train--------------
%opens the file train for read access
fid = fopen(train);
%read file
%feof Test for end-of-file.
while ~feof(fid)
  l = fgetl(fid);              % fgetl Read line from file, discard newline character.
  f = sscanf(l,'%d:%g',Inf);   % Read string under format control
  n = length(f) / 2;
  doc.id  = zeros(1,n);
  doc.cnt = zeros(1,n);
  for i = 1:n
    doc.id(i)  = f(2*i-1) + offset;
    doc.cnt(i) = f(2*i);
  end
  j    = j+1;
  m{j} = doc;
end
% close file
fclose(fid);
%----------------------------------------------
%----------------------------------------------


doc = m;
[alpha,beta,lambda,sentiment_gamma] = lda(doc,k);

phi = zeros([size(lambda, 1), size(beta, 2), size(beta, 1)]);
for i=1:size(lambda, 1)
    for j=1:size(beta, 2)
        for k=1:size(beta, 1)
            phi(i,j,k) = beta(k, j) * lambda(i, k);
        end
    end
end
toc

