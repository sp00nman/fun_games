#!/usr/bin/perl
use strict;
use warnings;

####MASTERMIND####MASTERMIND####MASTERMIND####MASTERMIND####MASTERMIND####MASTERMIND####MASTERMIND#
### Datum: 6.1.11                                                                                 #
### Author: Fiorella Schischlik                                                                   #
### Der Computer erzeugt eine Farbkombination aus 6 Farben (Zahlen von 1-6)                       #
### arben können in der Farbkombination mehrfach vorkommen.                                       #
### Der Benutzer rät die Zahlenkombination.                                                       #
### Der Computer antwortet mit einer Anzahl von „+“ die der Anzahl der richtig geratenen Farben   # 
# am richtigen Ort und einer Anzahl von „-“ die der Anzahl der richtig geratenen Farben am        #
# falschen Ort entspricht.                                                                        #
### Das Spiel wird beendet, wenn der Benutzer die richtige Farbkombination errät.                 #
### Der Computer gibt die Anzahl der Spielzüge aus.                                               #
###################################################################################################

#Subroutinen fuer das Spiel
sub getEingabe{
	my $zahlEingabe = $_[0]; #Parameteruebergabe
	my $laenge_zahl=0; #Laenge der eingegebenen Zahl
	my $zahlUser=0;   #Ziffern werden ausgelesen, die der user eingegeben hat
	my $check_schleife=0; #wird erhöht wenn die Zahl eine 7, 8,9 oder 0 enthält
	
	#Endlosschleife wird unterbrochen wenn der Spieler die korrketen Zahlen eingegeben hat, sprich 6-stellig und keine 0,7,8 oder 9 enthalten ist
	while(1) {
	
		$laenge_zahl=length($zahlEingabe);
	
		for (my $p=0;$p<=$laenge_zahl;$p++){
				$zahlUser=substr $zahlEingabe, $p, 1;
				if ($zahlUser =~/[^1-6]/)	{   #regex, nur Ziffer 1-6 sind erlaubt  ^nicht
					print("OOps! Du spielst gegen die Spielregeln!  \n");
					print("Ich sagte doch, nur Ziffern von 1-6 sind erlaubt.  \n");
					$check_schleife++;	
					last;
				}
		}
	
		if (($laenge_zahl==6)&&($check_schleife==0)){
	   	 last;
		}
		
		else {
			
			if (($laenge_zahl==6)&&($check_schleife==1)){
				$check_schleife--;
			}
	
			if ($laenge_zahl<6){
				print("Die Zahl ist zu klein! \n");
				if ($check_schleife==1){ ##gilt für folgendes Szenario: 789 zB,
					$check_schleife--;
				}
			
			}

			if ($laenge_zahl>6){
				print("Die Zahl darf nur 6-stellig sein! \n"); ##gilt für folgendes Szenario: 7899879 zB,
				if ($check_schleife==1){
					$check_schleife--;
				}
			}
			$zahlEingabe = <STDIN>;
			chomp($zahlEingabe);
		}
	}
	return $zahlEingabe;
	
}
sub getZahlPosition{
	my $zahlEingabe = $_[0]; #Parameteruebergabe
	my $randNum = $_[1];     #Parameteruebergabe
	my $rZahlrOrt=0; #richtige Zahl(en) am richtigen Ort
	my $zahlUser; #in diese Variable werden die einzelnen Ziffern der Zahl des Spielers extrahiert
	my $zahlComp; #in diese Variable werden die einzelnen Ziffern der rand Zahl extrahiert
	
		#Schleife zaehlt die richtigen Zahlen an der richtigen Position
		for (my $i=0;$i<=5;$i++){
			$zahlUser=substr $zahlEingabe, $i, 1; 
			$zahlComp=substr $randNum, $i, 1; 
			if ($zahlUser eq $zahlComp){
				$rZahlrOrt++;
					
			}
	
		}
	return $rZahlrOrt;
}
sub getZahl{
	my $zahlEingabe = $_[0]; #Parameteruebergabe
	my $randNum = $_[1];     #Parameteruebergabe
	my $rZahlfOrt=0; #richtige Zahl(en) am richtigen Ort
	my $zahlUser; #in diese Variable werden die einzelnen Ziffern der Zahl des Spielers extrahiert
	my $zahlComp; #in diese Variable werden die einzelnen Ziffern der rand Zahl extrahiert
	
		#diese Schleife zaehlt die Zahlen and der falschen Position
		for (my $q=0;$q<=5;$q++){
			$zahlComp=substr $randNum, $q, 1;  
		
			for (my $j=0;$j<=5;$j++){ # Jede randZiffer mit wir jeder userZiffer verglichen
				$zahlUser=substr $zahlEingabe, $j, 1; 
				if ($zahlUser eq $zahlComp){
					$rZahlfOrt++;
					substr($zahlEingabe, $j, 1) = 0; # ersetzt einen Treffer mit 0, weil null darf nicht vorkommen
					last; #Schleife wird unterbrochen sobald der Treffer gefunden wurde
				}
	 		
			}
		}
	return $rZahlfOrt;
}

#Deklaration der Variablen für das Spiel
my $randCon; #Extrahierte Zufallszahl wird in $randCon zwischengespeichert
my $randNum; #Zufallszahl, vom Comp generiert
my $zahlEingabe; #Eingebene Zahl des Spielers
my $rateversuche; #Anzahl der Rateversuche
my $rZahlrOrt=0; #richtige Zahl(en) am richtigen Ort
my $rZahlfOrt=0; #richtige Zahl(en)) am falschen Ort

#Erzeugt eine 6 stellige rand Zahl, nur Ziffern von 1-6 sind erlaubt
my @array = (1, 2, 3, 4, 5, 6);

#Jede Zahl wird einzeln aus einem Array gesucht, und in die Variable $randNum geschrieben
for (my $i=1;$i<=6;$i++){
	$randCon = $array[ rand @array ];
	$randNum = $randNum.$randCon;
}

print "Wanna cheat? ".$randNum . "\n"; # Nur zum Testen des Spieles

#Das Spiel kann beginnen
my $titel = "MASTERMIND v2";
print (("=" x length($titel)) . "\n");
print ("$titel\n");
print (("=" x length($titel)) . "\n");
print("Errate die 6 stellige Zahl, Ziffern von 1-6 sind erlaubt! \n");

#Endlosschleife wird unterbrochen wenn die eingegeben Zahl des Spielers, die der rand() Zahl entspricht
while (1) {
	
	#UserInput
	$zahlEingabe = <STDIN>;
	chomp($zahlEingabe);
	
	# subroutine überprüft die eingegebene Zahl
	$zahlEingabe=&getEingabe($zahlEingabe); 
	
	$rateversuche++; 
	
	#Hier wird ueberprueft ob die Zahl richtig erraten wurde
	if ($zahlEingabe eq $randNum){
		$titel = "Supa, du hast die Zahl erraten mit nur $rateversuche Rateversuchen!!!!!";
		print ("*".("*" x length($titel)) . "*"."\n");
		print ("*$titel*\n");
	    print ("*".("*" x length($titel)) . "*"."\n");
		last; #--hier wird Schleife unterbrochen
	}
	
	else{
		
		#Subroutinen ueberpruefen die Zahlen und Positionen
	    $rZahlrOrt=&getZahlPosition($zahlEingabe, $randNum); 
	    $rZahlfOrt=&getZahl($zahlEingabe,$randNum); 
	    
	    #wird abgezogen, da richtige Zahl am richtigen Ort auch gezaehlt werden 
	    $rZahlfOrt=$rZahlfOrt-$rZahlrOrt; 

	    #Ausgabe am Bildschirm
		$titel = "Das war leider falsch!";
		print (("=" x length($titel)) . "\n");
		print ("$titel\n");
		
		print "$randNum randNum\n";
		print "$zahlEingabe zahlEingabe\n"; 
		print "Ein + steht fuer richtige Zahl richtiger Ort, ein - für richtige Zahl falscher Ort\n";
		for (my $m=0;$m<$rZahlrOrt;$m++){
			print "+";
		}
		for (my $j=0;$j<$rZahlfOrt;$j++){
			print "-";
		}
		print "\n";
		
		$titel = "Versuch es doch noch einmal!";
		print ("*".("*" x length($titel)) . "*"."\n");
		print ("*$titel*\n");
	    print ("*".("*" x length($titel)) . "*"."\n");
	    
		print("Vergiss nicht: nur Ziffern von 1-6 sind erlaubt! \n");
	
	}
}




