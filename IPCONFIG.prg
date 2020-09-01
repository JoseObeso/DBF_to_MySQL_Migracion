Local F, X, Y, U, K 
CLEAR
F = Sys(2023) + "" + SubStr(Sys(2015),1,8) + ".txt" 
X = SubStr(sys(0),1, At(" ", Sys(0))-1) 
Run PING &X > &F 
Y = FileToStr(F) 
Delete File &F 
U = At("[", Y) + 1 
K = At("]", Y) 
? SubStr(Y,U,K-U) 
**************** 
*        Saber el Ip del Equipo y Estación de Trabajo 
loWinSock = CREATEOBJECT("mswinsock.winsock.1") 
loWinSock.LocalIP && numero del ip del equipo local 
loWinSock.LocalHostName && nombre de la estacion de trabajo local 
oWS = CREATEOBJECT ("MSWinsock.Winsock")
? oWS.LocalIP
 
RELEASE oWS