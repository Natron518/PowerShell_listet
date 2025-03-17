Write-Output "========================================================="
Write-Host "<              hello and welcome to my                 >" -ForegroundColor Green
Write-Host "<               Nathalie's Menu items                  >" -ForegroundColor Green
Write-Output "========================================================= `n "

do {
    Write-Host "Bitte wählen Sie etwas aus: `n"
   
    Write-Host "0: Skript beenden." -ForegroundColor Red
    Write-Host "1: Textdatei erstellen." -ForegroundColor Gray
    Write-Host "2: Textdatei löschen." -ForegroundColor Gray
    Write-Host "3: In Textdatei schreiben." -ForegroundColor Gray
    Write-Host "4: Aus Textdatei lesen." -ForegroundColor Gray
    Write-Host "5: Benutzerkonto erstellen." -ForegroundColor Gray
    Write-Host "6: Benutzerkonto löschen." -ForegroundColor Gray
    Write-Host "7: Passwort ändern." -ForegroundColor Gray
    Write-Host "8: Gruppe erstellen." -ForegroundColor Gray
    Write-Host "9: Gruppe löschen." -ForegroundColor Gray
    Write-Host "10: Benutzer einer Gruppe hinzufügen." -ForegroundColor Gray
    Write-Host "11: Benutzer aus einer Gruppe löschen." -ForegroundColor Gray
    Write-Host "12: Zinsenrechner." -ForegroundColor Cyan
    Write-Host "13: Rechner." -ForegroundColor Yellow
    Write-Host "14: Rate-Spiel." -ForegroundColor Green
    Write-Host "15: Test 11.5.2023"

    $wahl = Read-Host "Ihre Wahl: "

    switch ($wahl) {
        0 {
            Write-Host "Das Skript wird beendet." -ForegroundColor Red
            break}

        1 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der neuen Datei ein (ohne Dateiendung .txt): "
            try{
                New-Item -Path "$path.txt" -ItemType "file" -ErrorAction Stop
                Write-Host "Wurde erfolgreich erstellt: $path.txt" -ForegroundColor Green
            } catch{
                Write-Host "---- Error: Die Datei konnte nicht erstellt werden. ----" -ForegroundColor Red
            }
        }

        2 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der zu löschenden Datei ein (ohne Dateiendung .txt): "
            if(Test-Path "$path.txt") {
                Remove-Item "$path.txt"
                Write-Host "Datei gelöscht: $path.txt" -ForegroundColor Green
            } else{
                Write-Host "Fehler: Datei existiert nicht!" -ForegroundColor Red
            }
     
        }

        3 {
           $path = Read-Host "Geben Sie den Pfad und den Namen der Datei an, in die der Text geschrieben werden soll: "
            if(Test-Path "$path.txt"){}
                $text = Read-Host "Geben Sie den Text ein"
                $text | Out-File -FilePath "$path.txt" -Append
                Write-Host "Text wurde in die Datei geschrieben." -ForegroundColor Green
            } else{ 
                Write-Host "Fehler: Datei existiert nicht!" -ForegroundColor Red
            }

        4 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der zu lesenden Datei ein: "
            if(Test-Path $path){
                 Get-Content $path | ForEach-Object { Write-Host $_ }
            }else {
                Write-Host "Fehler: Datei existiert nicht!" -ForegroundColor Red
            }
           
        }

        5 {
            $user = Read-Host "Geben Sie den Namen des neuen Benutzers ein: "
            $voll = Read-Host "Geben Sie den Vor- und Nachnamen ein: "
            $pass = Read-Host -AsSecureString "Geben Sie das Passwort für den neuen Benutzer ein: "
            New-LocalUser -Name $user -FullName $voll -Password $pass
        }

        6 {
            $user = Read-Host "Geben Sie den Namen des zu löschenden Benutzerkontos ein: "
            Remove-LocalUser -Name $user
        }

        7 {
            $user = Read-Host "Geben Sie den Benutzernamen ein: "
            $pass = Read-Host -AsSecureString "Geben Sie das neue Passwort ein: "
            Set-LocalUser -Name $user -Password $pass
        }

        8 {
            $gruppe = Read-Host "Geben Sie den Namen der neuen Gruppe ein: "
            New-LocalGroup $gruppe
        }

        9 {
            $gruppe = Read-Host "Geben Sie den Namen der zu löschenden Gruppe ein: "
            Remove-LocalGroup $gruppe
        }

        10 {
            $user = Read-Host "Welcher Benutzer soll einer Gruppe hinzugefügt werden? "
            $gruppe = Read-Host "Welcher Gruppe soll der Benutzer hinzugefügt werden? "
            Add-LocalGroupMember -Name $gruppe -Member $user
        }

        11 {
            $user = Read-Host "Welcher Benutzer soll aus einer Gruppe entfernt werden? "
            $gruppe = Read-Host "Aus welcher Gruppe soll der Benutzer entfernt werden? "
            Remove-LocalGroupMember -Name $gruppe -Member $user
        }

        12 {
            function berechne-Zinsen {
                param([double]$betrag, [double]$zins)
                $zins = $zins / 100 + 1 
                Write-Host "Startbetrag: $betrag€"
                Write-Host "Jährlicher Zinssatz: $zins%"
                Write-Host "Entwicklung des Betrags über 10 Jahre:"
                for ($i = 1; $i -le 10; $i++) {
                    $betrag = [math]::Round($betrag * $zins, 2)
                    Write-Host "Jahr $i : $betrag€"
                }
            }

            $betrag = Read-Host "Startbetrag (€)"
            $zins = Read-Host "Zinssatz (%)"
            if ([double]$betrag -gt 0 -and [double]$zins -gt 0) {
                berechne-Zinsen -betrag $betrag -zins $zins
            } else {
                Write-Host "Fehler: Betrag und Zinssatz müssen größer als 0 sein!" -ForegroundColor Red
            }
        }
        
        13 {

            function Get-Anweisung {
                Write-Host "Wählen Sie zwischen den 4 Grundrechenoperationen:"
                Write-Host "1) Addition"
                Write-Host "2) Subtraktion"
                Write-Host "3) Multiplikation"
                Write-Host "4) Division"
                Write-Host "0) zurück"
            }

            function Eingabe-Zahl {
                $zahl = Read-Host "Geben Sie eine Zahl ein"
                return $zahl
            }
    
             do {
                Get-Anweisung
                $wahl = Read-Host "Geben Sie Ihre Wahl ein: "
                if ($wahl -ne 0) {
                    [double]$zahl1 = Read-Host "Geben Sie die erste Zahl ein"
                    [double]$zahl2 = Read-Host "Geben Sie die zweite Zahl ein"
                }
                switch ($wahl) {
                    0 {Write-Host "Das Skript wird beendet" -ForegroundColor Red}
                    1 {Write-Host "Ergebnis:  $($zahl1 + $zahl2)"}
                    2 {Write-Host "Ergebnis:  $($zahl1 - $zahl2)"}
                    3 {Write-Host "Ergebnis:  $($zahl1 * $zahl2)"}
                    4 {if ($zahl2 -eq 0){ Write-Host "Fehler: Division Error-" -ForegroundColor Red}
                    else{
                        Write-Host "Ergebnis:  $($zahl1 / $zahl2)"}
                    }
                }
            } while ($wahl -ne 0)
        }

        14 {
            function rate-Spiel {
                $zufallszahl = Get-Random -Minimum 1 -Maximum 50
                Write-Host "Errate die Zahl zwischen 1 und 50!"
                $versuche = 0

                do {
                    [int]$tipp = Read-Host "Ihr Tipp"
                    $versuche++

                    if ($tipp -lt $zufallszahl) {
                        Write-Host "Die gesuchte Zahl ist größer." -ForegroundColor Yellow
                    } elseif ($tipp -gt $zufallszahl) {
                        Write-Host "Die gesuchte Zahl ist kleiner." -ForegroundColor Yellow
                    } else {
                        Write-Host "Richtig! Sie haben die Zahl in $versuche Versuchen erraten!" -ForegroundColor Green
                    }
                } while ($tipp -ne $zufallszahl)
            }

            rate-Spiel
        }

        15 {
            do {
                Write-Host "Bitte wählen Sie etwas aus: "
                Write-Host "E: Zurück zum ersten Skript." -ForegroundColor DarkYellow
                Write-Host "1: Netzwerkkarte Inhalt anzeigen."
                Write-Host "2: Netzwerkkarte Konfiguration."
                Write-Host "3: Konfiguration der Netzwerkkarte anzeigen."
                Write-Host "0: Beenden"
                Write-Host "B: Datei erstellen mit allem."

                $wahl = Read-Host "Ihre Wahl: "
                switch ($wahl) {
                    1 {
                        $inhalt = Get-NetAdapter 
                        Write-Host $inhalt
                    }

                    2 {
                        $namenezwekkat = Read-Host "Bitte geben Sie den Namen der Netzwerkkarte ein: "
                        $ID_or_IP = Read-Host "Bitte geben Sie die IP-Adresse der Netzwerkkarte ein: "
                        $supnezt = Read-Host "Bitte geben Sie Ihre Subnetzmaske ein: "
                        $if_IPV4 = Read-Host "Soll IPv4 verwendet werden? (ja/nein): "
                        if ($if_IPV4 -eq "ja") {
                            New-NetIPAddress -IPAddress $ID_or_IP -InterfaceAlias $namenezwekkat -AddressFamily IPv4 -PrefixLength $supnezt
                        }
                    }

                    3 {
                        $inhalt2 = Get-NetIPConfiguration
                        Write-Host $inhalt2
                    }

                    "B" {
                        $datiname = Read-Host "Bitte geben Sie einen Namen für die neue Datei ein: "
                        $standort = Read-Host "Bitte geben Sie den Speicherort an: "
                        New-Item -Path "$standort\$datiname.txt" -ItemType "file"
                    }
                }
            } while ($wahl -ne 0)
        }
    }
} while ($wahl -ne 0)
