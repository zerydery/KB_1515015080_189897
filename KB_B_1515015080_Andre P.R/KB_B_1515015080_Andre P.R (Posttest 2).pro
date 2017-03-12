predicates
nondeterm
motif(symbol,symbol,symbol)
nondeterm
orang(symbol,long,symbol)
nondeterm
korban(symbol,symbol)
nondeterm
pelaku(symbol)
nondeterm
bukti(long,symbol)

clauses	
%Skenario Pembunuhan teman dekat
%disini terdapat clauses orang yaitu dengan parameter(Nama orang , Umur , Teman dekat)	
orang(yahya,20,katon).
orang(fajar,21,katon).
orang(arul,22,katon).
orang(arul,22,fajar).
orang(budi,23,yahya).
orang(eko,19,yahya).
orang(andi,20,yahya).
orang(kiwa,20,arul).
orang(yopan,20,fajar).
orang(fajar,21,arul).
orang(eko,22,kiwa).
orang(budi,21,kiwa).
orang(andre,22,fajar).
orang(arul,22,andre).

%Clauses bukti terdapat parameter dengan isi (Umur, dan senjata pembunuhan)
bukti(21,golok).
bukti(22,pisau).
bukti(20,batu).
bukti(19,sniper).
bukti(21,kris).
bukti(21,garpu).
bukti(20,silet).
bukti(19,pistol).
bukti(19,zatkimia).
bukti(20,pisau).
bukti(20,pedang).
bukti(21,tangan).
bukti(22,golok).
bukti(22,tali).
bukti(29,pisau).

%Clauses korban terdapat dengan parameter dengan isi (Nama korban dan teman dekatnya)
korban(fajar,andre).
korban(andre,kiwa).
korban(kiwa,arul).
korban(arul,yahya).
korban(yahya,katon).
korban(katon,andre).
korban(kiwa,eko).

%Clauses motif dengan isi parameter yaitu (motif pembunuhan, Tersangka dan korban
motif("sakit hati",arul,yahya).
motif("ekonomi",arul,mahatir).
motif("dendam",kiwa,arul).
motif("tidak ada",budi,eko).
motif("jabatan",kiwa,budi).
motif("jabatan",fajar,eko).
motif("dendam",yahya,arul).
motif("dendam",andre,fajar).
motif("dendam",andre,katon).
motif("ekonomi",eko,kiwa).
%Pada clauses pelaku jika orang yang berumur 22,29 dan 20 karena ditemukan senjata pembunuhan berupa pisau. Setelah diteliti terdapat beberapa orang yang berumur 20,22 dan 29 yaitu
%andre berteman dekat dengan fajar, eko dengan kiwa, arul dengan andre. Dari ketiga pasang tersebut ditemukan sebuah motif pembunuhan yaitu ekonomi
%maka ketemulah pelaku dan korban dapat di identifikasi.
pelaku(X):-
	orang(X,Y,W),
	bukti(Y,pisau),
	korban(W,X),
	motif("ekonomi",X,W).
	
	

goal
	pelaku(Pelakunya),
	motif("ekonomi",Pelakunya,Korbannya).

