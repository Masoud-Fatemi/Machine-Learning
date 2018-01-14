function [alpha,beta,lambda,sentiment_gamma] = lda(doc,k)


%-------------------------------------------
%--------calculate # of distinct id---------
a = 0;
for current_doc = doc
  for id = current_doc{:}.id
    if id > a
      a = id;
    end
  end
end
l = a;


%--------------------------------------------
%-------------initial parameters-------------
s                 = 3;
n                 = length(doc);
perplexity        = 0;
next_perplexity   = perplexity;
beta              = normal_r_to_dim(rand(l,k),1);
alpha             = normalize(fliplr(sort(rand(1,k))));
lambda            = rand(s, l);  %prior knowledge
sentiment_gamma   = rand(1, s);  %ok<NASGU>
em_maximum        = 100;
gammas            = zeros(n,k);
%--------------------------------------------
%--------------------------------------------


fprintf(1,'number of documents      = %d\n', n);
fprintf(1,'number of words          = %d\n', l);
fprintf(1,'number of latent classes = %d\n', k);



%----------------------------------------------------------
%----------------------main loop---------------------------
%inference and parameter stimation with variational baysian

for j=1 : em_maximum
    fprintf(1,'iteration %d/%d  :  \t',j,em_maximum);
 
    
    %expectation setep
    %For each document, find the optimizing values of the variational parameters
    betas = zeros(l,k);
    for i = 1:n
        % q : (L * K) matrix of word posterior over latent classes
        % calculates a document and words posterior for a document doc
        [gamma,q]   = variational_bayes(doc{i},beta,alpha); 
        gammas(i,:) = gamma;
        betas       = beta_sumation(betas,q,doc{i});
    end
    
    
    %maximization step
    %Maximize the resulting lower bound on the log likelihood with respect to the model parameters alpha and beta
    alpha = newton_alpha(gammas);
    beta  = normal_r_to_dim(betas,1);
    
    
    
    
    %check convergence condition
    if(j <= s), lambda(j, :) = normal_r_to_dim(lambda(j, :), 2); end
    perplexity = lda_perplexity(doc,beta,gammas);
    fprintf(1,'perplexity = %g\t',perplexity);
    if (j > 1) && converged(perplexity,next_perplexity,1.0e-4)
        if (j < 5)
        fprintf(1,'\n');
        [alpha,beta,lambda,sentiment_gamma] = lda(doc,k); %try again!
        return;
        end
        fprintf(1,'\nconverged.\n');
    return;
    end
    
    
    next_perplexity = perplexity;
    fprintf(1,'\n');
end
fprintf(1,'\n');

