** Programa Principal de Contratos - Lomas de la Paz **

PUBLIC gconecta, gctitulo, gcfecha, gchora, gcgraficos, gclogo, gcusuario, gcruta, gcsistema, gctitulo, gndecimal, lcmenu, gcdescripcion, gcnombrepc_user_red, gc_ruta_exportar
SET CENTURY ON
IF FirsTime("sicontratos.exe")  = .t.
   ** Leer del INI
   Archivo_ = FILE(".\bd.ini") 
   IF Archivo_ = .T. 
      N_Cadena = ALLTRIM(FILETOSTR(".\bd.ini")) 
      x_Server = ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
      N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
      x_UID =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
      N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
      x_PWD =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
      N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
      x_Change = CHRTRAN(N_Cadena,CHR(13),"*") 
      x_DBaseName = Substr(x_Change,1,ATC("*",x_Change,1)-1) 
      lcStringCnxLocal="Driver={MySQL ODBC 5.3 ANSI Driver}" +";Server="+x_Server+";Port=3306;+Database="+x_DBaseName+";Uid="+x_UID+";Pwd="+x_PWD  && Cadena de Conexi�n
      Sqlsetprop(0,"DispLogin" , 3 ) 
      SQLSETPROP(0,"IdleTimeout",0)
       * Asignacion de Variables con sus datos 
      gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
      gcfecha_dia = SUBSTR(DTOC(DATE()),4,2)
      gcfecha_mes = SUBSTR(DTOC(DATE()),1,2)
      gcfecha_anio = SUBSTR(DTOC(DATE()),7,4)
      gcfecha = gcfecha_dia + '/' + gcfecha_mes + '/' + gcfecha_anio
      gchora = TIME()
      lcruta = ADDBS(FULLPATH(CURDIR()))
      nnro = AT("FNT", lcruta)
      IF nnro <> 0
         gcgraficos = substr(lcruta,1,nnro-1) + "GRA\"
         gc_ruta_exportar = substr(lcruta,1,nnro-1) + "EXPORTAR\"
      ELSE
         gcgraficos = lcruta + "GRA\"
         gc_ruta_exportar = lcruta + "EXPORTAR\"
         
      ENDIF
      gcruta = lcruta       
      gcsistema = "SICONTRATOS"
      gctitulo = "SISTEMA DE CONTRATOS Y CONTROL DE PAGOS "
      gndecimal = 0
      gcnombrepc_user_red = SYS(0)
   *   _screen.Caption = gcsistema + " : " + gctitulo +  "  [FECHA : " + gcfecha + "] " + "  APLICACION : " + gcruta + "   SERVIDOR :   " + UPPER(x_Server)
      _screen.Caption = gcsistema + " : " + gctitulo +  "  [FECHA : " + gcfecha + "] " + "   SERVIDOR :   " + UPPER(x_Server)
           
      _screen.picture=gcgraficos + "wfondo.jpg"
      _screen.icon=gcgraficos  + "ilpaz.ico"
      _Screen.AddProperty("lmostrar","")
      DO ambientador
      if !gconecta = 1 then 
      	  MESSAGEBOX("NO EXISTE CONEXION: PARAMETROS INCORRECTOS/FALTANTES O PROBLEMAS CON LA RED DE DATOS  LAN/WAN",0,"VERIFIQUE LA RED O SERVIDOR")
          QUIT
      ELSE
         ON SHUTDOWN CLEAR EVENTS
         DO FORM frm_login
         READ events
         
      ENDIF
      ON SHUTDOWN  
      DO ambientador
   ELSE
     MESSAGEBOX("NO EXISTE ARCHIVO DE PARAMETROS DE CONEXION",0,"VERIFIQUE LA EXISTENCIA DE ARCHIVOS Y LAS CLAVES")
     QUIT
 ENDIF

ELSE
    QUIT
ENDIF

********************************
	PROCEDURE ambientador
		_ASCIICOLS = 240
 		SET MESSAGE TO ""
		SET BRSTATUS OFF
		SET COLOR TO
		SET CURSOR ON
		SET CARRY OFF
		SET CENTURY ON
		SET CLEAR ON
		SET CLOCK STATUS
		SET CONSOLE OFF
		SET DATE TO ANSI
		SET DECIMAL TO 2
		SET DELETED ON
		SET DEVICE TO SCREEN
		SET DEVELOPMENT ON
		SET ECHO OFF
		SET ESCAPE OFF
		SET EXCLUSIVE OFF
		SET EXACT OFF
		SET FIXED ON
		SET FULLPATH ON
		SET FUNCTION F2 TO ''
		SET FUNCTION F3 TO ''
		SET FUNCTION F4 TO ''
		SET FUNCTION F5 TO ''
		SET FUNCTION F6 TO ''
		SET FUNCTION F7 TO ''
		SET FUNCTION F8 TO ''
		SET FUNCTION F9 TO ''
		SET FUNCTION F10 TO ''
		SET HEADING OFF
		SET MOUSE ON
		SET MEMOWIDTH TO 240
		SET MULTILOCKS ON
		SET NOTIFY OFF
		SET OPTIMIZE ON
		SET PRINTER OFF
		SET PRINTER TO
		SET REPROCESS TO AUTOMATIC
		SET SAFETY OFF
		SET STATUS OFF
		SET STEP OFF
		SET STICKY ON
		SET SYSMENU OFF
		SET TALK OFF
		SET UNIQUE OFF
		SET VIEW OFF
		SET CLOCK STATUS
		SET COLLATE TO 'GENERAL'
		SET DATE TO dmy
	ENDPROC
  

PROCEDURE FirsTime
LPARAMETERS tcAppName
LOCAL lcMsg, lcAppName, lnMutexHandle, lnhWnd, llRetVal
lcMsg = ''
SET ASSERTS ON
IF EMPTY( NVL( tcAppName, '' ) )
   ASSERT .F. MESSAGE lcMsg
  RETURN 
ENDIF
lcAppName = UPPER( ALLTRIM( tcAppName ) ) + CHR( 0 )
DECLARE INTEGER CreateMutex IN WIN32API INTEGER lnAttributes, INTEGER lnOwner, STRING @lcAppName
DECLARE INTEGER GetProp IN WIN32API INTEGER lnhWnd, STRING @lcAppName
DECLARE INTEGER SetProp IN WIN32API INTEGER lnhWnd, STRING @lcAppName, INTEGER lnValue
DECLARE INTEGER CloseHandle IN WIN32API INTEGER lnMutexHandle
DECLARE INTEGER GetLastError IN WIN32API 
DECLARE INTEGER GetWindow IN USER32 INTEGER lnhWnd, INTEGER lnRelationship
DECLARE INTEGER GetDesktopWindow IN WIN32API 
DECLARE BringWindowToTop IN Win32APi INTEGER lnhWnd
DECLARE ShowWindow IN WIN32API INTEGER lnhWnd, INTEGER lnStyle
lnMutexHandle = CreateMutex( 0, 1, @lcAppName )
IF GetLastError() = 183
  lnhWnd = GetWindow( GetDesktopWindow(), 5 )
  DO WHILE lnhWnd > 0
     IF GetProp( lnhWnd, @lcAppName ) = 1
       BringWindowToTop( lnhWnd )
       ShowWindow( lnhWnd, 3 )
       EXIT
     ENDIF
     lnhWnd = GetWindow( lnhWnd, 2  )
  ENDDO
  CloseHandle( lnMutexHandle )
ELSE
  SetProp( _vfp.Hwnd, @lcAppName, 1)
  llRetVal = .T.
ENDIF
RETURN llRetVal
ENDPROC

  

FUNCTION EsFechaValida(tnDia, tnMes, tnAnio)
  RETURN ;
    VARTYPE(tnAnio) = "N" AND ;
    VARTYPE(tnMes) = "N" AND ;
    VARTYPE(tnDia) = "N" AND ;
    BETWEEN(tnAnio, 100, 9999) AND ;
    BETWEEN(tnMes, 1, 12) AND ;
    BETWEEN(tnDia, 1, 31) AND ;
    NOT EMPTY(DATE(tnAnio, tnMes, tnDia))
ENDFUNC


FUNCTION ObtenerHora(tn)
  lnHora = INT(tn)
  lnMin = INT((tn - lnHora) * 60)
RETURN TRANSFORM(lnHora, "@L 99")+ ":" + TRANSFORM(lnMin, "@L 99")


FUNCTION Diferencia_AMD(tdIni, tdFin)
  LOCAL ldAux, lnAnio, lnMes, lnDia, lcRet
  *--- Fecha inicial siempre menor
  IF tdIni > tdFin
    ldAux = tdIni
    tdIni = tdFin
    tdFin = ldAux
  ENDIF
  lnAnio = YEAR(tdFin) - YEAR(tdIni)
  ldAux = GOMONTH(tdIni, 12 * lnAnio)
  *--- No cumplio el a�o aun
  IF ldAux > tdFin
    lnAnio = lnAnio - 1
  ENDIF
  lnMes = MONTH(tdFin) - MONTH(tdIni)
  IF lnMes < 0
    lnMes = lnMes + 12
  ENDIF
  lnDia = DAY(tdFin) - DAY(tdIni)
  IF lnDia < 0
    lnDia = lnDia + DiasDelMes(tdIni)
  ENDIF
  *--- Si el dia es mayor, no cumplio el mes
  IF (DAY(tdFin) < DAY(tdIni))
    IF lnMes = 0
      lnMes = 11
    ELSE
      lnMes = lnMes - 1
    ENDIF
  ENDIF
  lcRet = ALLTRIM(STR(lnAnio))+ "a" + PADL(ALLTRIM(STR(lnMes)), 2,'0')+ "m" +PADL(ALLTRIM(STR(lnDia)),2,'0')+ "d"
  RETURN lcRet
ENDFUNC 


FUNCTION DiasDelMes(tdFecha)
  LOCAL ld
  ld = GOMONTH(tdFecha,1)
  RETURN DAY(ld - DAY(ld))
ENDFUNC 