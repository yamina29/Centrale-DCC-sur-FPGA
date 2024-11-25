# Centrale-DCC-sur-FPGA

Ce projet consiste à implémenter une Centrale DCC (Digital Command Control) sur un FPGA de la carte Basys pour commander des trains miniatures en utilisant le protocole DCC. Le système est conçu pour générer et transmettre des signaux de commande DCC afin de contrôler les locomotives et les accessoires dans le modélisme ferroviaire.


## Introduction

Le but de ce projet est de développer un système mixte matériel/logiciel capable de générer des signaux de commande DCC pour contrôler des locomotives et des accessoires dans le modélisme ferroviaire. Le système est implémenté sur un FPGA de la carte Basys et utilise le protocole DCC pour transmettre des commandes numériques directement sur les rails.

## Protocole DCC

Le protocole DCC utilise un signal numérique pulsé sur les voies pour transmettre des commandes. Chaque paquet DCC est composé de plusieurs champs, incluant un préambule, des bits de départ, des champs d'adresse et de commande, et un bit de contrôle. Les bits sont représentés par des impulsions de durées spécifiques pour différencier les bits à 0 et à 1.

### Structure d'un paquet DCC

- **Préambule**: Suite d'au moins 14 bits à 1.
- **Bit de départ**: 1 bit à 0.
- **Champ d'adresse**: Adresse de la locomotive à commander (1 octet).
- **Champ de commande**: Commande envoyée au train (de 1 à 2 octets).
- **Champ de contrôle**: XOR entre les octets des champs précédents (1 octet).
- **Bit d'arrêt**: 1 bit à 1.

## Architecture de la Centrale DCC

L'architecture de la Centrale DCC est composée de plusieurs modules interconnectés, chacun ayant une fonction spécifique dans la génération et la transmission des trames DCC.

![Architecture de la Centrale DCC](path/to/architecture_image.png)

### Modules du Projet

1. **Diviseur d'Horloge**: Génère un signal d'horloge de 1 MHz à partir de l'horloge de la carte.
2. **Tempo**: Mesure l'intervalle de temps entre deux trames DCC (6 ms).
3. **DCC_Bit_0 et DCC_Bit_1**: Génèrent des bits à 0 et à 1 au format DCC.
4. **Registre DCC**: Charge et transmet les trames DCC bit par bit.
5. **MAE (Machine à États)**: Coordonne les actions des différents modules et génère la trame de commande DCC.
6. **Générateur de Trames de Test**: Génère des trames DCC de test pour valider l'architecture.


### Prérequis

- Vivado
- Carte Basys
- Oscilloscope (pour la validation)
