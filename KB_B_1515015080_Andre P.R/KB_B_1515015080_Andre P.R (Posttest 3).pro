domains
	harga = integer
	
predicates
	nondeterm
	orang(symbol,symbol,long)
	nondeterm
	pesanan(symbol,symbol,long,symbol,long)	
	nondeterm
	barang(symbol,symbol,long)
	nondeterm
	cek(symbol)
	nondeterm
	diskon(long,long)
	procedure
	tambah(harga,harga,harga,harga)
	
clauses
	%Diklausa orang terdapat nama pembeli, kode barang dan Uang si pembeli
	orang("Andre","12AKW",100000).
	orang("Kiwa","AMN10",400000).
	orang("Budi","78KWA",90000).
	orang("Andre","AKW009",95000).
	orang("Fajar","JJH29",500000).
	orang("Katon","99AKW",150000).
	orang("Arul","888GR",95000).
	orang("Arul","LLP23",100000).
	%Diklausa barang terdapat jenis barang kode barang dan harga barang
	barang("Baju","12AKW",99000).
	barang("Baju","78KWA",80000).
	barang("Baju","99AKW",130000).
	barang("Baju","888GR",70000).
	barang("Celana","AMN10",350000).
	barang("Celana","AKW009",85000).
	barang("Celana","JJH29",499999).
	barang("Celana","LLP23",99999).
	
	%Pada Klausa diskon terdapat 2 klausa, yang pertama jika Harga barang melebihi dari 90000 maka akan dapat diskon sebesar 20%
	diskon(HargaBarang,Diskon):-
		pesanan(_,_,HargaBarang,_,_),
		HargaBarang > 90000,
		Diskon = 20.
		%HargaBarang < 90000,
		%Diskon = 10.
	diskon(HargaBarang,Diskon):-	%Klausa ke 2 jika Harga barang kurang dari 90000 maka akan mendapat diskon sebesar 5%
		pesanan(_,_,HargaBarang,_,_),
		HargaBarang < 90000,
		Diskon = 5.

	%Pada klausa cek disini menginputkan kode barang lalu mencocokan dengan klausa orang dan klausa barang
	cek(KodeBarang):-
		write("~~~~~~~~~~~~~~Selamat Datang~~~~~~~~~~~~~~~~~~~"),nl,
		write("    Silahkan Masukkan Kode Barang Anda :"),nl,
		write("    "),
		readln(KodeBarang),nl.
	
	%*cek(KodeBarang):-
		%write("Kode Barang Yang Anda masukkan tidak terdaftar"),nl,
		%Nama="",
		%pesanan(Nama,KodeBarang,_,_,_).
		
		
	pesanan(Nama,KodeBarang,HargaBarang,NamaBarang,Uang):-
		orang(Nama,KodeBarang,Uang),
		barang(NamaBarang,KodeBarang,HargaBarang).
		
		%Pada tahap ini merupakan perhitungan dimana Uang pembeli - Harga barang yg telah didiskon
	tambah(U,H,T,D):-
		T=U-(H-(H*(D/100))).
goal
	cek(KodeBarang),
	pesanan(NamaPembeli,KodeBarang,HargaBarang,JenisBarang,Uang),nl,
	write("----------------------------------------------------"),nl,
	diskon(HargaBarang,Diskon),
	tambah(Uang,HargaBarang,Kembalian,Diskon).
		