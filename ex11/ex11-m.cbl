      *****************************************************************
      * Program name:    PGM011M
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameter : i.e. 1000    
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM011M.
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
       01  WS-ADD-STR     PIC X(01) VALUE "A".

       LINKAGE SECTION.
      / Parameter from JCL run 
       01  PJ-COUNTER     PIC 9(02).
       01  PJ-PRIME-I     PIC 9(07).
       01  PJ-NOTE        PIC X(01).
       01  PJ-ANC         PIC 9(07).
           88 B0-1 VALUE 0 THRU 1. 
           88 B2-4 VALUE 2 THRU 4.
       01  LK-PRIME-F     PIC 9(07).
      *****************************************************************
       PROCEDURE DIVISION USING PJ-COUNTER,
                                PJ-PRIME-I,
                                PJ-NOTE,
                                PJ-ANC,
                                LK-PRIME-F. 
           PERFORM 000-SETUP THRU 000-EXIT.
           PERFORM 100-FILER THRU 100-EXIT.
           PERFORM 200-FILER THRU 200-EXIT.
           PERFORM 300-DISPL THRU 300-EXIT.
           EXIT PROGRAM.
      *****************************************************************
      *  This routine should setup initiales variables
      *****************************************************************
       000-SETUP.
           SET IO TO 1.
           SET IY TO 1.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       100-FILER.
           IF NOT (B0-1 OR B2-4)
               PERFORM 110-OLD-NOTE
           ELSE
               PERFORM 150-YOUNG-ANC-NOTE
           END-IF.
       100-EXIT.
           EXIT.
      *****************************************************************
      *  Check the note of the user and display prime to pay
      *****************************************************************
       110-OLD-NOTE.
           SEARCH WS-PRIME-ALL OF PRIMES-R-OLD
                 WHEN WS-NOTE OF PRIMES-R-OLD (IO) = PJ-NOTE 
                    PERFORM 111-OLD-OP
           END-SEARCH.
      *****************************************************************
      *  Check if it's an addition or a substraction
      *****************************************************************
       111-OLD-OP.
           IF WS-OPERATION OF PRIMES-R-OLD (IO) = WS-ADD-STR
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
       150-YOUNG-ANC-NOTE.
           SEARCH WS-PRIME-ALL OF PRIMES-R-YOUNG
                 WHEN (WS-ANC OF PRIMES-R-YOUNG (IY) = PJ-ANC  ) AND
                      (WS-NOTE OF PRIMES-R-YOUNG (IY) = PJ-NOTE)
                    PERFORM 151-YOUNG
           END-SEARCH.
      *****************************************************************
      * Check if it's an addition or a substraction 
      *****************************************************************
       151-YOUNG.
           IF WS-OPERATION OF PRIMES-R-YOUNG (IY) = WS-ADD-STR
                 MOVE WS-PRIME-DUE OF PRIMES-R-YOUNG (IY) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I + 
                         WS-PRIME-DUE OF PRIMES-R-YOUNG (IY)
           ELSE
                 MOVE WS-PRIME-DUE OF PRIMES-R-YOUNG (IY) TO WS-AUG
                 COMPUTE WS-PRIME-F = PJ-PRIME-I - 
                         WS-PRIME-DUE OF PRIMES-R-YOUNG (IY)
           END-IF.
      *****************************************************************
      *  This routine should return value WS-PRIME-F TO LK-PRIME-F
      *****************************************************************
       200-FILER.
           MOVE WS-PRIME-F TO LK-PRIME-F.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display the final prime.
      *****************************************************************
       300-DISPL.
           DISPLAY 'ACCOUNT : '          PJ-COUNTER.
           DISPLAY '    PRIME INIT   : ' PJ-PRIME-I,
           DISPLAY '    NOTE         : ' PJ-NOTE,
           DISPLAY '    SENIORITY    : ' PJ-ANC,
           DISPLAY '    PRIME FINAL  : ' LK-PRIME-F. 
       300-EXIT.
           EXIT.
