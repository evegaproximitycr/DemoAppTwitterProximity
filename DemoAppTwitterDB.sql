USE [master]
GO
/****** Object:  Database [DemoAppTwitterDB]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE DATABASE [DemoAppTwitterDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DemoAppTwitterDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DemoAppTwitterDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DemoAppTwitterDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DemoAppTwitterDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DemoAppTwitterDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoAppTwitterDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoAppTwitterDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoAppTwitterDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoAppTwitterDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DemoAppTwitterDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoAppTwitterDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DemoAppTwitterDB] SET  MULTI_USER 
GO
ALTER DATABASE [DemoAppTwitterDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoAppTwitterDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoAppTwitterDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoAppTwitterDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DemoAppTwitterDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DemoAppTwitterDB', N'ON'
GO
ALTER DATABASE [DemoAppTwitterDB] SET QUERY_STORE = OFF
GO
USE [DemoAppTwitterDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DemoAppTwitterDB]
GO
/****** Object:  User [pushUser]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE USER [pushUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[UserType] [nvarchar](max) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigApp]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigApp](
	[AppName] [nchar](50) NOT NULL,
	[OAauth_consumerkey] [nvarchar](200) NULL,
	[OAauth_consumersecret] [nvarchar](200) NULL,
	[OAauth_version] [nvarchar](50) NULL,
	[OAauth_signature_method] [nvarchar](50) NULL,
	[Callback_url] [nvarchar](200) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ConfigApp] PRIMARY KEY CLUSTERED 
(
	[AppName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TwitterUser]    Script Date: 8/9/2017 10:26:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TwitterUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[OAuth_Token] [nvarchar](50) NULL,
	[OAuth_Token_Secret] [nvarchar](200) NULL,
	[UserId] [nvarchar](200) NULL,
	[ScreenName] [nvarchar](200) NULL,
	[AccessToken] [nvarchar](300) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201708080356368_init', N'DemoAppTwitter.Migrations.Configuration', 0x1F8B0800000000000400DD5CDB6EE436127D5F20FF20E869B3705ABEEC0C668DEE19386D3B6B647CC1B427D8B7015B62B789912845A23C36827C591EF249F9852DEA2E5E74E9965BED2040304D164F158B5564B154F45F7FFC39FDF0E4B9C6230E23E2D399793439340D4C6DDF21743D3363B6FAE19DF9E1FD77FF985E38DE93F14B4E77C2E960248D66E60363C1A96545F603F65034F1881DFA91BF6213DBF72CE4F8D6F1E1E17FACA3230B038409588631FD1453463C9CFC809F739FDA38603172AF7D07BB51D60E3D8B04D5B8411E8E0264E399798E3DFF2C08EEBF11C67038490798C6994B1008B3C0EECA3410A53E430C443DFD1CE1050B7DBA5E04D080DCFBE70003DD0AB911CEA6705A92779DCDE1319F8D550ECCA1EC3862BED713F0E824538F250EDF48C966A13E50E005289A3DF359274A9C99570E4E9A3EF92E284064783A77434E3C33AF0B1667517083D9241F3849212F4380FBE6875F2755C403A3F3B883C29C8E2787FCBF03631EBB2C0EF18CE29885C83D30EEE2A54BEC9FF1F3BDFF15D3D9C9D17275F2EECD5BE49CBCFD373E79539D29CC15E86A0DD07417FA010E4136BC2AE66F1A567D9C250E2C8655C6A45A015B02CF308D6BF4F411D3357B009F397E671A97E4093B794B665C9F29014782412C8CE1E74DECBA68E9E2A2DF6AE4C9FFDFC0F5F8CDDB41B8DEA047B24E965EE00F8E13825F7DC26ED21B3D902075AFDA7A7FC9C82E43DFE3BFEBF695F67E59F87168F3C9F85A927B14AE31AB4B37B54AE3ED64D21C6A78B3CE51F7DFB4B9A4B2792B49F98436F1849CC5AEBD2197F765F976B638388060F112D3E21A693238E5793511000E8C3A596940475D0D88C2C4FECEFB215713E7D9C019FED9897333A30B0F1177809DB70317887B5624F470A1CE1F7DB073447B2BE70E45116C3CCE7F51F4F0E20A5A603B0EC11F160C79C18B73BB7BF029BE89BD2577B3DDF11A6C69EEBFF997C8667E7841F9A8ADF13EFAF6573F6617D439470C7F66760EC87FDE13AF3BC020E29CD9368EA24B3066ECCC7D08EB73C02BCA4E8E37F2F2B1239FB98B88A70E7D846DFB4B4E5A863F6A0A2904D290A9C2A026513FFA6B42BB899A93EA454D295A45CDC8FA8ACAC1BA499A51EA054D085AE54CA9060B2C93151A3EB24C60F73FB4DC2E4AD0ED0515352E6087C43F618A43D8C69C3BC4A3205AAE40977D638CA82459BE9D842509A75F901B0FCD6A236F483681E1BD2181DD7F6F48C484E647E2F0A8A4C37D2B2706F84EF4EAAB5CBBCF0992EDDA1D6AD31CE38630DE1DF12C8A7C9B245EA0C8B4657992BAFC10C319ED4993743662E2052606864EF891072D30375334AA5B7A8E5DCCB07166A799C8398A6CE4C86A8409393D04CB4F5485606502A62EDCBF249E60E938E48310BF0445E0A98432D92D08B54980DC562D09233B1E617CEE050FB1E71C07987286AD9AE8C25C9D6FE102147C844569D3D0D4AA585CB3216AA256DD9AB785B0E5BA4B69909DD8644BECACB1CB2C7E7B11C36CD6D80E8CB359255D04D0E60EC730D0ECAED2D500C48BCBBE19A87063D218681652EDC440EB1A1BC140EB2A7975069A5E51BBAEBF705FDD37F3AC5F94777FAC37AA6B04DBACE963CF4C338D3D610C83113894CDF37CC93BF113535CCE40CEEC7E1665A1AE68221C7C81593D6553C6BBCA38D46A06118DA809B034B416D0ECABA3042439540FE1F25C5EA3745914D10336CFBB35C2667BBF005BB10119BBFAF5B542A8FF462B1A67A7DB4731B3C21A2423EF7459A8E0280C42DCBCEA13EFA0145D5E56564C9758B84F345C9958B6180D0A6A895C354ACA2733B89672D36CD7922A20EB13926DA525217CD268299FCCE05ACA6CB45D498AA0A04758B0958AEA47F840CE96673A8AD3A6E89B5A695D56D630B534055CD36B140484AE2B055D598BB148ABB9E63F2CFAD73879298665478A52A742DA8213F343B4C6422FB006492F4918B173C4D012F13CCFDCF12432E5D9AAD9FE7396D5E3535EC4FC1CC8A9F9BFD311EA5A81DA712BC72319CC254CD2E3414D92495798807AB8C16BEC908B4245F27EEEBBB147F531967E74FA09AF3A3E6D9111A69620BF1443490A9322DDBAF63BAD8DEC17C3AD5311C56CBE567A089DC6F318B4AA735D5CAA47C9D35455145DEA6AB4B5D385337DD74B0C16FB2F572BC2CB7857590A23AE76DADA1D29AB75A9C2644D3D312AE5121258A5AF3B6ABDA2A58A59EFE98E2894AD542185AE1E52568B536A42563B36C2D368544DD19D835C8E5245977BBB232B0A53AAD08AEE0DB015328B7DDD5115B52B556045773F1F954FC1B2756F7653C54D63D8A330BD326F77166A305E6E7BDDFE28AD540654812ACD3DB1B26FFF1258D6BE9706A5BD376E635069B2643B83D260E8F79FDA67F5FAF6D3580BA0C7AC7D2BAF6DF14DB5027ABC7E66FBA2C621DD1C4592827B7183146E8AD3ECD6D6FE1E48BAC6A524A691AB118EF7E788616FC209268B5FDDB94B30DFCC73826B44C90A472CAD0F318F0F8F8E85F744FBF3B6C78A22C755DC7A750F7CEA6BB683522FFA8842FB018572E1C516EF5F4A5029A77D451DFC34337F4B469D26E911FEAFA4F9C0B88A3E53F26B0C1DF7618C8DDFE542D261DE0334DFDBF6F4F54677AD5EFDEF4B3AF4C0B80DC1634E8D4341979BAC70FD4D472F69D2A15B48B3F14B8FD7EB50E2038A1CF89F1E7AFABE8AD6FB91845244C1BB367F13B1246C90F7105BCD57F9E6612B44C5BB86A1F00651A1EEDDC22658DA370B0EFC64C99B857E9355BF61D84434EDFB0542FB8389AF17BAEF69F9C811CF2DC51D6B17FB5BA2E7D6EAEFAD4A41C73EE8A422F1AD1C5D2E04EF01B745B1F70696F1CAEAA4073B6A1565D0831EE36399F68BD73EEF4BB9735988326E95F32E0B9B1B3E5BFDADEA99F7A0024F5151347ED5F2AE6D4D9717DEF3D2CF7EB5C97B666C599DD9F815C8BB36365DCE78CF8DAD579DF19ED9DA58E7E7C896D6F9081DBD6A582E80D27CDF512596DBAA82D32C3CDCF0973E18411A51A68F39D565684D25B42D0C4B123D537DFD9BC858721C89AF44D1CCB6DF5CB303BF71B2194D335B4DD56813EF6CFF6FE49DD134F3D6D4628E51CFACAC8654D598B7EC634D455AAFA97EB936939672F9B698B5F163FD6B2A571E442935EFD17C707E3DD5C983A86448D7E9518D2C7F3B86B3B3F21727E1FC8EC8BA84E07F7F9262BB766A16345774E5E787B720514E226468AE31430E1CA96721232B6433E8E639E6E4357A92B7E35F3A96D8B9A2B7310B620653C6DED2AD25BC7810D0C43F29B9AECB3CBD0D923FAC32C414404CC273F3B7F4C798B84E21F7A52227A481E0D14596D1E56BC9786677FD5C20DDF8B42350A6BE2228BAC75EE00258744B17E8116F221B98DF47BC46F6739901D481B42F445DEDD37382D621F2A20CA31C0F3FC1861DEFE9FDFF017CFAAE6778550000, N'6.1.3-40302')
INSERT [dbo].[AspNetUsers] ([Id], [UserType], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'3fc5596f-fcc5-4480-861c-a8618182ac7c', N'adminuser', N'emilia.vega@proximitycr.com', 0, N'AFj5vl8kHCr0Sl2zfwVeQjqJnrtCqOnSMpxw0r9axn2uNAibTArK/F0wKYz/6hWklg==', N'c5612b6a-ba26-4336-bdc7-9b532ec6a18a', NULL, 0, 0, NULL, 1, 0, N'emilia.vega@proximitycr.com')
INSERT [dbo].[AspNetUsers] ([Id], [UserType], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'91336b0e-194c-4b0c-85b5-47b50cd88523', N'regularuser', N'test1@user.com', 0, N'AGgPzXkv82N4PYNqhDRkgcRwMfY3268VaWBZ22S7o/RAxNhj0tG7oENvVc9M1GHx2A==', N'356d1f66-6151-4da4-a023-4ec81146f372', NULL, 0, 0, NULL, 1, 0, N'test1@user.com')
INSERT [dbo].[ConfigApp] ([AppName], [OAauth_consumerkey], [OAauth_consumersecret], [OAauth_version], [OAauth_signature_method], [Callback_url], [CreatedDate]) VALUES (N'DemoAppTwitter                                    ', N'Ir9R7m7Rxr8TrqjgHQBukuLEB', N'hQ2Ku4RYYF6HH5wAOrGkHUwsOBhApptqzzfYJF5WGhQzGoHlRd', N'1.0', N'HMAC-SHA1', N'http://www.demo.app:4885/home/success', CAST(N'2017-08-08T10:24:53.130' AS DateTime))
SET IDENTITY_INSERT [dbo].[TwitterUser] ON 

INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (1, N'test1@user.com', N'893594576254107648-gLmA7Njnlljlv7WzxDr0qoSGFy7VYbr', N'Z0YwFqtsedNhnP6ZeMDdrSaO6tNZNWMqzh8CXvy9PlOwc', N'893594576254107648', N'evega_proximity', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-07T22:51:32.360' AS DateTime))
INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (2, N'test3@user.com', N'893594576254107648-gLmA7Njnlljlv7WzxDr0qoSGFy7VYbr', N'Z0YwFqtsedNhnP6ZeMDdrSaO6tNZNWMqzh8CXvy9PlOwc', N'893594576254107648', N'evega_proximity', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-08T07:43:50.827' AS DateTime))
INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (3, N'98test4@user.com', N'141599441-cnPmEXOcCw7boeQyGofQMLYcUqaoluQaZJ7NZrxS', N'csh75UwzBoQSp1GxDT4QM4rJhT33WEb7J0CtmQDoNJGr3', N'141599441', N'evegalcr', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-08T10:32:16.973' AS DateTime))
INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (5, N'98test4@user.comz', N'894960625511796737-xzJWMDsHEEf1BExeOfCmn34GP6kA69j', N'DajDW0BnM3aYjbuzk00g7v7PkUlwvIEx4EeGYrdKSM582', N'894960625511796737', N'evegalac_cr', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-08T10:52:05.663' AS DateTime))
INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (6, N'evega.lac@gmail.com', N'894960625511796737-xzJWMDsHEEf1BExeOfCmn34GP6kA69j', N'DajDW0BnM3aYjbuzk00g7v7PkUlwvIEx4EeGYrdKSM582', N'894960625511796737', N'evegalac_cr', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-08T11:07:58.377' AS DateTime))
INSERT [dbo].[TwitterUser] ([ID], [Email], [OAuth_Token], [OAuth_Token_Secret], [UserId], [ScreenName], [AccessToken], [CreatedDate]) VALUES (7, N'99evega.lac@gmail.com', N'894960625511796737-xzJWMDsHEEf1BExeOfCmn34GP6kA69j', N'DajDW0BnM3aYjbuzk00g7v7PkUlwvIEx4EeGYrdKSM582', N'894960625511796737', N'evegalac_cr', N'AAAAAAAAAAAAAAAAAAAAAFA31wAAAAAAVdGydyTnacTWREaMPS6hn%2FUQQUs%3DmAqAG0vfp8ubnSWOf3JhjebLgAR3dXtTFU71XOJ3VfSLJAH4Pk', CAST(N'2017-08-08T11:09:32.593' AS DateTime))
SET IDENTITY_INSERT [dbo].[TwitterUser] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 8/9/2017 10:26:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConfigApp] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TwitterUser] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
USE [master]
GO
ALTER DATABASE [DemoAppTwitterDB] SET  READ_WRITE 
GO
