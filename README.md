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

Version français : 

Une fois que l'application est lancée, une page de connexion apparaît, demandant un nom d'utilisateur : "Florian" et un mot de passe : "Root". Une fois connecté, une petite roue crantée apparaît en haut à droite de l'interface. Il faut cliquer dessus pour accéder aux paramètres de l'application, se connecter au broker avec l'adresse suivante : 172.16.5.103. On peut également régler les valeurs maximale et minimale du CO2, ainsi que la langue de l'application. Ensuite, toujours sur la même page, il faut entrer les topics nécessaires pour recevoir les informations. Les topics sont les suivants : "CO2" et "TVOC". Une fois les topics entrés, on peut retourner sur la page principale pour voir les valeurs.

English version : 

Once the application is launched, a login page appears asking for a username: "Florian" and a password: "Root". Once logged in, a small gear icon appears at the top right of the interface. Clicking on it allows access to the application settings, where you can connect to the broker with the following address: 172.16.5.103. You can also adjust the maximum and minimum CO2 values and set the language of the application. Then, on the same page, you need to enter the necessary topics to receive the information. The topics are: "CO2" and "TVOC". Once the topics are entered, you can return to the main page to see the values.

# Route vers l'api

IP de l'api : 172.16.6.53:8080

* http://172.16.6.53:8080/api/login
* http://172.16.6.53:8080/api/getParametre
http://172.16.6.53:8080/api/parametre
