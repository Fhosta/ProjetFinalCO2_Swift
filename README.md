# Introduction 

Version français : 

L'application est réalisée en Swift (Apple) et permet de visualiser en temps réel les mesures effectuées par notre capteur de CO2. Elle se connecte à un broker Mosquitto, l'utilisateur entre les topics définis et récupère la réponse du capteur. Elle permet également de régler les limites maximale et minimale pour les valeurs de CO2, le tout connecté à une API pour récupérer les valeurs.


English version : 

The application is built in Swift (Apple) and allows real-time monitoring of the measurements taken by our CO2 sensor. It connects to a Mosquitto broker, where the user enters the defined topics and retrieves the sensor response. It also enables the user to set the maximum and minimum limits for CO2 values, all connected to an API for value retrieval.

#Installation 

Version français : 

Il est possible de cloner mon dépôt Git soit depuis le terminal en utilisant la commande : https://github.com/Fhosta/ProjetFinalCO2_Swift.git, 
soit en lançant directement Xcode et en clonant le projet depuis l'application.

English version : 

It is possible to clone my Git repository either from the terminal using the command: https://github.com/Fhosta/ProjetFinalCO2_Swift.git, or by launching Xcode directly and cloning the project from within the application.

# Guide d'utilisation :

Une fois l'application lancé une page de Connexion apparait demandant un nom d'utilisateur : "Florian" et un mot de passe : "Root"  une fois connecté  


# Route vers l'api

IP de l'api : 172.16.6.53:8080

* http://172.16.6.53:8080/api/login
* http://172.16.6.53:8080/api/getParametre
http://172.16.6.53:8080/api/parametre
