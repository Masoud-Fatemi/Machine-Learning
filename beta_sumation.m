function betas = beta_sumation(betas,q,t)

betas(t.id,:) = betas(t.id,:) + diag(t.cnt) * q;
