function [ output_args ] =Small(input_args,m,n)

Scale=max(abs(m-input_args),abs(n-input_args));


output_args=1-abs(input_args)/Scale;


end

