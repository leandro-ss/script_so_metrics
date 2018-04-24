PROMPT
PROMPT ==> FUN��O: EXIBE INFORMA��ES SOBRE OS USU�RIOS CONECTADOS NA BASE DE DADOS
PROMPT ==> DESENVOLVIDO POR CLEBER R. MARQUES
PROMPT ==> MSN: cleber_rmarques@hotmail.com
PROMPT
SELECT 
	USERNAME, 
	OSUSER, 
	SID, 
	SERIAL#, 
	STATUS, 
	SERVER, 
	MACHINE, 
	MODULE,
	PROGRAM, 
	TO_CHAR(LOGON_TIME,'DD/MM/YYYY HH24:MI:SS') LOGON,
	LAST_CALL_ET
FROM   
	GV$SESSION
WHERE  
	USERNAME 	!= 'UNKNOWN'
	AND TYPE 	!= 'BACKGROUND'
	AND STATUS   	NOT IN ('KILLED','SNIPED')
ORDER  BY 
	USERNAME, OSUSER
/