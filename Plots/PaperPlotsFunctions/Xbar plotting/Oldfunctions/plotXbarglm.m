function [ out ] = plotXbarglm( type, nsubj, viat )
% PLOTXBARGLM plots the xbar plots for the glm models.
%--------------------------------------------------------------------------
% ARGUMENTS
% 
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% plotXbarglm('vbmage', 50)
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 3
    viat = 0;
end

temp = load(jgit(strcat('Results/',type,'B50nsubj',num2str(nsubj),'Data.mat')));

% M.Properties.VariableNames
M = temp.A;

boot = M(:,3 + viat);

truenaiveboot = M(:,5+2);

trueatlocis = M(:,8+2);

nct = 1;
if nct == 1
    naive = M(:,4+2)/nctcorrection(nsubj); %correcting for non-central t
    is = M(:,7+2)/nctcorrection(nsubj/2);
else
    naive = M(:,4+2); %correcting for non-central t
    is = M(:,7+2);
end
label_for_y = 'R^2';
cla
p1 = plot(trueatlocis, is,'o'); 
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot, naive,'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot, boot,'o');
set(p3,'LineWidth',1.5);
xlabel(strcat('True ', label_for_y))
ylabel(strcat(label_for_y,' estimate'))
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
title('Plotting the Estimates against the true values')
legend('indepsplit','naive','boot', 'Location','NorthWest')

end

