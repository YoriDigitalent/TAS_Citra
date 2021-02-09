function y = FastDCT(x)
% y = FastDCT(x)
% menghitung DCT atas blok x berukuran N x N
% menggunakan algoritma FFT desimasi dalam waktu
% x adalah suatu matriks N x N dan y adalah DCT atas x
% N diasumsikan bertipe 2ˆm, m adalah suatu integer positif
N = size(x,1);
x1 = zeros(N,N);
y = zeros(N,N);
% mendapatkan x1 dari x: x1(n) = x(2n), 0 <= n <= N/2;
% x1(N-1-n)= x(2n+1), 0<= n <= N/2
x1(:,1:N/2) = x(:,1:2:N);
x1(:,N+1-(1:N/2))= x(:,2:2:N);
% menghitung DFT atas setiap baris x1: X1(k) = sum(x1(n)*WNˆnk);
for m = 1:N
x1(m,:) = fft(x1(m,:));
end
% mengalikan DFT dengan alpha(k) dan W2Nˆ(k/2) dan mengambil bagian riil
% alpha(0) = 1/sqrt(N) dan alpha(2:N) = sqrt(2/N);
% W2N = exp(-i*2*pi/(2*N))
% fungsi kompleks akan lebih cepat bila digunakan 1i
% daripada i
% dimana i = sqrt(-1).
a(1) = 1/sqrt(N);
a(2:N) = sqrt(2/N);
W2N = exp(-1i*2*pi/(2*N));
for m = 1:N
y(m,1:N) = real(a.*W2N .^((0:N-1)/2).*x1(m,1:N));
end
% Sekrang menghitung DCT pada tiap kolom, yang sama seperti
% menghitung DCT y’ sepanjang baris
y = y';
x1(:,1:N/2) = y(:,1:2:N);
x1(:,N+1-(1:N/2))= y(:,2:2:N);
for m = 1:N
x1(m,:) = fft(x1(m,:));
end
% Lagi, kalikan DFT dengan alpha(k) dan W2Nˆ(k/2)
for m = 1:N
y(m,1:N) = real(a.*W2N .^((0:N-1)/2).*x1(m,1:N));
end
% transposisi y untuk mendapatkan DCT dengan urutan yang sama dengan 
% blok x masukan
y = y';
%