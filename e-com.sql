--PROC_NavData,PROC_initialScript
--SELECT * FROM SYS.OBJECTS WHERE name like 'PROC_%' OR name like 'T_%'


CREATE TABLE T_AdminNav
(
Id INT IDENTITY(1,1),
position INT, --1:top,2:right,3:bottom,4:left
faName NVARCHAR(50),
navName NVARCHAR(100),
navLink NVARCHAR(100),
levelId INT,
parentId INT,
isActive INT,
isVisibileDesktop INT,
isVisibleMobile INT,
createDate NVARCHAR(25),
createdBy NVARCHAR(25)
)
GO
--SELECT * FROM T_AdminNav --TRUNCATE TABLE T_AdminNav
INSERT INTO T_AdminNav VALUES --Level 0 -- Parent
/*1*/(4,'fa fa-home','Dashboard','/dashboard','0','0','1','1','1',GETDATE(),'admin'),
/*2*/(4,'fa fa-file-o','Pages','/pages','0','0','1','1','1',GETDATE(),'admin'),
/*3*/(4,'fa fa-folder-open-o','File Manager','/filemanager','0','0','1','1','1',GETDATE(),'admin'),
/*4*/(4,'fa fa-clipboard','Content Manager','/contentmanager','0','0','1','1','1',GETDATE(),'admin'),
/*5*/(4,'fa fa-user-o','User Manager','/usermanager','0','0','1','1','1',GETDATE(),'admin'),
/*6*/(4,'fa fa-pencil-square-o','Site Content','/contentmanager','0','0','1','1','1',GETDATE(),'admin'),
/*7*/(4,'fa fa-magic','Site Configuration','/contentmanager','0','0','1','1','1',GETDATE(),'admin'),
/*8*/(4,'fa fa-cog','Dev Management','','0','0','1','1','1',GETDATE(),'admin')
GO

INSERT INTO T_AdminNav VALUES --Level 1
/*8-09*/(4,'fa fa-home','Domains','/domains','1','8','1','1','1',GETDATE(),'admin'),
/*8-10*/(4,'fa fa-home','Modules','/modules','1','8','1','1','1',GETDATE(),'admin'),
/*8-11*/(4,'fa fa-home','Tools','/tools','1','8','1','1','1',GETDATE(),'admin'),
/*8-12*/(4,'fa fa-home','Custom Code','','1','8','1','1','1',GETDATE(),'admin')
GO

INSERT INTO T_AdminNav VALUES --Level 2
/*8-12-13*/(4,'fa fa-home','CSS','/css','2','12','1','1','1',GETDATE(),'admin'),
/*8-12-14*/(4,'fa fa-home','JS','/js','2','12','1','1','1',GETDATE(),'admin')


 ALTER PROC PROC_NavData
 AS
 SET NOCOUNT ON 
 DECLARE @DynamicQuery NVARCHAR(1000) = ''
 DECLARE @MinLevel INT = 0, @MaxLevel INT = (SELECT MAX(levelId)+1 FROM T_AdminNav) 
 WHILE (@MinLevel<@MaxLevel)
 BEGIN
 SET @DynamicQuery = @DynamicQuery + 'SELECT CONVERT(NVARCHAR,parentId)parentId,CONVERT(NVARCHAR,Id) navId,faName,navName,navLink,levelId FROM T_AdminNav WHERE levelId=' + CONVERT(NVARCHAR,@MinLevel) +' AND position = 4; ' 
 SET @MinLevel = @MinLevel+1
 END

 EXEC(@DynamicQuery)
 SET NOCOUNT OFF