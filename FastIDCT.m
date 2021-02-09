function y = FastIDCT(x)
% y = FastIDCT(x)
% menghitung IDCT atas suatu blok N x N 
% menggunakan algoritma desimasi dalam waktu IFFT
% N harus dalam N = 2ˆm, dimana
% m adalah suatu integer positif
N = size(x,1);
x3 = zeros(N,N);
% mengalikan x dengan a(k)*W2Nˆ(-k/2) & menghitung IDFT atas tiap baris
W = exp(1i*pi/(2*N));
a(1) = 1/sqrt(N);
a(2:N) = sqrt(2/N);
for m = 1:N
x(m,1:N) = a.*x(m,1:N).*W .^(0:N-1);
x3(m,:) = ifft(x(m,:));
end
% mengalikan ifft(x) dengan N karena ifft menyertakan faktor 1/N
x3 = x3 * N;
% menata-ulang runtun keluaran untuk mendapatkan keluaran yang benar
% 
y(:,1:2:N) = x3(:,1:N/2);
y(:,2:2:N)= x3(:,N:-1:N/2+1);
y = real(y);
%
% mengalikan y dengan a(k)*W2Nˆ(-k/2) & menghitung IDFT atas tiap kolom
% yang sama dengan menghitung IDFT atas baris y'
y = y';
for m = 1:N
x3(m,1:N) = a.*y(m,1:N).*W .^(0:N-1);
x3(m,:) = ifft(x3(m,:));
end
x3 = x3 * N;
% menata-ulang runtun keluaran untuk mendapatkan keluaran yang benar
% 
y(:,1:2:N) = x3(:,1:N/2);
y(:,2:2:N)= x3(:,N:-1:N/2+1);
% meskipun y seharusnya riil, bagian imajiner
% dari y akan nol dan y akan tampil sebagai kompleks.
% jadi, ambil bagian riil dari y' untuk mendapatkan IDCT yang sebenarnya
% ingat untuk mentransposisi y dalam menghitung IDCT
% sepanjang kolom. 
y = real(y');