# Slinkys MITM

#Setting
Impostare il nostro IP locale sulla macchina della target, supponiamo che sia 192.168.1.24
Settiamo il nostro ip come proxy e impostiamo una porta, nel mio caso 8080

#Run
Ora possiamo avviare e iniettare tutto ciò che vogliamo.

Usage:Slinkys [Options] [Command]
-a, --attribute        Replace all Link on page| -a [URL]
-f, --form             Replace form action | -f [url/evil.php]
-i, --image            Image replace | -i [URL Image]
-l, --log              Create File Log | -l log.txt
-p, --port             Port on listan | -p 8000 (default is 8080)
-s, --script           Injection Script | -s script.js
-t, --title            Change Title Page | -t 'You Text'
-y, --youtube          Replace youtube video | -y [YouTube Link]


