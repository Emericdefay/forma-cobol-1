      *****************************************************************
      * Program name:    PGM010
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameter : i.e. 1000    
      *                                                 A    
      *                                                 5    
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM010.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
      / Primes for seniority <= 4 years
       01  PRIMES-YOUNG.
           05 FILLER PIC X(19) VALUE 'A 0000000 A 0000200'.
           05 FILLER PIC X(19) VALUE 'A 0000001 A 0000200'.
           05 FILLER PIC X(19) VALUE 'A 0000002 A 0000300'.
           05 FILLER PIC X(19) VALUE 'A 0000003 A 0000300'.
           05 FILLER PIC X(19) VALUE 'A 0000004 A 0000300'.
           05 FILLER PIC X(19) VALUE 'B 0000000 A 0000100'.
           05 FILLER PIC X(19) VALUE 'B 0000001 A 0000100'.
           05 FILLER PIC X(19) VALUE 'B 0000002 A 0000150'.
           05 FILLER PIC X(19) VALUE 'B 0000003 A 0000150'.
           05 FILLER PIC X(19) VALUE 'B 0000004 A 0000150'.
           05 FILLER PIC X(19) VALUE 'C 0000000 A 0000050'.
           05 FILLER PIC X(19) VALUE 'C 0000001 A 0000050'.
           05 FILLER PIC X(19) VALUE 'C 0000002 A 0000100'.
           05 FILLER PIC X(19) VALUE 'C 0000003 A 0000100'.
           05 FILLER PIC X(19) VALUE 'C 0000004 A 0000100'.

       01  PRIMES-R-YOUNG REDEFINES PRIMES-YOUNG.
           05 WS-PRIME-ALL OCCURS 15 TIMES INDEXED BY IY.
              10 WS-NOTE       PIC X(01).
              10 FILLER        PIC X(01).
              10 WS-ANC        PIC 9(07).
              10 FILLER        PIC X(01).
              10 WS-OPERATION  PIC X(01).
              10 FILLER        PIC X(01).
              10 WS-PRIME-DUE  PIC 9(07).

      / Primes for seniority > 4 years
       01  PRIMES-OLD.
           05 FILLER PIC X(19) VALUE 'A A 0000400'.
           05 FILLER PIC X(19) VALUE 'B A 0000200'.
           05 FILLER PIC X(19) VALUE 'C A 0000150'.

       01  PRIMES-R-OLD REDEFINES PRIMES-OLD.
           05 WS-PRIME-ALL OCCURS 15 TIMES INDEXED BY IO.
              10 WS-NOTE       PIC X(01).
              10 FILLER        PIC X(01).
              10 WS-OPERATION  PIC X(01).
              10 FILLER        PIC X(01).
              10 WS-PRIME-DUE  PIC 9(07).

      / WS variables 
       01  WS-AUG         PIC 9(07).
       01  WS-PRIME-F     PIC 9(07).

      / Parameter from JCL run 
       01  PJ-PRIME-I     PIC 9(07).
       01  PJ-NOTE        PIC X(01).
       01  PJ-ANC         PIC 9(07).
           88 B0-1 VALUE 0 THRU 1. 
           88 B2-4 VALUE 2 THRU 4.

      / Defaults values to parameters
       01  PJ-PRIME-I-DEF PIC 9(07) VALUE 0001000. 
       01  PJ-NOTE-DEF    PIC X(01) VALUE 'A'.
       01  PJ-ANC-DEF     PIC 9(07) VALUE 0000003. 

      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARMS.
           PERFORM 100-FILER THRU 100-EXIT.
           PERFORM 200-DISPV THRU 200-EXIT.
           PERFORM 300-EXITP THRU 300-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine handle parameters
      *****************************************************************
       000-PARMS.
           ACCEPT PJ-PRIME-I.
           ACCEPT PJ-NOTE.
           ACCEPT PJ-ANC.
           IF PJ-PRIME-I = SPACE OR LOW-VALUE THEN
              PERFORM 001-DEFVA
           END-IF.
           IF PJ-NOTE    = SPACE OR LOW-VALUE THEN
              PERFORM 002-DEFVA
           END-IF.
           IF PJ-ANC     = SPACE OR LOW-VALUE THEN
              PERFORM 003-DEFVA
           END-IF.
       001-DEFVA.
           MOVE PJ-PRIME-I-DEF TO PJ-PRIME-I.
       002-DEFVA.
           MOVE PJ-NOTE-DEF    TO PJ-NOTE.
       003-DEFVA.
           MOVE PJ-ANC-DEF     TO PJ-ANC.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       100-FILER.
           SET IO TO 1.
           SET IY TO 1.
           IF NOT (B0-1 OR B2-4)
               PERFORM 110-OLD-NOTE
           ELSE
               PERFORM 111-YOUNG-ANC-NOTE
           END-IF.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  Check the note of the user and display prime to pay
      *****************************************************************
       110-OLD-NOTE.
           SEARCH WS-PRIME-ALL OF PRIMES-R-OLD 
                 AT END DISPLAY 'ERROR'
                 WHEN WS-NOTE OF PRIMES-R-OLD (IO) = PJ-NOTE 
                    PERFORM 110-OLD
           END-SEARCH.
           PERFORM 120-DISPL.
      *****************************************************************
      *  Check if it's an addition or a substraction
      *****************************************************************
       110-OLD.
           IF WS-OPERATION OF PRIMES-R-OLD (IO) = 'A'
                 MOVE WS-PRIME-DUE OF PRIMES-R-OLD (IO) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I + 
                         WS-PRIME-DUE OF PRIMES-R-OLD (IO)
           ELSE
                 MOVE WS-PRIME-DUE OF PRIMES-R-OLD (IO) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I - 
                         WS-PRIME-DUE OF PRIMES-R-OLD (IO)
           END-IF.
      *****************************************************************
      *  Check the note and the seniority of the user and display prime
      *****************************************************************
       111-YOUNG-ANC-NOTE.
           SEARCH WS-PRIME-ALL OF PRIMES-R-YOUNG 
                 AT END DISPLAY 'ERROR'
                 WHEN (WS-ANC OF PRIMES-R-YOUNG (IY) = PJ-ANC  ) AND
                      (WS-NOTE OF PRIMES-R-YOUNG (IY) = PJ-NOTE)
                    PERFORM 111-YOUNG
           END-SEARCH.
           PERFORM 120-DISPL.
      *****************************************************************
      * Check if it's an addition or a substraction 
      *****************************************************************
       111-YOUNG.
           IF WS-OPERATION OF PRIMES-R-YOUNG (IY) = 'A'
                 MOVE WS-PRIME-DUE OF PRIMES-R-YOUNG (IY) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I + 
                         WS-PRIME-DUE OF PRIMES-R-YOUNG (IY)
           ELSE
                 MOVE WS-PRIME-DUE OF PRIMES-R-YOUNG (IY) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I - 
                         WS-PRIME-DUE OF PRIMES-R-YOUNG (IY)
           END-IF.
      *****************************************************************
      *  This routine should display the final prime.
      *****************************************************************
       120-DISPL.
           DISPLAY '120-DISPL'.
           DISPLAY '    PRIME TO PAY : ' WS-PRIME-F.
           DISPLAY '    AUGMENTATION : ' WS-AUG.
      *****************************************************************
      *  This routine should display variables (if any)
      *****************************************************************
       200-DISPV.
           DISPLAY "200-DISPV".
           DISPLAY "    PJ-PRIME-I : " PJ-PRIME-I.
           DISPLAY "    PJ-NOTE    : " PJ-NOTE.
           DISPLAY "    PJ-ANC     : " PJ-ANC.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program (after some displays)
      *****************************************************************
       300-EXITP.
           DISPLAY "300-EXITP".
       300-EXIT.
           EXIT.
