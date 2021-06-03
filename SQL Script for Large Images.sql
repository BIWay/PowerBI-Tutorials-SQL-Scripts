
create table #temp
(
	Part int,
	[id] [int] NULL,
	name [nvarchar](max) NULL,
	[image] [varchar](max) NULL
)
;

DECLARE @row int;
Set @row = 1
WHILE  @row <=  3
BEGIN  
	DECLARE @Part_Number int;
	Set @Part_Number = (SELECT len(image)/32000  FROM [dbo].[BIWay_Images] where id = @row) 
	DECLARE  @Part  int ;  
	SET  @Part  =  1;  
	DECLARE  @posi  int ;  
	SET  @posi  =  1;  

	WHILE  @Part <=  @Part_Number + 1
	BEGIN  
		Insert into #temp 
			Select @Part Part, id, name, SUBSTRING(image,@posi,32000)
			FROM  [dbo].[BIWay_Images]  -- from your table
			where id = @row;
		SET @posi = @posi + 32000;
		SET @Part = @Part+1;
	END  
	SET @row = @row+1;
END
select * from #temp