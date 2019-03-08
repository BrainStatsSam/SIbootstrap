function X = readX

fileID = fopen('/vols/Scratch/ukbiobank/nichols/SelectiveInf/largefiles/avalcoholfull16.mat','r');
formatSpec = repmat('%f ', 1, 16);
formatSpec = formatSpec(1:end-1);
sizeX = [16 Inf];
X = fscanf(fileID,formatSpec,sizeX)';
fclose(fileID);
end
