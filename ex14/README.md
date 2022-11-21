<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://www.krescentglobal.com/images/iphone/cobol-1.png" alt="COBOL LOGO"></a>
</p>

<h3 align="center">COBOL POE - Part 1</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/emericdefay/forma-cobol-1.svg)](https://github.com/emericdefay/forma-cobol-1/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/emericdefay/forma-cobol-1.svg)](https://github.com/emericdefay/forma-cobol-1/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

PGM014(FC/FS) are copybooks.  
File014(1/2) are source files (inputs).  
Be sure to verify JCL to make sure that work on you zOS.  

<p align="center"> Exercice 12
    <br> 
</p>


<p align="center">
Formation COBOL -  Appareillage de fichiers

## 1.	Objectif de la fiche :  

Cette fiche est consacrée à l’appareillage (ou synchronisation) de deux fichiers séquentiels.
 
## 2.	Cas pratique :  

On se propose de comparer deux fichiers FENTREE1 et FENTREE2 triés sur le même argument COMPTE et écrire les résultats de comparaison dans 3 fichiers de sortie FSORTIE1, FSORTIE2 et FSORTIE3 en respectant  les règles de gestion suivantes :
-	Si un enregistrement existe dans FENTREE1 et existe dans FENTREE2 l’écrire dans FSORTIE1
-	Si un enregistrement existe dans FENTREE1 et n’existe pas dans FENTREE2 l’écrire dans FSORTIE2
-	Si un enregistrement n’existe pas dans FENTREE1 et existe dans FENTREE2 l’écrire dans FSORTIE3

Les 5 fichiers ont la même structure CENTREE.    (à créer dans IBMUSER.COB.COPY)
```cbl
01 ()-ENREG.
     02 ()-COMPTE  PIC 9(6).
     02 ()-NOM     PIC X(20).
     02 ()-DATE    PIC X(10).
     02 FILLER      PIC X(44).
```

## 3.	Algorithme proposé :

Procédure APPAREILLAGE
```algo
               Début
                            Initialisation des compteurs de lecture et d’écriture
                            Ouverture des 5 fichiers 
                            Lecture du premier enregistrement FENTREE1
Lecture du premier enregistrement FENTREE2
                            Faire jusqu’à la fin du fichier FENTREE1 et fin du fichier FENTREE2
                                      Si FENTREE1.COMPTE = FENTREE2.COMPTE 
			       Ecrire l’un des enregistrements dans FSORTIE1
		                     Lecture du premier enregistrement FENTREE1
		                     Lecture du premier enregistrement FENTREE2
			  FinSi
                                      Si FENTREE1.COMPTE > FENTREE2.COMPTE ou Fin Fichier FENTREE1
			       Ecrire l’enregistrement FENTREE1 dans FSORTIE2
		                     Lecture du premier enregistrement FENTREE2
			  FinSi

                                      Si FENTREE1.COMPTE <FENTREE2.COMPTE ou Fin Fichier FENTREE1
			              Ecrire l’enregistrement FENTREE2 dans FSORTIE3
		                            Lecture du premier enregistrement FENTREE1
			  FinSi
                             FinFaire
                Fin
Fin Procédure
```
## 4.	Etapes à suivre pour l’écriture du programme

-	Créer un paragraphe d’ouverture des fichiers avec gestion des erreurs qu’on appellera OUVERTURE-FICHIERS
-	Créer deux paragraphes de lecture des deux fichiers FENTREE1 et FENTREE2  avec gestion des erreurs qu’on appellera respectivement LECTURE-FENTREE1 et LECTURE-FENTREE2
En cas de fin de fichier alimenter ‘999999’  dans COMPTE
-	Créer un paragraphe TRAITEMENT qui transcode la boucle Faire 
-	Créer 3 paragraphes d’écriture des fichiers FSORTIE1, FSORTIE2 et FSORTIE3 avec gestion des erreurs et qu’on appellera ECRITURE-FSORTIE1, FSORTIE2 et FSORTIE3
-	Créer un paragraphe de fermeture des fichiers avec gestion des erreurs qu’on appellera FERMETURE-FICHIERS
-	Construire le programme avec les modules cités ci-dessus et compléter-le afin qu’il traduise l’algorithme proposé au point 3

## 5.	Compilation et exécution

-	Compiler le programme GKDISP20
-	Via File Manager ou via 3.4 (Edit), créer des enregistrements dans FENTREE1 et FENTREE2 pour le test
- Tester le cas des deux fichiers FENTREE1 et FENTREE 2 vides
- Tester le cas de FENTREE1 vide et FENTREE2 non vide 
- Tester le cas de FENTREE1 non vide FENTREE2 vide 
- Tester le cas où on aura les 3 fichiers en sortie renseignés


</p>