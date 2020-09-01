CLEAR

lcStringCnxRemoto = "DRIVER={MySQL ODBC 3.51 Driver};" + ;
                    "SERVER=200.1.1.1;" + ;
                    "PORT=3333;" + ;
                    "UID=booking;" + ;
                    "PWD=booking;" + ;
                    "DATABASE=booking;" + ;
                    "OPTIONS=131329;"

lcStringCnxLocal = "DRIVER={MySQL ODBC 5.3 ANSI Driver};" + ;
                   "SERVER=localhost;" + ;
                   "UID=root;" + ;
                   "PWD=12345;" + ;
                   "DATABASE=bdcontratos;" + ;
                   "OPTIONS=131329;"
SQLSETPROP(0,"DispLogin" , 3 )
lnHandle = SQLSTRINGCONNECT(lcStringCnxLocal)

?lnHandle

* lcStringCnxLocal="Driver={MySQL ODBC 5.3 ANSI Driver}" +";Server="+x_Server+";Port=3306;+Database="+x_DBaseName+";Uid="+x_UID+";Pwd="+x_PWD  && Cadena de Conexión
