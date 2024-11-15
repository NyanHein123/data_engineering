/* Answer for Q1.*/
SELECT (SELECT COUNT(*) FROM MODEL WHERE PAR_MODEL_ID IS NULL) AS FreshModel,
(SELECT COUNT(*) FROM MODEL WHERE PAR_MODEL_ID IS NOT NULL) AS FinetunedModel;


/* Answer for Q2. */
SELECT MT.TYPENAME AS ModelType, COUNT(*) as NumberUnassigned, 
CAST(ROUND(AVG(NU.AvgAccuracy), 1) AS DECIMAL(3,1)) as MeanAccuracy,
MAX(NU.MaxAccuracy) as MaxAccuracy
FROM(
SELECT 
        MODEL_ID, 
        MODEL_CODE, 
        TRN_ACCURACY AS AvgAccuracy, 
        TRN_ACCURACY AS MaxAccuracy
    FROM MODEL 
    WHERE MODEL_ID NOT IN (SELECT MODEL_ID FROM SOLUTION))AS NU
	JOIN MODEL_TYPE MT ON MT.MODEL_CODE = NU.MODEL_CODE
	Group by MT.TYPENAME
	Having COUNT(*) > 0
	Order by ModelType;



/* Answer for Q3. */
SELECT 
    e.FIRST_NAME+ ' '+ e.LAST_NAME AS FullName,
    e.PH_NUM AS Contact,
    e.GENDER AS Gender
FROM EMPLOYEE e
JOIN (
    SELECT 
        EMPLOYEE_ID, 
        ORDER_ID,
        COUNT(DISTINCT MODEL_ID) AS ModelCount
    FROM SOLUTION
    GROUP BY EMPLOYEE_ID, ORDER_ID
    HAVING COUNT(DISTINCT MODEL_ID) > 1
) s ON e.EMPLOYEE_ID = s.EMPLOYEE_ID
ORDER BY FullName;


/* Answer for Q4 */
SELECT count(*) as NumberAccepted
FROM SOLUTION s
JOIN MODEL m ON s.MODEL_ID = m.MODEL_ID
JOIN ORDERS o ON s.ORDER_ID = o.ORDER_ID
LEFT JOIN REQ_MODEL_TYPE rmt ON o.ORDER_ID = rmt.ORDER_ID AND m.MODEL_CODE = rmt.MODEL_CODE
WHERE s.ASSG_DATE <= o.CMP_DATE 
      AND m.TRN_ACCURACY >= o.REQ_ACCURACY
      AND (rmt.MODEL_CODE IS NOT NULL OR NOT EXISTS (
          SELECT 1 FROM REQ_MODEL_TYPE rmt2 WHERE rmt2.ORDER_ID = o.ORDER_ID));

