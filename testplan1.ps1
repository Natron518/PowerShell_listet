Write-Output "========================================================="
Write-Host "<              hello and wellcome to my                 >"-ForegroundColor Green
Write-Host "<               Nathalie's Menu ithems                  >"-ForegroundColor Green
Write-Output "========================================================= `n "

do
{
    Write-Host "Bitte whealen sie etwas aus: `n " 
   
    Write-Host "0: Skript beenden. "-ForegroundColor red
    Write-Host "1: Textdatei erstellen."-ForegroundColor Gray
    Write-Host "2: Textdatei löschen."-ForegroundColor Gray
    Write-Host "3: in Textdatei schreiben."-ForegroundColor Gray
    Write-Host "4: aus Textdatei lesen."-ForegroundColor Gray
    Write-Host "5: Benutzerkonto erstellen."-ForegroundColor Gray
    Write-Host "6: Benutzerkonto löschen."-ForegroundColor Gray
    Write-Host "7: Passwort ändern."-ForegroundColor Gray
    Write-Host "8: Gruppe erstellen."-ForegroundColor Gray
    Write-Host "9: Gruppe löschen."-ForegroundColor Gray
    Write-Host "10: Benutzer einer Gruppe hinzufügen."-ForegroundColor Gray
    Write-Host "11: Benutzer aus einer Gruppe löschen."-ForegroundColor Gray
    Write-Host "12: zinzenrechner."-ForegroundColor Cyan
    Write-Host "13: rechner."-ForegroundColor Yellow
    Write-Host "14: Rate spiel."-ForegroundColor Green
    Write-Host "15: Test 11.5.2023"

    $wahl = Read-Host "Ihre Wahl: "

    switch($wahl)
    {
        0 {Write-Host "Das Skript wird beendet"}

        1 {$path = Read-Host "Geben Sie den Pfad und den Namen der neuen Datei ein (ohne Dateiendung): "
        New-Item -Path "$path.txt" -ItemType "file"}

                2 {$path = Read-Host "Geben Sie den Pfad und den Namen der zu löschenden Datei ein (ohne Dateiendung): "
        Remove-Item "$path.txt"}

        3 {$text = Read-Host "Geben Sie den Text ein, der in die Datei geschrieben werden soll: "
        $path = Read-Host "Geben Sie den Pfad und den Namen der Datei an, in die der Text geschrieben werden soll: "
        $text | Out-File -FilePath "$path.txt" -Append}

        4 {$path = Read-Host "Geben Sie den Pfad und den Namen der zu lesenden Datei ein: "
        $inhalt = Get-Content $path
        Write-Host $inhalt}

        5 {$user = Read-Host "Geben Sie den Namen des neuen Benutzers ein: "
        $voll = Read-Host "Geben Sie den Vor- und Nachnamen ein: "
        $pass = Read-Host -AsSecureString "Geben Sie das Passwort für den neuen Benutzer ein: "
        New-LocalUser -Name $user -FullName $voll -Password $pass}
        
        6 {$user = Read-Host "Geben Sie den Namen des zu löschenden Benutzerkontos ein: "
        Remove-LocalUser -Name $user}
        
        7 {$user = Read-Host "Geben Sie den Benutzernamen ein: "
        $pass = Read-Host -AsSecureString "Geben Sie das neue Passwort ein: "
        Set-LocalUser -Name $user -Password $pass}
        
        8 {$gruppe = Read-Host "Geben Sie den Namen der neuen Gruppe ein: "
        New-LocalGroup $gruppe}

        9 {$gruppe = Read-Host "Geben Sie den Namen der zu löschenden Gruppe ein: "
        Remove-LocalGroup $gruppe}

        10 {$user = Read-Host "Welcher Benutzer soll einer Gruppe hinzugefügt werden? "
        $gruppe = Read-Host "Welcher Gruppe soll der Benutzer hinzugefügt werden? "
        Add-LocalGroupMember -Name $gruppe -Member $user}
        
        11 {$user = Read-Host "Welcher Benutzer soll aus einer Gruppe entfernt werden? "
         $gruppe = Read-Host "Aus welcher Gruppe soll der Benutzer entfernt werden? "
        Remove-LocalGroupMember -Name $gruppe -Member $user}

        12{ function geldBetrag{do{
            $betrag = Read-Host "Für welchen Betrag wollen Sie die Zinserträge berechnen?"
            if($betrag -le 0){
            Write-Host "Der eingegebene Betrag muss grösser als Null sein!"}
            else{$betrag}
            }while($betrag -le 0)}
            
            function zinsSatz{do{$zins = Read-Host "Mit welchem Zinssatz soll gerechnet werden?"
            if($zins -le 0){
            Write-Host "Der eingegebene Zinssatz muss grösser als Null sein!"}
            else{$zins}
            }while($zins -le 0)}
    
            function berechnung{param($betrag, $zins)
            $zins = $zins / 100 + 1 
            Write-Host "Startbetrag: $betrag"
            Write-Host "Zinssatz: $zins"
            Write-Host "Entwicklung des Betrags über 10 Jahre:"
            for($i = 1; $i -le 10; $i++){
            [double]$betrag = $betrag * $zins
            Write-Host "Jahr $i : $betrag"}}

            do{Write-Host "Das Skript berechnet die Entwicklung eines Geldbetrags über 10 Jahre bei einem fixen Zinssatz"
            $betrag = geldBetrag
            $zins = zinsSatz
            berechnung -betrag $betrag -zins $zins
            $wieder = Read-Host "Wollen Sie noch eine Berechnung machen? (1 --> ja)"
            }while($wieder -eq 1)}
        
        13{function Eingabe-Zahl{$zahl = Read-Host "Geben Sie eine Zahl ein"
            return $zahl}
    
        function Get-Addition{param ([double]$zahl1,[double] $zahl2)
            $result = $zahl1 + $zahl2
            Write-Host "Das Resultat der Addition von $zahl1 und $zahl2 ist $result."}
    
        function Get-Division{param ($zahl1, $zahl2)
            $result = $zahl1 / $zahl2
            Write-Host "Das Resultat der Division von $zahl1 durch $zahl2 ist $result."}

        function Get-Multiplikation{param ([double]$zahl1, [double]$zahl2)
            $result = $zahl1 * $zahl2
            Write-Host "Das Resultat der Multiplikation von $zahl1 mit $zahl2 ist $result."}

        function Get-Subtraktion{param ($zahl1, $zahl2)
            $result = $zahl1 - $zahl2
            Write-Host "Das Resultat der Subtraktion von $zahl1 minus $zahl2 ist $result."}

        function Get-Anweisung{
            Write-Host "Waehlen Sie zwischen den 4 Grundrechenoperationen:"
            Write-Host "1) Addition"
            Write-Host "2) Subtraktion"
            Write-Host "3) Multiplikation"
            Write-Host "4) Division"
            Write-Host "0) Script beenden"}
    
        do{Get-Anweisung
            $wahl = Read-Host "Geben Sie Ihre Wahl ein: "
            if($wahl -ne 0){
                 Write-Host "erste Zahl"
                 $zahl1 = Eingabe-Zahl
                 Write-Host "zweite Zahl"
                 $zahl2 = Eingabe-Zahl}
            switch ($wahl){
        0 {Write-Host "Das Script wird beendet"}
        1 {Get-Addition $zahl1 $zahl2}
        2 {Get-Subtraktion $zahl1 $zahl2}
        3 {Get-Multiplikation $zahl1 $zahl2}
        4 {Get-Division $zahl1 $zahl2}}
        }while($wahl -ne 0)} 
    
       14{function erzeuge-Zufallszahl{$zzahl = get-Random -Minimum 1 -Maximum 50   
            Write-Host $zzahl
            return $zzahl}
            
       function rate-Zufallszahl{Write-Host "Gesucht ist eine Zahl zwischen 1 und 50"
            $rzahl = Read-Host "Geben Sie Ihren Tipp ein: "
            while($rzahl -lt 1 -or $rzahl -gt 50){write-Host "Ungültige Eingabe!"
            $rzahl = Read-Host "Geben Sie einen neuen Tipp ein: "}
        
            return $rzahl}
    
       function vergleiche-Zahlen($zuzahl){$zaehler = 0

       do{$razahl = rate-Zufallszahl
            $zaehler++
    
       if($zuzahl -lt $razahl){write-Host "Die gesuchte Zahl ist kleiner als $razahl"}
        
       elseif($zuzahl -gt $razahl){write-Host "Die gesuchte Zahl ist grösser als $razahl"}
           
       else{Write-Host "Gratulation, Sie haben richtig geraten.
            Sie haben $zaehler Versuche gebraucht."}
            
       }while($zuzahl -ne $razahl)}              
        
            function wiederhole-Spiel{$nochmal = 1
       do{ $zufzahl = erzeuge-Zufallszahl
            vergleiche-Zahlen -zuzahl $zufzahl
            $nochmal = read-Host "Wollen Sie nochmals spielen? 1 --> ja, 2 --> nein "
       }while($nochmal -eq 1)}

       wiederhole-Spiel}

       15{do{Write-Host "Bitte whealen sie etwas aus: "
            Write-Host "E: zurück zum ersten Skript . "-ForegroundColor DarkYellow
            Write-Host "1: Nethzwerkkarte inhalt einzeigen "
            Write-Host "2: Nethzwehkarte konfigurirung"
            Write-Host "3: konfigurirung Nethzwehkarte zeigen"
            Write-Host "0: beneden"
            Write-Host "B: Datei erstelen mit alles"
       $wahl = Read-Host "Ihre Wahl: "
       switch($wahl){

       1{$inhatl= Get-NetAdapter 
       Read-Host $inhatl
       return $inhatl}

       2{
       $namenezwekkat= Write-Host "Bitte geben sie hire den Name der Netzwerkkarte ein:"
       $ID_or_IP= Write-Host "Bitte geben sie hire Namenoder IP-adresse von Nethzwerkkarte hinzu:"
       $supnezt= Write-Host "Bitte geben sie Hire supnetz maske hinzu:"
       $if_IPV4= Write-Host "und wenn hire if_IPV4 nemeh sie wenn  ja schreiben sie `n rein. / wenn ein Nein dann nicht:"
       New-NetIPAddress–IPAddress "$ID_or_IP" –InterfaceAlias "$namenezwekkat" –AddressFamily IPv4 –DefaultGateway "$if_IPV4" –PrefixLength "$supnezt"
       }

       3{$inhatl2 = Get-NetIPConfiguration
       Read-Host $inhatl2
       return $inhatl}

       "B"{do{
       $datiname = "bitte geben sie ein namen für neu datei zu erstelen:"
       $standort = "bitte geben sie den ort ei den sie es speichern wollen:"
       New-Item -Path "$datiname.txt" -ItemType "file"
       do{}
       #pfad
       
       
       
       }while($wahl -ne 0)}
       }
       
       
       
       }while($wahl -ne 0) 
       }



}
}while($wahl -ne 0)