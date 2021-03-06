% Author : Harsh Pathak & Vipul Bajaj
% 15 sept 2017
% all the sparse matrices are Diagonal in nature or its permutations
% Inverse of only Diagonal Sparse matrices is guranteed to be sparse
% Platform : Octave

% IF USING CMD PLS MODIFY THIS 
M = 1500

%Generating all the random matrices.

DATA1 =  ceil(12 * rand(M,M));
DATA2 =  ceil(13 * rand(M,M));

% ***  Plain Matrix Multiplication  *** 
tic 
DATA1*DATA2;
t1 = toc;
disp("DATA1*DATA2::"),disp(t1)

%sparse matrices generation;
s1 = circshift(speye(M),-2);
s2 = 6*speye(M);
s3 = circshift(speye(M),-5);

%Zsparse = sprandn(M,M,0.15);
Zsparse = circshift(speye(M),-5);


% ENCRYPTION 
tic 
EncDATA1 = (s1*DATA1*s2)+Zsparse;
EncDATA2 = (inv(s2)*DATA2*s3)+Zsparse;
t2=toc;
disp("Total Encry time ::"),disp(t2)



% CLOUD SIDE 
Result = EncDATA1*EncDATA2;


% Precalculated variables on Client side
T = Zsparse*Zsparse + s1*DATA1*s2*Zsparse + Zsparse*inv(s2)*DATA1*s1;

% try decrypting
tic
Decry_Ans = (inv(s1)*((Result - T))*inv(s3));
toc

CM = randi([0,1],M,1); % coloum matrix




