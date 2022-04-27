DECLARE @kq tinyint
EXEC @kq = usp_Purchase 'KH0001', 12000, 0, 'SP0006', 15, 'SP0008', 1
if @kq = 0
	PRINT 'Failed'


DECLARE @kq tinyint
EXEC @kq = usp_Purchase_Fix3 'KH0001', 12000, 0, 'SP0006', 15, 'SP0008', 1
if @kq = 0
	PRINT 'Failed'