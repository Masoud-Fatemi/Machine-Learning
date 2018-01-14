function [alpha,q] = variational_bayes(doc,beta,alpha0)



em_maximum = 20;
l = length(doc.id);
k = length(alpha0);
q = zeros(l,k);
current = ones(1,k) * l / k;
next = current;
for j = 1:em_maximum
  
  %expectation setep
  q = normal_r_to_dim(beta(doc.id,:) * diag(exp(psi(alpha0 + current))),2);
 
  %maximization step
  current = doc.cnt * q;
  
  %check convergence condition
  if (j > 1) && converged(current,next,1.0e-2)
    break;
  end
  next = current;
end
alpha = alpha0 + current;
