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

<p align="center"> Exercices 1-12 POE cobol
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

This repository is here to help you understand the basics of cobol with some exercices.  
Those exercices are made by Global Knowledge, here stand modests corrections. 

## 🏁 Getting Started <a name = "getting_started"></a>


### Prerequisites

- Z/OS
  - A program section
  - A Loadlib 
  - A Compiler

Your program section should be a standard PDS.  

Your Loadlib section shoul be a specific PDS.

``` jcl
//* You can create the loadlib, with this kind of JCL script.
//SYSUT2 DD DSN=IBMUSER.PROG.LOAD,DISP=(NEW,CATLG,CATLG),
// UNIT=SYSDA,SPACE=(CYL,(60,20),RLSE),          
// DCB=(RECFM=U,LRECL=0,BLKSIZE=32760,DSORG=PO), 
// DSNTYPE=LIBRARY                               
```

### Be Aware <a name = "settings"></a>

For cobol program, be sure to give the file name into PROGRAM-ID.

My setup is the following:  
- IBMUSER.PROG.CBL  : My cobol folder, including compiler and executer.
- IBMUSER.PROG.LOAD : My cobol loadlib, see above for specifications.
- IBMUSER.FILES     : My folder dedicated for files read in executions.

### Installing

You can transfer, copy/paste the files but it's recommanded to just check them.


## ⛏️ Built Using <a name = "built_using"></a>

- [Z/OS](https://www.ibm.com/fr-fr) - IBM Z/OS
- [JCL](https://www-40.ibm.com/servers/resourcelink/svc00100.nsf/pages/zOSV2R3SA231386/$file/ieab500_v2r3.pdf) - JCL language
- [Cobol](https://www.ibm.com/docs/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/igy3pg50.pdf) - COBOL language

## ✍️ Authors <a name = "authors"></a>

- [@emericdefay](https://github.com/emericdefay) - Corrections propositions


## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Alteca
- Global Knowledge
- Pole Emploie
