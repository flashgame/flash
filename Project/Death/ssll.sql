USE [SSLL]
GO
/****** 对象:  Table [dbo].[Bag]    脚本日期: 05/19/2012 13:44:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bag](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[databaseId] [int] NOT NULL,
	[content] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** 对象:  Table [dbo].[UserInfo]    脚本日期: 05/19/2012 13:44:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[databaseId] [int] NOT NULL,
	[nickname] [varchar](64) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** 对象:  Table [dbo].[Users]    脚本日期: 05/19/2012 13:44:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mailname] [varchar](64) NOT NULL,
	[password] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** 对象:  StoredProcedure [dbo].[pro_GetUserBag]    脚本日期: 05/19/2012 13:44:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pro_GetUserBag]
	-- Add the parameters for the stored procedure here
(
	@databaseId int,
	@content text output
)
AS
BEGIN
	select @content = content from Bag where databaseId = @databaseId;
	return @@rowcount;
END
GO
/****** 对象:  StoredProcedure [dbo].[pro_GetUserInfo]    脚本日期: 05/19/2012 13:44:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pro_GetUserInfo]
	-- Add the parameters for the stored procedure here
(
@databaseId int,
@nickname varchar(64) output
)
AS
BEGIN
	select @nickname = nickname from UserInfo where databaseId = @databaseId;
	return @@rowcount;
END
GO
/****** 对象:  StoredProcedure [dbo].[pro_UserLogin]    脚本日期: 05/19/2012 13:44:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pro_UserLogin] 
	-- Add the parameters for the stored procedure here
	@mailname varchar(64),
	@password varchar(32),
	@databaseId int output
AS
BEGIN
	SELECT @databaseId = id from Users where mailname=@mailname and password = @password;
return @@ROWCOUNT;
END
GO
