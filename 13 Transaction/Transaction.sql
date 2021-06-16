-- T-SQL -> DDL, DML, DCL, TCL
-- SQL -> DDL, DML, DCL

CREATE TABLE CreditCard
(Id INT PRIMARY KEY IDENTITY,
 Owner NVARCHAR(60) NOT NULL,
 PinCode INT NOT NULL,
 CardNumber NVARCHAR(19) NOT NULL,
 Money MONEY NOT NULL,
 CONSTRAINT CK_PinCode CHECK (PinCode < 10000 AND PinCode >= 0),
 CONSTRAINT CK_CardNumber CHECK (CardNumber LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))

ALTER TABLE CreditCard
ADD CONSTRAINT CK_Money CHECK (Money >= 0 AND Money <= 10000)

INSERT INTO CreditCard(Owner, CardNumber, PinCode, Money) VALUES ('Ivan Ivanov', '1234-1234-1234-1234', 1234, 3000)
INSERT INTO CreditCard(Owner, CardNumber, PinCode, Money) VALUES ('Test Testovich', '4321-4321-4321-4321', 4321, 5000)

SELECT * FROM CreditCard

CREATE PROC MoneyTransfer
		    @CardNumberSender NVARCHAR(19),
			@CardNumberReciver NVARCHAR(19),
			@Quantity MONEY
AS
BEGIN
	IF @Quantity > 0
	BEGIN
		BEGIN TRANSACTION
		BEGIN TRY
			UPDATE CreditCard
			SET Money = Money - @Quantity
			WHERE CardNumber LIKE @CardNumberSender

			UPDATE CreditCard
			SET Money = Money + @Quantity
			WHERE CardNumber LIKE @CardNumberReciver

			COMMIT
		END TRY
		BEGIN CATCH
			PRINT 'Error transfer'
			ROLLBACK
		END CATCH
	END
	ELSE
	BEGIN
		PRINT 'Invalid quantity'
	END
END

EXEC MoneyTransfer '1234-1234-1234-1234', '4321-4321-4321-4321', -2000
EXEC MoneyTransfer '1234-1234-1234-1234', '4321-4321-4321-4321', 2000
EXEC MoneyTransfer '1234-1234-1234-1234', '4321-4321-4321-4321', 2000

SELECT * FROM CreditCard

-- Isolation level
-- READ UNCOMMITTED
-- READ COMMITTED
-- REPEATABLE READ
-- SERIALIZABLE
-- SNAPSHOT

--SET TRANSACTION ISOLATION LEVEL [READ COMMITTED]
--BEGIN TRANSACTION
--COMMIT