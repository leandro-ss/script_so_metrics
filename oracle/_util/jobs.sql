PROMPT
PROMPT ==> FUN��O: EXIBE A PROGRAMA��O DOS JOBS DO BANCO DE DADOS
PROMPT ==> DESENVOLVIDO POR DANILO MENDES
PROMPT
COL INTERVAL FORMAT A100
COL WHAT     FORMAT A100
SELECT
	JOB,
	LOG_USER,
	TO_CHAR(LAST_DATE, 'DD/MM/YYYY HH24:MI:SS') LAST,
	TO_CHAR(NEXT_DATE, 'DD/MM/YYYY HH24:MI:SS') NEXT,
	TO_CHAR(SYSDATE  , 'DD/MM/YYYY HH24:MI:SS') AGORA,
	FAILURES,
	BROKEN,
	TOTAL_TIME,
	INTERVAL,
	WHAT
FROM
	DBA_JOBS
ORDER
	BY NEXT
/
