//RUNJCL  JOB 'IBMUSER',
//            'MAC',
//            CLASS=A,
//            MSGCLASS=X,
//            NOTIFY=&SYSUID
//        SET PGMCBL=PGM004
//STEP1  EXEC PGM=&PGMCBL
//STEPLIB  DD DISP=SHR,DSN=IBMUSER.PROG.LOAD
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
06
/*
//