domains
	harga = integer %Menyatakn bahwa variable harga,total dan p adalah bertipe integer

predicates 
	nondeterm %nondeterm pada section predicates berfungsi untuk memberi tahu compiler bahwa predikat tersebut mempunyai lebih dari satu kemungkinan jawaban.
	shirt(symbol,symbol,long) 
	nondeterm
	jeans(symbol,symbol,long)
	nondeterm
	jackets(symbol,symbol,long)
	nondeterm
	lengkap(symbol,symbol,long)
	nondeterm
	orang(symbol,long)
	procedure
	tambah(harga,harga,harga)
	
	
clauses
	shirt(merah,xl,100000).
	shirt(merah,m,90000).
	shirt(putih,xl,103000).
	shirt(kuning,xxl,150000).
	shirt(putih,l,75000).
	jeans(biru,xl,200000).
	jeans(hijau,xxxl,300000).
	jackets(putih,xl,250000).
	jackets(merah,xxl,270000).
	
	lengkap(Warna,Ukuran,Price):-
	shirt(Warna,Ukuran,Price);
	jeans(Warna,Ukuran,Price);
	jackets(Warna,Ukuran,Price).
	
	orang(fajar,10).
	orang(budi,4).
	orang(yahya,3).
	orang(katon,2).
	
	tambah(Z,P,Total):-
	Total=Z*P.
	

goal
	lengkap(Warna,Ukuran,Harga),
	Warna=merah,
	orang(Pembeli,Banyaknya),
	Pembeli=katon,
	tambah(Harga,Banyaknya,Total).
	
%Program memanggil predikat shirt,jeans,jaket dan procedure tambah. Goal dalam program ini mencari
%shirt, jeans atau jackets yang berwarna merah dan juga menentukan banyaknya beli sesuai dengan menentukan orangnya
% lalu mentotal semua. DiKlausa ada macam - macam seperti shirt jeans dan jackets dengan parameter
%warna,ukuran dan harga. Selanjutnya ada klausa Orang yaitu didalam parameternya ada Nama orang dan Banyak barang yang akan di beli
%dan terakhir ada kluasa tambah yaitu perkalian antara harga barang dan banyaknya barang.
%Goalnya terdapat lebih dari 1 yaitu mencari barang dengan warna merah setelah itu menentukan banyaknya barang dengan
%mencari, menentukan pembeli yaitu katon dimana katon banyak membeli yaitu 2. Setelah itu
%Goal terakhir adalah mentotalkan harga dengan banyak barang yang dibeli yaitu 2.