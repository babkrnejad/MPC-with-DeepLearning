function y = Relu(x)
X0 = zeros(size(x));
for i=1:max(size(x))
    if x(i)>X0(i)
        y(i) = x(i);
    else y(i)= X0(i);
    end
end
    end
