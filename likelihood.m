function likelihood = likelihood(d,beta,gammas)

egamma = normal_r_to_dim(gammas,2);
likelihood = 0;
n = length(d);
for i = 1:n
  t = d{i};
  likelihood = likelihood + t.cnt * log (beta(t.id,:) * egamma(i,:)');
end
