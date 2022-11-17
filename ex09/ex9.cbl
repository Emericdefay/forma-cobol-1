      *****************************************************************
      * Program name:    PGM009
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameter : i.e. 75    
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM009.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
      / Departments of HELL
       01  DEPARTEMENTS-IDF.
           05 FILLER PIC X(25) VALUE '75 Paris'.
           05 FILLER PIC X(25) VALUE '77 Seine-et-Marne'.
           05 FILLER PIC X(25) VALUE '78 Yvelines'.
           05 FILLER PIC X(25) VALUE '91 Essonne'.
           05 FILLER PIC X(25) VALUE '92 Hauts-de-Seine'.
           05 FILLER PIC X(25) VALUE '93 Seine-Saint-Denis'.
           05 FILLER PIC X(25) VALUE '94 Val-de-Marne'.
           05 FILLER PIC X(25) VALUE "95 Val-d'Oise".
      / Copy of HELL -> Switzerland?
       01  TABLEAU REDEFINES DEPARTEMENTS-IDF.
           05 WS-ELEMENT OCCURS 8 TIMES INDEXED BY I.
              10 WS-NUM-DEPT   PIC 9(02).
              10 FILLER        PIC X(01).
              10 WS-NOM-DEPT   PIC X(22).
      / WS variables 
       01  WS-TABLE-IX    PIC 9(05).
       01  WS-FS-RL       PIC 9(05) VALUE 0.
       01  WS-FS-TL       PIC 9(05) VALUE 0.
       01  WS-FS-FL       PIC 9(05) VALUE 0.
      / Parameter from JCL run 
       01  PJ-DEPT        PIC 9(02).
      / Defaults values to parameters
       01  PJ-DEPT-DEF    PIC 9(02) VALUE 75. 
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARMS THRU 000-EXIT.
           PERFORM 100-FILER THRU 100-EXIT.
           PERFORM 200-DISPV THRU 200-EXIT.
           PERFORM 300-EXITP THRU 300-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine handle parameter(s).
      *****************************************************************
       000-PARMS.
           ACCEPT PJ-DEPT.
           IF PJ-DEPT = SPACE OR LOW-VALUE THEN
              PERFORM 001-DEFVA
           END-IF.
       000-EXIT. 
           EXIT.
      *****************************************************************
      *  This routine put default value(s) to variable(s)
      *****************************************************************
       001-DEFVA.
           MOVE PJ-DEPT-DEF TO PJ-DEPT.
      *****************************************************************
      *  This routine should set and manipulate array table.
      *****************************************************************
       100-FILER.
           SET I TO 1.
           PERFORM 110-CHECK.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  This routine should search WS-NUM-DEPT thru WS-ELEMENTs.
      *****************************************************************
       110-CHECK.
           SEARCH WS-ELEMENT 
              AT END DISPLAY 'DEPT : ' PJ-DEPT ' NOT FOUND.'
              WHEN WS-NUM-DEPT (I) = PJ-DEPT 
              PERFORM 120-DISPL
           END-SEARCH.  
      *****************************************************************
      *  This routine should display a line of the array.
      *****************************************************************
       120-DISPL.
           DISPLAY WS-ELEMENT (I).
      *****************************************************************
      *  This routine should display variables (if any).
      *****************************************************************
       200-DISPV.
           DISPLAY "200-DISPV".
           DISPLAY "    PJ-CHR : " PJ-DEPT.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program (after some displays).
      *****************************************************************
       300-EXITP.
           DISPLAY "300-EXITP".
       300-EXIT.
           EXIT.