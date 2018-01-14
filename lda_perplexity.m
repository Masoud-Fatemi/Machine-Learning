function perplexity = lda_perplexity(d,beta,gammas)

s = 0;
n = length(d);
for i = 1:n
  s = s + sum(d{i}.cnt);
end
perplexity = exp (- likelihood(d,beta,gammas) / s);
