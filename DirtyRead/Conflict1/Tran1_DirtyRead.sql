DECLARE @kq tinyint
EXEC @kq = usp_Purchase 'KH0004', 12000, 0, 'SP0006', 2, 'SP0005', 5
if @kq = 0
	PRINT 'Failed'


DECLARE @kq tinyint
EXEC @kq = usp_Purchase_Fix 'KH0004', 12000, 0, 'SP0006', 2, 'SP0005', 5
if @kq = 0
	PRINT 'Failed'