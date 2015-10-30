# Entwicklungsumgebung

-- TODO: complete

- node.js
- grunt
- bower
- yeoman
- webapp
- reload
- generator-element
- generator-polymer

siehe tut: https://www.youtube.com/watch?v=ATPXN1-AWs8

## VM Einrichten

- Virtual Box installieren
- Vagrant installieren
- xshell installieren
- "vagrant box add Ubuntu64 http://files.vagrantup.com/lucid64.box" um die box herunter zu laden
- git clone https://github.com/Glur4k/BATHWebComponents (Arbeitsverzeichnis - *AZ*)
- In *AZ* wechseln
- "vagrant up" - Lädt Box herunter und installiert alles - Kann einige Minuten dauern
- "vagrant status" - Zeigt ob Box läuft
- "vagrant ssh" - zeigt anmeldedaten
- in xShell neue Session anlegen mit den obigen anmeldedaten
- mit xShell Verbindung herstellen
- "work" ist ein alias auf das Arbeitsverzeichnis in der VM

Zu erst VirtualBox (Link: https://www.virtualbox.org/wiki/Downloads) installieren, wird benötigt um vagrant auszuführen. Danach vagrant (Link: http://downloads.vagrantup.com/) installieren. Sinnvoll ist auch ein ssh client wie z.b. xShell (free, Link: https://www.netsarang.com/download/free_license.html). Um xShell zu starten eine lokale shell in xShell öffnen. Nun prüfen ob vagrant funktioniert mit "vagrant". nun muss eine Box heruntergeladen werden. (Boxen sind zu finden auf http://www.vagrantbox.es/) In diesem Fall wird die "Ubuntu lucid 64" (Link: http://files.vagrantup.com/lucid64.box) heruntergeladen. Dies erfolgt mit dem befehl "vagrant box add Ubuntu64 http://files.vagrantup.com/lucid64.box", nun wird die Box heruntergeladen, das kann einige Minuten dauern. mit "vagrant box list" kann überprüft werden ob die Box vorhanden ist. Wenn die "Ubuntu32" gelistet wird kann sie immer wieder verwendet werden. Nun wechselt man in das bevorzugte verzeichnis, in dem man die Box laufen lassen will. In diesem fall wird einfach auf den Desktop/schreibtisch gewechselt und der befehl "mkdir vagrant" ausgeführt, da dort die box installiert werden soll. Nun wechselt man in das verzeichnis und initialiert die Box mit "vagrant init Ubuntu32". Darauf hin wird eine vagrantfile erzeugt, die configurationsdatei. Diese kann mit dem bevorzugten Editor geöffnet werden, in diesem Fall Sublime Text. Dort wird als einziges die Variable "config.vm.network" angepasst. Die Zeile wird auskommentiert und die IP nach belieben angepasst. In diesem Fall wird die IP "192.168.33.10" angegeben. Nun kann die Box gestartet werden mit "vagrant up". Als nächstes muss ein Webserver auf der box installiert werden. Hierzu wird in xShell eine neue Session mit den Einstellungen der Box erstellt.
Wenn nun versucht wird mit "vagrant ssh" eine ssh verbindung zu der box zu öffnen werden die ssh anmeldeinformationen angezeigt.
Also muss eine neue Verbindung in xShell angelegt werden unter "Datei" > "Neu". Dort wird der bevorzugte Name der Verbindung und die Anmeldeinformationen eingetragen *(Details? Anmeldeart key und speicherort etc?)*. Unter "Datei" > "Öffnen" ist jetzt die Verbindung angelegt und sie kann geöffnet werden. Nun sind wir in der Ubuntu32 Virtuellen Maschine angemeldet. Als nächstes muss ein webserver installiert werden. In diesem Fall Apache2, somit wird der Befehl "sudo apt-get install apache2" ausgeführt und der Server wird installiert.
Wenn nun im Browser die IP "192.168.33.10" geöffnet wird, erscheint die Webseite "It Works!". Die Seite ligt in der VM unter "/var/www". Um nicht in der VM, sondern in Windows/OSX zu arbeiten wird ein Symlink zu dem vagrant ordner auf unserem Desktop/Schreibtisch erstellt. Zuerst wird der /var/www Ordner gelöscht, danach der Symlink mit "sudo ln -fs /vagrant /var/www" erzeugt. Wenn nun der Browser geöffnet und aktualiesiert wird, wird das *Arbeitsverzeichnis* angezeigt.


Zur Hilfe genommen wird ebenfalls GIT und ein öffentliches Repository auf Github (https://github.com/Glur4k/BATHWebComponents).

Eingesetzte Tools:
- vagrant
- Sublime Text
- Git
- Google Chrome (v46)
- Firefox (v41.0.2)
