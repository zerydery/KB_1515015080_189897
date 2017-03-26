/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,object,vice,substance = symbol %mengatur tipe beberapa variable seperti nama sex occupation obeject dan lain - lain sebagai symbol
  age=integer % dan age sebagai integer

predicates
%terdapat beberapa predikat yaitu person had_affair killed_with dan lain-lain
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses
%pada klausa person terdapat nama orang , umur , jenis kelamin(male/famale) dan pekerjaan
  person(bert,55,m,carpenter).
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).
%klausa ini tedapat 2 nama orang yg mempunyai hubungan
  had_affair(barbara,john).
  had_affair(barbara,bert).
  had_affair(susan,john).
%dibagian ini terdapat 2 klausa , yang pertama yg terbunuh susan dengan club(pentungan)
  killed_with(susan,club). %yang kedua ada terbunuh susan.
  killed(susan).
%pada klausa ini terdapat yang isi merupakan motif-motif
  motive(money).
  motive(jealousy).
  motive(righteousness).
%pada klausa ini terdapat terdapat beberapa orang yang berlumur blood(darah), mud(lumpur) dan chocolate(coklat).
  smeared_in(bert,blood).
  smeared_in(susan,blood).
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).
%pada klausa ini terdapat nama orang dan kepemilikan sebuah benda seperti wooden leg dan pistol
  owns(bert,wooden_leg).
  owns(john,pistol).

/* * * Background knowledge * * */
%klausa ini adalah barang yang cara kerjanya mirip dgn senjata
  operates_identically(wooden_leg, club). %yg pertama adalah wooden_leg mirip dengan club
  operates_identically(bar, club). %bar dengan club
  operates_identically(pair_of_scissors, knife). %pair_of_scissors dengan knife
  operates_identically(football_boot, club). %football_boot dengan club
%klausa ini kemungkinan pemilik
  owns_probably(X,football_boot):- % yang pertama adalah football_boot maka kemungkinannya adalah football_player.
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-%Pair_of_scissors dengan hairdresser
	person(X,_,_,hairdresser).
  owns_probably(X,Object):- %kemungkinan pemilik benda(football_boot,wooden_leg dan lain-lain)
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */
%klausa ini merupakan mencurigai orang jika senjata pembunuhan mirip dengan benda yang dimiliki orang. seperti wooden_leg, bar, football_boot
  suspect(X):-		%lalu dari situ nama orangnya akan ditetapkan jadi tersangka
	killed_with(susan,Weapon) ,
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */
%selanjutnya mencurigai orang dengan cara menelusuri adanya hubungan dengan si susan dan motifnya
  suspect(X):- %motif adalah cemburu , orangnya adalah laki - laki dan punya hubungan dengan susan
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */
%selanjutnya adalah mencurigai orang berjenis kelamin perempuan
  suspect(X):- %motif cemburu, dan susan punya hubungan dengan john dan john punya hubungan dengan barbara
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */
%mencurgai orang jika motifnya adalah uang dan orang yang mempunyai pekerjaan mencopet adalah john
  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).
%pada klausa ini mencari pembunuhnya dengan mencocokan data - data yang sdh ada.
  killer(Killer):- %pembunuh dicari dengan data orang , yang terbunuh , tersangka, berlumur pada pembunuh dan yang terbunuh
	person(Killer,_,_,_),
	killed(Killed),
	Killed <> Killer, /* It is not a suicide */ %korban bukanlah tersangka , (artinya korban tidak bunuh diri)
	suspect(Killer),
	smeared_in(Killer,Goo),
	smeared_in(Killed,Goo).

goal
  killer(X).
%hasilnya adalah bert. Bert merupakan pembunuh, karena dilihat dari data - data yang sudah ada
%yang terbunuh adalah susan, dan korban bukanlah tersangka , (artinya korban tidak bunuh diri)
%di cek semua kemungkinan tersangka yang pertama adalah mencari orang yang memiliki benda yang bisa dijadikan senjata yang mirip dengan senjata yang membunuh susan.
%setelah itu didapat tersangka kemungkinan pertama yaitu bert dan allan
%lanjut ke kemungkinan tersangka ke 2 adalah mencari orang yang mempunyai hubungan dengan susan dan punya motif cemuburu
%didapat john. kemungkinan tersangka ke 3 adalah mencari orang yang mempunyai hubungan dengan orang yang punya hubungan dengan susan
%lanjut kemungkinan tersangka ke 4 adalah mencari orang dengan motif uang adalah john karena john bekerja sebagai pencopet.
%didapat barbara. lalu mengecek pada tersangka yang telah didapat dari kemungkinan tersangka apakah ada
%berlumur darah, karena susan berlumur darah dan orang yang berlumur darah adalah bert.
%dari data - data yang sudah ada maka bert ditetapkan sebagai pelaku.
%dari program ini prolog melakukan backtrackingpada saat "smeared_in(Killed,Goo)" yg kedua, karena susan juga berlumur darah namun di pernytaan diatasnya bahwa korban tidak mati bunuh diri.
%karena banyak kemungkinan tersangka, orang - orang di lacak akan melalui kemungkinan -  kemungkinan tersangka tersebut, kalau orang pertama tidak 
%memenuhi syarat maka akan melakukan backtracking lagi ke orang berikutnya.