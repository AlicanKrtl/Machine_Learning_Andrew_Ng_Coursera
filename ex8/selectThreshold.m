function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    predictions = (pval < epsilon); 
    [val idx] = sort(yval,"descend");  #sorts values from bigger to smaller in yval and assing index to idx
    
    y_sum = sum(yval); # number of 1 in yval
    idx_tp = idx(1:y_sum); #indexs of ones in yval
    tp = sum(predictions(idx_tp)); 
    
    idx_fp = idx(sum(yval)+1:size(idx,1)); #indexs of zeros in yval
    fp = sum(predictions(idx_fp));
    
    fn = sum(abs(predictions(idx_tp)-1));
    
    prec = tp/(tp+fp);
    
    rec = tp/(tp+fn);

    F1 = (2*prec*rec)/(prec+rec);

    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
