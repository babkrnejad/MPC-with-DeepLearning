function Sigmaa=Sigma(x)

Sigmaa=ones(size(x))./(ones(size(x))+exp(-x));
 
end
