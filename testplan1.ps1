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
        0 {Write-Host "Das Skript wird beendet"}

        1 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der neuen Datei ein (ohne Dateiendung): "
            New-Item -Path "$path.txt" -ItemType "file"
        }

        2 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der zu löschenden Datei ein (ohne Dateiendung): "
            Remove-Item "$path.txt"
        }

        3 {
            $text = Read-Host "Geben Sie den Text ein, der in die Datei geschrieben werden soll: "
            $path = Read-Host "Geben Sie den Pfad und den Namen der Datei an, in die der Text geschrieben werden soll: "
            $text | Out-File -FilePath "$path.txt" -Append
        }

        4 {
            $path = Read-Host "Geben Sie den Pfad und den Namen der zu lesenden Datei ein: "
            $inhalt = Get-Content $path
            Write-Host $inhalt
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
            function geldBetrag {
                do {
                    $betrag = Read-Host "Für welchen Betrag wollen Sie die Zinserträge berechnen?"
                    if ($betrag -le 0) {
                        Write-Host "Der eingegebene Betrag muss größer als Null sein!"
                    } else {
                        $betrag
                    }
                } while ($betrag -le 0)
            }
            
            function zinsSatz {
                do {
                    $zins = Read-Host "Mit welchem Zinssatz soll gerechnet werden?"
                    if ($zins -le 0) {
                        Write-Host "Der eingegebene Zinssatz muss größer als Null sein!"
                    } else {
                        $zins
                    }
                } while ($zins -le 0)
            }
    
            function berechnung {
                param($betrag, $zins)
                $zins = $zins / 100 + 1 
                Write-Host "Startbetrag: $betrag"
                Write-Host "Zinssatz: $zins"
                Write-Host "Entwicklung des Betrags über 10 Jahre:"
                for ($i = 1; $i -le 10; $i++) {
                    [double]$betrag = $betrag * $zins
                    Write-Host "Jahr $i : $betrag"
                }
            }

            do {
                Write-Host "Das Skript berechnet die Entwicklung eines Geldbetrags über 10 Jahre bei einem fixen Zinssatz"
                $betrag = geldBetrag
                $zins = zinsSatz
                berechnung -betrag $betrag -zins $zins
                $wieder = Read-Host "Wollen Sie noch eine Berechnung machen? (1 --> ja)"
            } while ($wieder -eq 1)
        }
        
        13 {
            function Eingabe-Zahl {
                $zahl = Read-Host "Geben Sie eine Zahl ein"
                return $zahl
            }
    
            function Get-Addition {
                param ([double]$zahl1, [double]$zahl2)
                $result = $zahl1 + $zahl2
                Write-Host "Das Resultat der Addition von $zahl1 und $zahl2 ist $result."
            }
    
            function Get-Division {
                param ($zahl1, $zahl2)
                $result = $zahl1 / $zahl2
                Write-Host "Das Resultat der Division von $zahl1 durch $zahl2 ist $result."
            }

            function Get-Multiplikation {
                param ([double]$zahl1, [double]$zahl2)
                $result = $zahl1 * $zahl2
                Write-Host "Das Resultat der Multiplikation von $zahl1 mit $zahl2 ist $result."
            }

            function Get-Subtraktion {
                param ($zahl1, $zahl2)
                $result = $zahl1 - $zahl2
                Write-Host "Das Resultat der Subtraktion von $zahl1 minus $zahl2 ist $result."
            }

            function Get-Anweisung {
                Write-Host "Wählen Sie zwischen den 4 Grundrechenoperationen:"
                Write-Host "1) Addition"
                Write-Host "2) Subtraktion"
                Write-Host "3) Multiplikation"
                Write-Host "4) Division"
                Write-Host "0) Skript beenden"
            }
    
            do {
                Get-Anweisung
                $wahl = Read-Host "Geben Sie Ihre Wahl ein: "
                if ($wahl -ne 0) {
                    Write-Host "Erste Zahl"
                    $zahl1 = Eingabe-Zahl
                    Write-Host "Zweite Zahl"
                    $zahl2 = Eingabe-Zahl
                }
                switch ($wahl) {
                    0 {Write-Host "Das Skript wird beendet"}
                    1 {Get-Addition $zahl1 $zahl2}
                    2 {Get-Subtraktion $zahl1 $zahl2}
                    3 {Get-Multiplikation $zahl1 $zahl2}
                    4 {Get-Division $zahl1 $zahl2}
                }
            } while ($wahl -ne 0)
        }
    
        14 {
            function erzeuge-Zufallszahl {
                $zzahl = Get-Random -Minimum 1 -Maximum 50   
                return $zzahl
            }
            
            function rate-Zufallszahl {
                Write-Host "Gesucht ist eine Zahl zwischen 1 und 50"
                $rzahl = Read-Host "Geben Sie Ihren Tipp ein: "
                while ($rzahl -lt 1 -or $rzahl -gt 50) {
                    Write-Host "Ungültige Eingabe!"
                    $rzahl = Read-Host "Geben Sie einen neuen Tipp ein: "
                }
                return $rzahl
            }
    
            function vergleiche-Zahlen($zuzahl) {
                $zaehler = 0
                do {
                    $razahl = rate-Zufallszahl
                    $zaehler++
    
                    if ($zuzahl -lt $razahl) {
                        Write-Host "Die gesuchte Zahl ist kleiner als $razahl"
                    } elseif ($zuzahl -gt $razahl) {
                        Write-Host "Die gesuchte Zahl ist größer als $razahl"
                    } else {
                        Write-Host "Gratulation, Sie haben richtig geraten. Sie haben $zaehler Versuche gebraucht."
                    }
                } while ($zuzahl -ne $razahl)
            }
            
            function wiederhole-Spiel {
                do {
                    $zufzahl = erzeuge-Zufallszahl
                    vergleiche-Zahlen -zuzahl $zufzahl
                    $nochmal = Read-Host "Wollen Sie nochmals spielen? 1 --> ja, 2 --> nein"
                } while ($nochmal -eq 1)
            }

            wiederhole-Spiel
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
