SELECT CHAM.GLKey, CHAM.PatType, CHAM.FinClass, Sum(CHAM.Amount) AS SumOfAmount, Sum(CHAM.ProfFee) AS SumOfProfFee, CHAM.ServiceDate
FROM CHAM
GROUP BY CHAM.GLKey, CHAM.PatType, CHAM.FinClass, CHAM.ServiceDate;
