SET SERVEROUTPUT ON SIZE 999999
DECLARE

	V_QTD_INDEX NUMBER;
	V_TEXT_QTD_INDEX VARCHAR2(5);
	V_TABLE_NAME VARCHAR2(30);

	CURSOR C1 IS
	SELECT
		A.OWNER,
		A.TABLE_NAME,
		A.CONSTRAINT_NAME,
		D.COLUMN_NAME
	FROM
		DBA_CONSTRAINTS A,
		DBA_CONS_COLUMNS D
	WHERE
		A.CONSTRAINT_NAME = D.CONSTRAINT_NAME
		AND A.CONSTRAINT_TYPE = 'R'
		AND A.OWNER = UPPER('&OWNER')
		AND EXISTS 	(SELECT 
					1
				FROM
					DBA_CONS_COLUMNS B
				WHERE
					A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
					AND NOT EXISTS 	(SELECT 
								1
							FROM
								DBA_IND_COLUMNS C
							WHERE
								B.COLUMN_NAME = C.COLUMN_NAME
								AND C.COLUMN_POSITION = 1));

BEGIN
	FOR R1 IN C1 LOOP
		SELECT
			COUNT(*)
		INTO
			V_QTD_INDEX
		FROM
			DBA_INDEXES
		WHERE
			TABLE_NAME = R1.TABLE_NAME
			AND OWNER  = R1.OWNER;

		IF V_QTD_INDEX < 10 THEN
			V_TEXT_QTD_INDEX := '0'||TO_CHAR(V_QTD_INDEX+1);
		ELSE
			V_TEXT_QTD_INDEX := TO_CHAR(V_QTD_INDEX+1);
		END IF;

		IF V_TABLE_NAME = SUBSTR(R1.TABLE_NAME,1,24) THEN
			IF V_QTD_INDEX < 10 THEN
				V_TEXT_QTD_INDEX := '0'||TO_CHAR(TO_NUMBER(V_TEXT_QTD_INDEX+1));
			ELSE
				V_TEXT_QTD_INDEX := TO_CHAR(TO_NUMBER(V_TEXT_QTD_INDEX+1));
			END IF;
		END IF;		

		V_TABLE_NAME := SUBSTR(R1.TABLE_NAME,1,24);
			
		DBMS_OUTPUT.PUT_LINE('CREATE INDEX '||R1.OWNER||'.'||'IDX'||V_TEXT_QTD_INDEX||'_'||V_TABLE_NAME||' ON '||R1.OWNER||'.'||R1.TABLE_NAME||'('||R1.COLUMN_NAME||');');

	END LOOP;
END;
/