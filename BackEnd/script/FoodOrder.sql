USE [master]
GO
/****** Object:  Database [FoodOrder]    Script Date: 7/14/2021 3:05:19 PM ******/
CREATE DATABASE [FoodOrder]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FoodOrder', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FoodOrder.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FoodOrder_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FoodOrder_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FoodOrder].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FoodOrder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FoodOrder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FoodOrder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FoodOrder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FoodOrder] SET ARITHABORT OFF 
GO
ALTER DATABASE [FoodOrder] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FoodOrder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FoodOrder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FoodOrder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FoodOrder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FoodOrder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FoodOrder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FoodOrder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FoodOrder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FoodOrder] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FoodOrder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FoodOrder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FoodOrder] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FoodOrder] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FoodOrder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FoodOrder] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FoodOrder] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FoodOrder] SET RECOVERY FULL 
GO
ALTER DATABASE [FoodOrder] SET  MULTI_USER 
GO
ALTER DATABASE [FoodOrder] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FoodOrder] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FoodOrder] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FoodOrder] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FoodOrder] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'FoodOrder', N'ON'
GO
ALTER DATABASE [FoodOrder] SET QUERY_STORE = OFF
GO
USE [FoodOrder]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [FoodOrder]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 7/14/2021 3:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppUserID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[AddressString] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRole]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppRole](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_AppRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRoleClaim]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppRoleClaim](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppRoleClaim] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[TimeCreateJWT] [datetime2](7) NOT NULL,
	[RefreshToken] [nvarchar](max) NULL,
	[RefreshTokenExpire] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserClaim]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserClaim](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserClaim] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserLogin]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserLogin](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[ProviderKey] [nvarchar](max) NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserLogin] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserRole]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserRole](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AppUserRole] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserToken]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserToken](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserToken] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[AppUserId] [uniqueidentifier] NOT NULL,
	[FoodID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[FoodID] ASC,
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [float] NOT NULL,
	[Count] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[SaleCampaignID] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[FoodID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_FoodCategory] PRIMARY KEY CLUSTERED 
(
	[FoodID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[TimeCreated] [datetime2](7) NOT NULL,
	[Type] [int] NOT NULL,
	[UserReceived] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppUserID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[IsPaid] [bit] NOT NULL,
	[DatePaid] [datetime2](7) NULL,
	[OrderStatusID] [int] NOT NULL,
	[PromotionID] [int] NULL,
	[PromotionAmount] [float] NULL,
	[AddressName] [nvarchar](max) NOT NULL,
	[AddressString] [nvarchar](max) NOT NULL,
	[SaleCampaignID] [int] NULL,
	[FinalTotalPrice] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 7/14/2021 3:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[FoodID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[SaleCampaignID] [int] NULL,
	[SalePercent] [real] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 7/14/2021 3:05:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 7/14/2021 3:05:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Desciption] [nvarchar](300) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[UseTimes] [int] NOT NULL,
	[Percent] [real] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Max] [float] NOT NULL,
	[MinPrice] [float] NOT NULL,
	[IsGlobal] [bit] NOT NULL,
	[Priority] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 7/14/2021 3:05:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[AppUserId] [uniqueidentifier] NULL,
	[FoodID] [int] NOT NULL,
	[Star] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[TimeCreate] [datetime2](7) NOT NULL,
	[OrderID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCampaign]    Script Date: 7/14/2021 3:05:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleCampaign](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Desciption] [nvarchar](max) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Percent] [real] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Priority] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_SaleCampaign] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCampaignFood]    Script Date: 7/14/2021 3:05:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleCampaignFood](
	[FoodID] [int] NOT NULL,
	[SaleCampaignID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TimeDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_SaleCampaignFood] PRIMARY KEY CLUSTERED 
(
	[FoodID] ASC,
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210317162535_Initial', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210317164606_CorrectTableName', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210318161324_Data seeding', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210318162332_Add Promotion amount for order', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210318165558_AddImageTable', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210514092434_ImageDefault', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210515155710_AddImagePathToFood', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210519175021_add_image_for_category', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210520160516_Add_address_table', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210520161027_Remove_old_address_column_in_AppUser_table', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210521145045_Add_Address_Info_to_order', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210522145535_Add_Notification', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210527105710_Add_Promotion_Operation_Condition', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210527112115_remove_promotions_operation_config', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210527150457_Add_List_Food_To_Promotion', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210528084523_Add_priority_for_promotion', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210529083724_Saparate_Promotion_and_SaleCampaign', N'5.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210531020837_Add_Sale_campaign_for_orderDetail', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210531025923_Use_double_for_currency', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210601111511_Add_Rating_ID', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210601134505_One_rating_per_order_per_food', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210601141758_Update_Rating_Table_Remove_UserID', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210601165006_Update_Order_Status', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210603131818_Add_Manager_role', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210603133010_Fix_Password_hashing_when_seeding', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210608154150_Add_FinalPrice_column_to_Order_for_statistic_Purpose', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210610104341_Add_timeCreateJWT_to_user_to_validate_jwt', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210611052700_ReplaceFirstName_Lastname_with_Name', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210626070923_Add_RefreshToken_and_RefreshTokenExpire', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210709085251_Add image to promotion', N'5.0.6')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210712074755_Add_Delete_Field_For_Entity', N'5.0.7')
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (1, N'5d597675-8179-4575-7872-08d90b25fb90', N'Ký túc xá', N'140/11 Đường Bình Quới', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (2, N'5d597675-8179-4575-7872-08d90b25fb90', N'Nhà', N'Ký túc xá khu B DHQG', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (14, N'5d597675-8179-4575-7872-08d90b25fb90', N'test', N'test', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (15, N'77cc3017-42fa-44f0-dae7-08d9365953c4', N'hoàng phong sang', N'620 đỗ xuân hợp', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (16, N'3a418542-eddd-407d-dae8-08d9365953c4', N'hoàng long', N'123 tân bình, quận 9', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (17, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', N'nhà', N'140/11 Bình Quới', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (18, N'bfa9a675-be59-49eb-7711-08d9466da975', N'nhà', N'phú lộc', 0, NULL)
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString], [IsDeleted], [TimeDeleted]) VALUES (19, N'bcb9bc68-7548-476c-27c9-08d946853436', N'nhà', N'123 long xuân, cam ranh', 0, NULL)
SET IDENTITY_INSERT [dbo].[Address] OFF
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp], [IsDeleted], [TimeDeleted]) VALUES (N'74d17d8b-3f91-4d3a-893f-09b4e51e3834', N'This is User role.', N'user', N'USER', N'291213c2-b75c-4c93-ae7a-467383587728', 0, NULL)
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp], [IsDeleted], [TimeDeleted]) VALUES (N'1267bf30-8eea-4370-bbcd-12f74e29c656', N'This is Manager role.', N'manager', N'MANAGER', N'235a3125-d734-4655-916e-7c2ddc8f1b2d', 0, NULL)
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp], [IsDeleted], [TimeDeleted]) VALUES (N'b9e08f48-883c-42dc-a700-da5cf1d81aa3', N'This is Admintrator role.', N'admin', N'ADMIN', N'118a9f9d-dc51-49a6-ab0d-3ad0eeca4488', 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', N'Lien Minh', CAST(N'2021-04-04T00:00:00.0000000' AS DateTime2), N'admin', N'ADMIN', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKjagYUseYWIHsqNAFeA6DNyAuVKtb/FtRfk577UAQOGmS3MQDCBIAxgAchPbd/Xlg==', N'CODK33HAJEEDGGAAM3RPO2SYTZENHL5A', N'0d064502-4465-448f-bf5b-1d3dc83ab2bd', NULL, 0, 0, CAST(N'2021-06-03T13:26:46.0939323+00:00' AS DateTimeOffset), 1, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'dd292c53-6484-47fb-da8b-08d90b239691', N'Quang', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'quang.lienminh_f9efeb40-03f2-40fa-8a65-1889ccbea12f', N'QUANG.LIENMINH', N'quang.lienminh@gameloft.com', N'QUANG.LIENMINH@GAMELOFT.COM', 0, NULL, N'D2LOCU2VAZDWIHZGGIYWANP7QLQANG5M', N'd4f59c0a-c593-46df-9170-3e114a04b547', NULL, 0, 0, NULL, 1, 2, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2021-07-12T17:15:46.0284583' AS DateTime2))
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'admin', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'admin2', N'ADMIN2', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEN1rpZFc37EJ07GfBctD7qYfN8Ly1PHPrqcB2grqflLzIMaJISGT720qnj6JuEUgaw==', N'YWGRVV7LEAW34TN6G4OBV3OIVACNYZRM', N'6a60ea8a-29fd-4d37-88f6-7a9614277de8', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-14T06:14:19.9822862' AS DateTime2), N'QF3dLKcSG2eo5nuIMMkK/IjvACmbGwEZwQ87TMNFNWI=', CAST(N'2021-07-14T08:14:20.5199806' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', N'dung', CAST(N'2021-05-05T00:00:00.0000000' AS DateTime2), N'dung_3867247b-672d-41fb-ba9b-63a6a04d7808', N'DUNG', N'dung@gmail.com', N'DUNG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAELk6gwfL8HDbgX7YlZpvOUj3efuQWt/ySOLHHpdxMkJNQOVAU+cLt1jYwrkjtMLMlA==', N'IMXLAGMD23O2BLQ667MQMH3GJIMCACL5', N'95ea9b2f-33e2-4d52-a548-352fc34287ca', NULL, 0, 0, NULL, 1, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2021-07-12T17:15:27.2373234' AS DateTime2))
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'grandma', CAST(N'2021-06-07T00:00:00.0000000' AS DateTime2), N'grandma_edccbc77-fb0f-40b2-b175-1135431133b2', N'GRANDMA', N'grandma@gmail.com', N'GRANDMA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFpYu0UlmEbJwKRwM0lEcaOF3256gB33Qx3U4io28N7tvVIngO82hoeWRneX25SBeA==', N'JOWQKQ2SEXXWH3XIDG3APPTANHPITFR2', N'113f22f9-b328-40e7-aab4-bd51e0925a99', NULL, 0, 0, NULL, 1, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2021-07-12T17:15:52.0417742' AS DateTime2))
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'8cc76e82-270a-4aaf-e215-08d928271684', N'test2', CAST(N'2021-06-23T00:00:00.0000000' AS DateTime2), N'test2', N'TEST2', N'test2@test2.com', N'TEST2@TEST2.COM', 0, N'AQAAAAEAACcQAAAAEOVbGEhtaTUpbHLhL2iz4XXieLIVryqqkUH8mWgAkB5fQaduiW6b+V5guUq6K9+CPg==', N'ZQQKLPGNI3KGAFOORJWD4ZCS3D3SRSG4', N'f10f1bbc-84ce-4fbe-bbc4-f35831262376', NULL, 0, 0, NULL, 1, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'6edea615-d41f-4370-fb61-08d9298eedeb', N'manager', CAST(N'2021-06-15T00:00:00.0000000' AS DateTime2), N'manager', N'MANAGER', N'manager@gmail.com', N'MANAGER@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEHyfwsvGh9mokpr7KV2uxykSgVm8S046ZHwbJ4K6iWDjc+UUlznunqCLrfdJqu1NEg==', N'KHQE6GOVC4JIBZ75ASHBUFUVB5WPLTIM', N'fd84489c-dfdb-4bab-900f-8635c12f077e', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-12T02:59:24.6507315' AS DateTime2), N'4y2Gr95H8BlyMkjAw50LhaUem4yLzDOkxFK86mblOYE=', CAST(N'2021-07-12T04:59:24.6808511' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'a79e3090-9cd5-461a-7489-08d92be5dcb8', N'Sin', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'096156120', N'096156120', NULL, NULL, 0, N'AQAAAAEAACcQAAAAECUXlnL1Cg/eVbbz3/MVMvrfhnnsTVIMCVQTMeyilbY36HJAlWvkIJXkuyOumfxz5A==', N'DNCQEGNT7MPTPYWCTGXL5W4FVY6GKRG4', N'0e5a9b6d-1a6e-4d57-a926-e4c6418039f6', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-06-10T18:42:30.3634861' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'2594afe6-daf1-4bfc-94a8-08d92c06723d', N'quang liên minh', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'0123456789', N'0123456789', NULL, NULL, 0, N'AQAAAAEAACcQAAAAENg4B+S3WoZ8pcX7SF7bZbslfBwIcl+LTmUeiTLDdDVJX1+rm3jMxXjHLi5ELrwhaw==', N'2EGZRC2QDFLHEWO5LIJBIXRGCY2RRSRN', N'54b290c6-7978-46ad-8ac7-2080ae4f7de3', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-13T17:09:23.5964803' AS DateTime2), N'ZowkUnCV+x4K26A6ahqp+akimZka0W3XJqlLQA7y8zQ=', CAST(N'2021-07-13T19:09:23.5984562' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'070b8c29-8460-4c39-0732-08d9363044b9', N'Phong Sang', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'sang', N'SANG', NULL, NULL, 0, N'AQAAAAEAACcQAAAAEEce/y3Sxkh+9gYGNn1YlpQAZ/POx9cY18B+FnO6dnBfjiTM+MtiwRZr+BvFxRcWtg==', N'DW7BZ6KKBJ6TUUQ4277HSI3SKEZQS6BY', N'64345d9e-1f85-4357-b7c8-675d5e81850e', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-06-23T17:19:47.1486616' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'77cc3017-42fa-44f0-dae7-08d9365953c4', N'Phong Sang', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'0392131844_978be6c9-2d5f-406b-9bc5-aedcef02e8fc', N'0392131844', NULL, NULL, 0, N'AQAAAAEAACcQAAAAEDsAdgvmwJPYWtZE5PmQQdyNtkecBJ80rYwBm5CzsY2djCdzqriIPyl2snu+QW8+HQ==', N'TIFT23WU4YTYW3K2VIGB4ETSZGYXHHWU', N'9dd308d8-eb78-449d-9e55-edcabba2e1a0', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-06-24T21:21:48.2868293' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2021-07-12T16:15:35.0870417' AS DateTime2))
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'3a418542-eddd-407d-dae8-08d9365953c4', N'Long Hoàng', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'0392131888', N'0392131888', NULL, NULL, 0, N'AQAAAAEAACcQAAAAEPLuNoaGDLEIv/GujF2xctsgC7vXhTGekQhudQQODL/PzmfwXbfntbwbprLJsrl35Q==', N'IQTWYK6MEBRCJ5RJ34F2AWZO2DQPTBTV', N'4fe152e7-c06b-4958-ada2-fac90448fec4', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-14T04:56:38.2279629' AS DateTime2), N'wPciSWwNEVaz/xvH66ViaikyX7HGfq8c6hX5u3Zr/sY=', CAST(N'2021-07-14T06:56:38.2409121' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'511d19ba-0edf-4a8a-9e2f-08d944e74afe', N'admin3', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'admin3', N'ADMIN3', NULL, NULL, 0, N'AQAAAAEAACcQAAAAEEZISVM8VsfzgqXOv0bFx2iV/O+8NnLPxVPZuei7hrbLXyyFfGlh5s5jsGHSvtha7w==', N'MNXOWXAROQ27Z3P3MR77K63DTNUHMH7N', N'1bfaf6c3-05a9-494e-a8bd-11f95368a63b', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-14T02:38:06.7849849' AS DateTime2), N'bEZ5PpGab/y0Bp+KQtu2FEPNBNBTrJTchxNGITG7QoE=', CAST(N'2021-07-14T04:38:06.7932453' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'bfa9a675-be59-49eb-7711-08d9466da975', N'quang', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'099999999', N'099999999', NULL, NULL, 0, N'AQAAAAEAACcQAAAAEBQkWmS0Si3UzIieLa1eqIBL1YvvLOhNqdo4G9jdgJbKzPDj6b4owtLh1VsxFcpWyw==', N'EI4MORKH4JWFV67B3EGU4CEK74KHZTBO', N'9a675155-d8bb-4cbe-8bc4-f2c21ac29956', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-14T02:20:47.4507437' AS DateTime2), N'6o/9pVhIxNOCHTTlevmicn2U0fjS/5nEB7y0i80/6II=', CAST(N'2021-07-14T04:20:47.6192555' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'bcb9bc68-7548-476c-27c9-08d946853436', N'quân', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'0392131881', N'0392131881', NULL, NULL, 0, N'AQAAAAEAACcQAAAAENg56CC1YNNFlkTt6zUf2AuDZ6od8xV3rJCmvchd9wPFB/wmLaz+puiZi3OOHQpSmA==', N'SYTLB7X2A2FLLM7DHAJEM6TTDD52QTHO', N'e7d0371b-bba4-4d41-bad3-0150133917b6', NULL, 0, 0, NULL, 1, 0, CAST(N'2021-07-14T07:36:27.5565347' AS DateTime2), N'UmRrD2pM3JYjyOOGoXStC2rPh8a+QQx9Ry9/J1vmey0=', CAST(N'2021-07-14T09:36:28.1146292' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', N'Messi', CAST(N'1990-07-05T00:00:00.0000000' AS DateTime2), N'messi10_6d7112cf-1fb8-4a0e-86a8-3d31ab09135e', NULL, N'messi10@gmail.com', N'MESSI10@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEIHmT9jZM9GsH/1SakDhajrh/dOxVPLxzzTpxZ24IrTZUW99LCWtpjyfzqvnmrvi5A==', NULL, N'c8e22d8f-3315-43b8-99ea-880d1dbfd2e3', N'+111111111', 0, 0, NULL, 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2021-07-12T17:15:39.7058116' AS DateTime2))
INSERT [dbo].[AppUser] ([Id], [Name], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [TimeCreateJWT], [RefreshToken], [RefreshTokenExpire], [IsDeleted], [TimeDeleted]) VALUES (N'b4e253b2-756e-48b8-9c42-b5acb139bed4', N'Jame', CAST(N'1999-05-21T00:00:00.0000000' AS DateTime2), N'admin', NULL, N'jame@gmail.com', N'JAME@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEG8dtPLg+U6aUE9yIPco+EPIGYqP/O/e4dLv1PHNjCCnK7vjdrajxLRfNR7zkRQIoA==', NULL, N'8762c19d-97e0-4fe6-b84c-f5c645952e8f', N'+111111111', 0, 0, NULL, 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, NULL)
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'dd292c53-6484-47fb-da8b-08d90b239691', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'8cc76e82-270a-4aaf-e215-08d928271684', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'a79e3090-9cd5-461a-7489-08d92be5dcb8', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'2594afe6-daf1-4bfc-94a8-08d92c06723d', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'77cc3017-42fa-44f0-dae7-08d9365953c4', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'3a418542-eddd-407d-dae8-08d9365953c4', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'bfa9a675-be59-49eb-7711-08d9466da975', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'bcb9bc68-7548-476c-27c9-08d946853436', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'6edea615-d41f-4370-fb61-08d9298eedeb', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'070b8c29-8460-4c39-0732-08d9363044b9', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'070b8c29-8460-4c39-0732-08d9363044b9', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'511d19ba-0edf-4a8a-9e2f-08d944e74afe', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'b4e253b2-756e-48b8-9c42-b5acb139bed4', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'bfa9a675-be59-49eb-7711-08d9466da975', 40, 8)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'77cc3017-42fa-44f0-dae7-08d9365953c4', 44, 1)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (3, N'Bánh', N'Bánh ngọt, bánh bông lan các loại', N'ab49404d-133e-479f-9d3c-aaab58cc9426.jpg', 1, CAST(N'2021-07-13T21:14:14.7002283' AS DateTime2))
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (10, N'Drink', N'trà sữa, nước ngọt các loại', N'fe73961d-7014-49cd-ace4-e802d692a62c.jpg', 0, NULL)
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (11, N'Burger', N'Bánh Burger', N'b8a57495-bd79-44b8-beef-d05cd636d6ac.jpg', 0, NULL)
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (12, N'Pizza', N'Pizza', N'9309e59e-387e-407b-86f1-230f5012f924.jpg', 0, NULL)
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (13, N'Bánh ngọt', N'Bánh ngọt', N'90bb4ad3-00ef-4baf-8e87-f0fb755cbc4e.jpg', 0, NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (37, N'Vitamin Day', N'Thành Phần: Nước ép cam, nước ép thơm, nha đam, trân châu trắng.', 20000, 100, N'0e0fbd5c-1537-4074-af01-c1bc158b0fad.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (38, N'Chè dưỡng nhan', N'Thành Phần: Chè bao gồm tuyết yến, nấm tuyết, nhựa đào, táo đỏ, kỉ tử. ', 30000, 100, N'f9a0f1af-1138-408a-91ca-f7815f8fb49c.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (39, N'Bạc xỉu', N'Thành phần: Cà phê pha phin, sữa béo, sữa tươi, sữa đặc, thạch cà phê', 15000, 100, N'486058b8-41df-47d1-a283-9ebd03b225d4.jpg', NULL, 1, CAST(N'2021-07-12T17:51:24.4952951' AS DateTime2))
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (40, N'Trà sữa chân trâu', N'Thành phần: Trà đen, bột sữa tách béo, trân châu mật ong', 20000, 100, N'2fc60a81-08ad-4b14-bc15-9d30187b25e3.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (41, N'Matcha sữa dừa', N'Matcha sữa dừa. Thành phần: Bột matcha, sữa tươi, nước cốt dừa, thạch matcha', 25000, 100, N'9d4aa82a-e0a7-4d19-b3f6-8478bcfdb9f5.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (42, N'Dragon Fruit Yakult', N'Thành phần: Yakult, nước ép sơri thanh long, trân châu trắng', 30000, 100, N'bcd326bd-6122-4dd5-8ad4-23af5ead76c9.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (44, N'Bánh phô mai tươi Đài Loan', N'Bánh tươi sử dụng nguyên liệu cao cấp. Kem phomai kết hợp sữa tươi tạo nên lớp bánh vô cùng mềm mịn. Sự kết hợp hòa quyện của sự béo và thơm của sữa phô mai làm cho các thực khác ít ăn bánh ngọt cũng phải siêu lòng.', 20000, 100, N'fd7b8c47-72b2-4e93-8b4f-67124466d3f7.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (45, N'Bánh cuộn cam tươi', N'Bánh bông lan là món bánh được sự yêu thích từ mọi lứa tuổi vì độ mềm mịn và hương vị thơm ngon. Kết hợp với cam càng làm món bánh này sẽ trở nên đặc biệt và vô cùng bắt mắt. Vị ngọt và chua kết hợp tạo nên một sức hút khó cưỡng lại được.', 30000, 100, N'4dcbb67f-1e48-4a9a-a54d-d212b6d73d6b.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (46, N'Bánh quy phô mai hạnh nhân', N'Món bánh quy  kiểu hơi mềm, không cứng giòn. Nó có vị bùi của hạnh nhân, mằn mặn của phô mai và rất thơm nhờ vào hương vị của phô mai. ', 12000, 100, N'48e30ac1-306a-4aa7-bd4d-91583c517777.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (47, N'Bánh bông lan bơ chanh', N'Bánh bông lan bơ chanh vừa có trứng đánh bông, vừa có khá nhiều bơ, nên là bánh vừa mềm nhẹ nhưng vẫn thơm ngậy nhờ bơ, và có thêm vị chua thơm the the của chanh nữa. Đơn giản nhưng rất hiệu quả.', 25000, 100, N'876490ae-6686-4179-93fe-c3a2f25a22ac.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (48, N'Bò tắm phô mai', N'Thành phần: Bò, phô mai miếng, cà chua, thịt xông khói', 50000, 100, N'573d04fe-5630-41e2-8823-c7b83d2cf0f1.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (49, N'Burger bò nướng khoai tây lát', N'Thành phần: bò nướng, khoay tây lát, hành tím, xà lách, cà chua', 50000, 100, N'6a5424c1-fa74-4a97-aa46-77ec9a9031d2.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (50, N'Burger siêu nhân phô mai', N'Thành phần: bò nướng, phô mai miếng, hành chiên', 40000, 100, N'087cf3a8-f674-4bd9-9939-880f5a6fd4b3.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (51, N'Burger bò khoai giòn tràn phô mai ', N'Thành phần: bò nướng, thịt xông khói, phô mai chảy, phô mai miếng, xà lách, cà chua', 60000, 100, N'67c2f9eb-2a28-46ce-8d66-005e7d124e2d.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (52, N'Burger bò phô mai', N'Thành phần: bò nướng, phô mai', 30000, 100, N'e63f14ae-3c35-47f2-990e-8fdff00e7d51.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (53, N'Pizza Hải Sản Xốt Mayonnaise - Ocean Mania', N'Pizza Hải Sản Xốt Mayonnaise - Ocean Mania. Thành phần: Xốt Cà Chua, Phô Mai Mozzarella, Tôm, Mực, Thanh Cua, Hành Tây', 100000, 100, N'27abac6f-0e6d-47fd-bfcf-b8ed4727b48f.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (54, N'Pizza Thập Cẩm', N'Pizza Thập Cẩm. Thành phần: Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Ớt Chuông Xanh, Nấm Mỡ, Hành Tây, Ô-liu', 70000, 100, N'c4253fb8-fc32-4b78-a72e-bc6b1227e598.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (55, N'Pizza 5 Loại Thịt Thượng Hạng - Meat Lovers', N'Pizza 5 Loại Thịt Thượng Hạng - Meat Lovers. Thành phần: Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Thịt Heo Muối', 80000, 100, N'b271d94e-75bd-4584-b47e-022b84f9d3ae.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (56, N'Pizza Xúc Xích Ý Truyền Thống', N' Pizza Xúc Xích Ý Truyền Thống. Thành phần: Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni', 90000, 100, N'14d2b1a3-5574-4b91-961b-f00d0073c823.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (57, N'Pizza Bò & Tôm Nướng Kiểu Mỹ', N' Pizza Bò & Tôm Nướng Kiểu Mỹ. Thành phần: Xốt Cà Chua, Xốt Phô Mai, Phô Mai Mozzarella, Tôm, Thịt Bò Mexico, Cà Chua, Hành Tây', 100000, 100, N'b13711d3-50da-4190-ad5e-866a622e1c3b.jpg', NULL, 0, NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (58, N'Pizza Gà Xốt Tương Kiểu Nhật', N'Pizza Gà Xốt Tương Kiểu Nhật. Thành phần: Xốt Teriyaki, Phô Mai Mozzarella, Mayonnaise, Gà, Nấm Mỡ, Hành Tây', 100000, 100, N'fdf00063-3209-4244-86fb-2e44eab27f8f.jpg', NULL, 0, NULL)
SET IDENTITY_INSERT [dbo].[Food] OFF
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (37, 10, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (38, 10, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (39, 10, 1, CAST(N'2021-07-12T17:51:24.4949597' AS DateTime2))
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (40, 10, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (41, 10, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (42, 10, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (44, 13, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (45, 13, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (46, 13, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (47, 13, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (48, 11, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (49, 11, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (50, 11, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (51, 11, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (52, 11, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (53, 12, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (54, 12, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (55, 12, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (56, 12, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (57, 12, 0, NULL)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID], [IsDeleted], [TimeDeleted]) VALUES (58, 12, 0, NULL)
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([ID], [UserID], [Title], [Message], [TimeCreated], [Type], [UserReceived], [IsDeleted], [TimeDeleted]) VALUES (1, N'5d597675-8179-4575-7872-08d90b25fb90', N'TEst', N'Test message', CAST(N'2021-05-22T22:46:54.1942777' AS DateTime2), 1, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (8, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:08:48.9688416' AS DateTime2), 1, CAST(N'2021-05-22T17:45:11.6354643' AS DateTime2), 4, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (11, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:09:51.5907874' AS DateTime2), 0, NULL, 5, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (19, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-22T02:51:53.6168379' AS DateTime2), 0, NULL, 5, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (44, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T11:09:16.3904508' AS DateTime2), 1, CAST(N'2021-05-31T22:17:29.1421333' AS DateTime2), 4, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (45, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:16:18.3551142' AS DateTime2), 1, CAST(N'2021-06-09T21:17:21.0526873' AS DateTime2), 4, 3, 10800, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (46, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:19:58.1456997' AS DateTime2), 1, CAST(N'2021-06-02T14:18:36.0967419' AS DateTime2), 4, 1, 5000, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (47, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:20:38.0550788' AS DateTime2), 1, CAST(N'2021-06-09T21:26:19.9036913' AS DateTime2), 4, 1, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (58, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:14:58.5293736' AS DateTime2), 0, CAST(N'2021-06-09T21:55:58.0237448' AS DateTime2), 5, 3, 3570, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (59, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:16:39.0079887' AS DateTime2), 1, CAST(N'2021-07-08T15:46:04.9273201' AS DateTime2), 4, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (60, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:48:31.7255892' AS DateTime2), 1, CAST(N'2021-07-08T15:46:42.0816299' AS DateTime2), 4, 3, 11220, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (61, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:49:26.9676837' AS DateTime2), 1, CAST(N'2021-07-08T15:47:43.7163714' AS DateTime2), 4, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (62, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:50:40.3511312' AS DateTime2), 1, CAST(N'2021-07-08T15:46:59.5440960' AS DateTime2), 4, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (69, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:24:46.8557270' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 1, CAST(N'2021-07-13T21:18:54.6848416' AS DateTime2))
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (70, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:25:04.5202583' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 1, CAST(N'2021-07-13T21:19:08.1392191' AS DateTime2))
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (71, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:27:39.4842848' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Nhà', N'Ký túc xá khu B DHQG', NULL, 0, 1, CAST(N'2021-07-13T21:19:20.1842015' AS DateTime2))
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (72, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T16:55:13.0638867' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 1, CAST(N'2021-07-13T21:19:26.2220451' AS DateTime2))
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (73, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-02T17:59:29.0045317' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL, 0, 1, CAST(N'2021-07-13T21:19:32.2621701' AS DateTime2))
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (80, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-23T22:24:06.5538562' AS DateTime2), 1, CAST(N'2021-06-23T22:25:09.1261808' AS DateTime2), 4, 1, 5000, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 95000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (85, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-06-23T22:29:14.9075496' AS DateTime2), 1, CAST(N'2021-06-23T22:35:43.5061671' AS DateTime2), 4, 1, 5000, N'hoàng long', N'123 tân bình, quận 9', NULL, 165000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (88, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-06-24T14:41:04.0259437' AS DateTime2), 1, CAST(N'2021-06-24T14:44:53.1233622' AS DateTime2), 4, NULL, NULL, N'hoàng long', N'123 tân bình, quận 9', NULL, 160000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (90, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-06-24T14:41:51.6056815' AS DateTime2), 1, CAST(N'2021-06-24T14:45:12.2065467' AS DateTime2), 4, NULL, NULL, N'hoàng long', N'123 tân bình, quận 9', NULL, 20000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (91, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-06-24T14:42:22.9976673' AS DateTime2), 1, CAST(N'2021-06-24T14:45:37.6170866' AS DateTime2), 4, NULL, NULL, N'hoàng long', N'123 tân bình, quận 9', NULL, 75000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (92, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-06-24T14:50:33.9567266' AS DateTime2), 1, CAST(N'2021-06-24T14:51:04.6054876' AS DateTime2), 4, NULL, NULL, N'hoàng long', N'123 tân bình, quận 9', NULL, 731500, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (93, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T15:26:30.5925282' AS DateTime2), 1, CAST(N'2021-06-24T15:27:49.3062914' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 30000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (94, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T15:26:57.7902648' AS DateTime2), 1, CAST(N'2021-06-24T15:28:19.4183758' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 17000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (95, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T15:27:08.8614152' AS DateTime2), 1, CAST(N'2021-06-24T15:28:32.1202444' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 76500, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (96, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T15:27:21.0903594' AS DateTime2), 1, CAST(N'2021-06-24T15:28:44.6521725' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 50000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (97, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T19:27:53.4571107' AS DateTime2), 1, CAST(N'2021-06-24T20:29:58.5076888' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 100000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (98, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T19:50:34.3253838' AS DateTime2), 1, CAST(N'2021-06-24T20:30:18.9876446' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 30000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (99, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T19:51:04.2036503' AS DateTime2), 1, CAST(N'2021-06-24T20:30:31.4052735' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 17000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (100, N'77cc3017-42fa-44f0-dae7-08d9365953c4', CAST(N'2021-06-24T20:52:36.5486256' AS DateTime2), 1, CAST(N'2021-07-13T21:19:43.6926898' AS DateTime2), 4, NULL, NULL, N'hoàng phong sang', N'620 đỗ xuân hợp', NULL, 12000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (101, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-06-25T21:01:31.9517989' AS DateTime2), 0, NULL, 2, NULL, NULL, N'nhà', N'140/11 Bình Quới', NULL, 34000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (102, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-06-25T21:05:34.9181555' AS DateTime2), 1, CAST(N'2021-06-25T21:58:12.6551004' AS DateTime2), 4, 1, 5000, N'nhà', N'140/11 Bình Quới', NULL, 80000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (103, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-06-25T21:28:42.0587762' AS DateTime2), 1, CAST(N'2021-06-25T21:52:11.7117485' AS DateTime2), 4, 1, 5000, N'nhà', N'140/11 Bình Quới', NULL, 131000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (104, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-06-27T23:03:54.6696660' AS DateTime2), 1, CAST(N'2021-07-08T15:47:18.5125747' AS DateTime2), 4, NULL, NULL, N'nhà', N'140/11 Bình Quới', NULL, 51000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (105, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-07-06T14:34:19.3442189' AS DateTime2), 0, NULL, 2, NULL, NULL, N'nhà', N'140/11 Bình Quới', NULL, 102000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (110, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-07-07T18:06:40.9820950' AS DateTime2), 1, CAST(N'2021-07-08T15:49:07.2639911' AS DateTime2), 4, NULL, NULL, N'nhà', N'140/11 Bình Quới', NULL, 20000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (111, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-07-07T22:10:52.9719572' AS DateTime2), 1, CAST(N'2021-07-08T15:48:38.5175335' AS DateTime2), 4, NULL, NULL, N'nhà', N'140/11 Bình Quới', NULL, 17000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (117, N'2594afe6-daf1-4bfc-94a8-08d92c06723d', CAST(N'2021-07-08T15:02:23.7695744' AS DateTime2), 1, CAST(N'2021-07-08T15:48:17.1743052' AS DateTime2), 4, 1, 25000, N'nhà', N'140/11 Bình Quới', NULL, 148000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (118, N'bfa9a675-be59-49eb-7711-08d9466da975', CAST(N'2021-07-14T09:28:39.6120485' AS DateTime2), 0, NULL, 2, 4, 75000, N'nhà', N'phú lộc', NULL, 125000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (119, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-07-14T11:57:13.1891399' AS DateTime2), 1, CAST(N'2021-07-14T12:03:30.8932446' AS DateTime2), 4, 4, 75000, N'hoàng long', N'123 tân bình, quận 9', NULL, 235000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (121, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-07-14T11:58:33.6601328' AS DateTime2), 1, CAST(N'2021-07-14T12:03:48.7858570' AS DateTime2), 4, NULL, NULL, N'hoàng long', N'123 tân bình, quận 9', NULL, 195000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (122, N'3a418542-eddd-407d-dae8-08d9365953c4', CAST(N'2021-07-14T11:59:18.8885369' AS DateTime2), 1, CAST(N'2021-07-14T12:03:58.8089518' AS DateTime2), 4, 1, 45000, N'hoàng long', N'123 tân bình, quận 9', NULL, 451500, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (123, N'bcb9bc68-7548-476c-27c9-08d946853436', CAST(N'2021-07-14T12:07:59.3295128' AS DateTime2), 1, CAST(N'2021-07-14T12:09:15.6818196' AS DateTime2), 4, NULL, NULL, N'nhà', N'123 long xuân, cam ranh', NULL, 51000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (124, N'bcb9bc68-7548-476c-27c9-08d946853436', CAST(N'2021-07-14T12:08:38.4851125' AS DateTime2), 1, CAST(N'2021-07-14T12:09:28.8987645' AS DateTime2), 4, 4, 75000, N'nhà', N'123 long xuân, cam ranh', NULL, 95000, 0, NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID], [FinalTotalPrice], [IsDeleted], [TimeDeleted]) VALUES (125, N'bcb9bc68-7548-476c-27c9-08d946853436', CAST(N'2021-07-14T14:37:43.6209628' AS DateTime2), 0, NULL, 2, NULL, NULL, N'nhà', N'123 long xuân, cam ranh', NULL, 40000, 0, NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (80, 44, 5, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (88, 55, 2, 80000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (90, 44, 1, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (91, 41, 1, 25000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (91, 48, 1, 50000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 37, 1, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 38, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 39, 1, 15000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 40, 1, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 42, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 45, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 46, 1, 12000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 47, 1, 25000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 48, 1, 50000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 49, 1, 50000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 50, 1, 40000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 51, 1, 60000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 52, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 53, 1, 100000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 54, 1, 70000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 56, 1, 90000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (92, 57, 1, 100000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (93, 45, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (94, 40, 1, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (95, 56, 1, 90000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (96, 48, 1, 50000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (97, 44, 5, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (98, 45, 1, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (99, 40, 1, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (100, 46, 1, 12000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (101, 40, 2, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (102, 40, 2, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (102, 51, 1, 60000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (103, 40, 2, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (103, 51, 2, 60000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (104, 51, 1, 60000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (105, 40, 1, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (105, 53, 1, 100000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (110, 44, 1, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (111, 40, 1, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (117, 40, 4, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (117, 44, 1, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (117, 53, 1, 100000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (118, 57, 2, 100000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (119, 44, 3, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (119, 48, 5, 50000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (121, 37, 4, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (121, 41, 3, 25000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (121, 44, 2, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (122, 53, 2, 100000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (122, 54, 1, 70000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (122, 55, 1, 80000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (122, 56, 1, 90000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (122, 58, 1, 100000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (123, 40, 3, 20000, 1, 15, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (124, 44, 2, 20000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (124, 45, 2, 30000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (124, 54, 1, 70000, NULL, NULL, 0, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent], [IsDeleted], [TimeDeleted]) VALUES (125, 37, 2, 20000, NULL, NULL, 0, NULL)
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (2, N'Đang chuẩn bị', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (3, N'Đang giao hàng', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (4, N'Đã nhận hàng', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (5, N'Đã hủy', N'')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (1, N'Ăn thả ga | Giảm 40%', N'ANTHAGA40', N'Ăn thả ga, giảm ngay 40% cho tất cả các đơn hàng. ', CAST(N'2021-07-12T14:47:54.0500046' AS DateTime2), CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 4, 40, 1, 45000, 100000, 1, 4, N'a2b7903e-064b-4505-91d1-daaf404d46f8.jpg', 0, NULL)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (3, N'Ăn thả ga | Khao 20%.', N'ANTHAGA20', N'Ăn thả ga. Khao 20% cho tất cả các đơn hàng.', CAST(N'2021-05-05T17:56:00.0000000' AS DateTime2), CAST(N'2022-02-24T17:56:00.0000000' AS DateTime2), 3, 20, 1, 20000, 70000, 0, 0, N'445b17b4-3d8b-40b1-b216-f10796baf701.jpg', 0, NULL)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (4, N'Ăn thả ga | Giảm 50%', N'ANTHAGA50', N'Ăn thả ga. Giảm 50% cho tất cả các đơn hàng', CAST(N'2021-07-09T18:37:00.0000000' AS DateTime2), CAST(N'2021-11-09T18:37:00.0000000' AS DateTime2), 1, 50, 1, 75000, 140000, 0, 1, N'd83fbd0b-ecb2-4746-b807-1a933ada5d95.jpg', 0, NULL)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (5, N'An thả ga | Giảm 30%', N'ANTHAGA30', N'An thả ga | Giảm 30%', CAST(N'2021-07-23T18:40:00.0000000' AS DateTime2), CAST(N'2021-10-22T18:40:00.0000000' AS DateTime2), 3, 30, 0, 40000, 120000, 0, 2, N'5e71d1d5-03e4-4aa3-bdc1-c7a9ca0020d0.jpg', 0, NULL)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority], [ImagePath], [IsDeleted], [TimeDeleted]) VALUES (6, N'Ăn thả ga | Giảm 10%', N'ANTHAGA10', N'Ăn thả ga | Giảm 10%', CAST(N'2021-07-29T18:42:00.0000000' AS DateTime2), CAST(N'2021-07-28T18:42:00.0000000' AS DateTime2), 4, 10, 0, 15000, 50000, 0, 4, N'7d8eec02-25e8-413c-ba2e-a077a1cea9f3.jpg', 0, NULL)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 44, 3, N'bánh ngon nhưng hơi nhạt', CAST(N'2021-06-23T22:25:29.0772667' AS DateTime2), 80, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 55, 5, N'đã ăn qua nhiều quán pizza nhưng ở đây vẫn là đỉnh của đỉnh', CAST(N'2021-06-24T14:48:54.8679429' AS DateTime2), 88, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 44, 4, N'bánh hơi ngọt nhưng xốpp mềm và ngon', CAST(N'2021-06-24T14:48:25.2576199' AS DateTime2), 90, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 41, 5, N'matcha bình thường rất đắng nhưng ở quán thì lại rất vừa và ngon', CAST(N'2021-06-24T14:47:21.4867082' AS DateTime2), 91, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 48, 5, N'burger ở quán thì ngon thôi rồi. 100 điểm', CAST(N'2021-06-24T14:48:07.3597168' AS DateTime2), 91, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 37, 5, N'thức uống đúng chuâne cho hè nóng bức như thế này ở sg', CAST(N'2021-06-24T14:51:49.5266481' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 38, 4, N'lần đầu nghe tên chè thật lạ. nhưng vị cũng thật lạ và ngon ^^. ', CAST(N'2021-06-24T14:52:23.2354149' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 39, 5, N'một con nghiện bạc xỉu như mình đã phải siêu lòng bạc xỉu ở đây mất rồi hehe', CAST(N'2021-06-24T14:53:09.5868329' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 40, 3, N'hơi ngọt nhưng chân trâu thì ngon lắm', CAST(N'2021-06-24T14:53:26.2481224' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 42, 5, N'ôi dồi ôi. chân âi của tui đây rồi. rất ngon và mát', CAST(N'2021-06-24T14:53:51.5080608' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 45, 5, N'cũn đã thử làm ở nhà nhưng k bằng quán được. quán làm ngon và mịn lắm', CAST(N'2021-06-24T14:54:21.5237021' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 46, 5, N'ít khi ăn bânh quy nhưng h chắc phải thay đôi thôi hehe', CAST(N'2021-06-24T14:54:45.5400212' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 47, 3, N'bánh bông lan ngon nhưng mình k thích kết hợp với chanh cho lắm', CAST(N'2021-06-24T14:55:10.9455511' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 48, 5, N'ngon lắm muốn ăn 2 cái nhưng sợ béo :)))', CAST(N'2021-06-24T14:55:37.5247379' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 49, 5, N'ngon hơn các chỗ như burger king hay kfc nhiều', CAST(N'2021-06-24T14:56:04.2368033' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 50, 5, N'ngon nhưng mà lần sau mong cho em nhiều sốt hơn tí nữa', CAST(N'2021-06-24T14:56:27.5577846' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 51, 5, N'cái thứ 3 trong ngày r đó. ngon thật sự', CAST(N'2021-06-24T14:56:48.1791177' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 52, 5, N'tìm đâu ra quán bán burger như này nữa trời hehe. ủng hộ dài dài', CAST(N'2021-06-24T14:57:19.5480174' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 53, 5, N'mình mua cho cả nhà ăn. ai cũng khen ngon tấm tắc hehe', CAST(N'2021-06-24T14:57:39.5186506' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 54, 3, N'bánh này ngon nhưng vỏ hơi cứng. mấy bé nhà mình ăn k đc ', CAST(N'2021-06-24T14:58:05.3311081' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 56, 5, N'đúng chuẩn vị ý. ngon', CAST(N'2021-06-24T14:58:27.5606911' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 57, 5, N'pizza ngon k thể chê. 10000 điểm lần sau nhất định mua tiếp', CAST(N'2021-06-24T14:58:49.4812461' AS DateTime2), 92, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 45, 5, N'yumi yumi ngon quá xá', CAST(N'2021-06-24T15:30:14.1828071' AS DateTime2), 93, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 40, 5, N'tín đồ của trà sữa như tui đã đổ gục trước món trà sữa ở quán mình', CAST(N'2021-06-24T15:30:03.0156209' AS DateTime2), 94, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 56, 5, N'pizza tuyyệt vời cho cả gia đình', CAST(N'2021-06-24T15:29:38.0085250' AS DateTime2), 95, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 48, 5, N'ta nói nó ngon k thể cưỡng lại được', CAST(N'2021-06-24T15:29:16.7334391' AS DateTime2), 96, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 40, 4, N'ngon', CAST(N'2021-06-25T21:58:24.4914021' AS DateTime2), 102, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 51, 4, N'tốt', CAST(N'2021-06-25T21:58:31.2351817' AS DateTime2), 102, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 40, 4, N'ngon', CAST(N'2021-06-25T21:52:52.8950218' AS DateTime2), 103, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 40, 4, N'ngon', CAST(N'2021-07-08T15:49:23.6289225' AS DateTime2), 117, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 44, 4, N'ngon lắm', CAST(N'2021-07-14T12:06:13.8837950' AS DateTime2), 119, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 48, 4, N'bò nhiều dễ sợ ', CAST(N'2021-07-14T12:06:07.8968217' AS DateTime2), 119, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 37, 3, N'mùa hè làm 1 ly còn gì bằng', CAST(N'2021-07-14T12:05:19.9655693' AS DateTime2), 121, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 41, 5, N'mâtch siêu đỉnh', CAST(N'2021-07-14T12:05:34.0737368' AS DateTime2), 121, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 44, 4, N'pefect', CAST(N'2021-07-14T12:05:41.5381755' AS DateTime2), 121, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 53, 4, N'ngon quá điiiiiii', CAST(N'2021-07-14T12:04:17.0509460' AS DateTime2), 122, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 54, 5, N'ngon thực sự', CAST(N'2021-07-14T12:04:35.7924306' AS DateTime2), 122, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 55, 4, N'', CAST(N'2021-07-14T12:04:38.9225712' AS DateTime2), 122, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 56, 3, N'hơi tệ so với mong đợi', CAST(N'2021-07-14T12:04:49.9233558' AS DateTime2), 122, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 58, 4, N'ngon!!!', CAST(N'2021-07-14T12:04:57.0034322' AS DateTime2), 122, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 44, 5, N'100 điểmmmm', CAST(N'2021-07-14T12:09:50.7551913' AS DateTime2), 124, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 45, 5, N'ngon quá', CAST(N'2021-07-14T12:09:55.8830393' AS DateTime2), 124, 0, NULL)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID], [IsDeleted], [TimeDeleted]) VALUES (NULL, 54, 5, N'ngon thật sự', CAST(N'2021-07-14T12:10:10.1826438' AS DateTime2), 124, 0, NULL)
SET IDENTITY_INSERT [dbo].[SaleCampaign] ON 

INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority], [IsDeleted], [TimeDeleted]) VALUES (1, N'Ăn no không lo giá | Giảm 15%', N'Giảm 15% tất cả các món ăn trong danh sách', CAST(N'2021-05-11T16:39:00.0000000' AS DateTime2), CAST(N'2021-11-06T16:39:00.0000000' AS DateTime2), 15, 1, 1, 0, NULL)
INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority], [IsDeleted], [TimeDeleted]) VALUES (2, N'test', N'test', CAST(N'2021-05-27T21:24:00.0000000' AS DateTime2), CAST(N'2021-06-01T21:24:00.0000000' AS DateTime2), 30, 0, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[SaleCampaign] OFF
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (40, 1, 0, NULL)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (51, 1, 0, NULL)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (53, 1, 0, NULL)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID], [IsDeleted], [TimeDeleted]) VALUES (56, 1, 0, NULL)
/****** Object:  Index [IX_Address_AppUserID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Address_AppUserID] ON [dbo].[Address]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AppRole]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppRoleClaim_RoleId]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppRoleClaim_RoleId] ON [dbo].[AppRoleClaim]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AppUser]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AppUser]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserClaim_UserId]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserClaim_UserId] ON [dbo].[AppUserClaim]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserRole_RoleId]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserRole_RoleId] ON [dbo].[AppUserRole]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cart_AppUserId]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cart_AppUserId] ON [dbo].[Cart]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Food_SaleCampaignID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Food_SaleCampaignID] ON [dbo].[Food]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodCategory_CategoryID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodCategory_CategoryID] ON [dbo].[FoodCategory]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notification_UserID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notification_UserID] ON [dbo].[Notification]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_AppUserID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_AppUserID] ON [dbo].[Order]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_OrderStatusID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_OrderStatusID] ON [dbo].[Order]
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_PromotionID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_PromotionID] ON [dbo].[Order]
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_SaleCampaignID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_SaleCampaignID] ON [dbo].[Order]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetail_FoodID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetail_FoodID] ON [dbo].[OrderDetail]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetail_SaleCampaignID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetail_SaleCampaignID] ON [dbo].[OrderDetail]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_AppUserId]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Rating_AppUserId] ON [dbo].[Rating]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_FoodID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Rating_FoodID] ON [dbo].[Rating]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SaleCampaignFood_SaleCampaignID]    Script Date: 7/14/2021 3:05:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_SaleCampaignFood_SaleCampaignID] ON [dbo].[SaleCampaignFood]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Address] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AppRole] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AppUser] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [TimeCreateJWT]
GO
ALTER TABLE [dbo].[AppUser] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [RefreshTokenExpire]
GO
ALTER TABLE [dbo].[AppUser] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Notification] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsPaid]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (N'') FOR [AddressName]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (N'') FOR [AddressString]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [FinalTotalPrice]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((1)) FOR [Amount]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-07-12T14:47:53.9962564+07:00') FOR [StartDate]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-07-12T14:47:53.9977324+07:00') FOR [EndDate]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([real],(10))) FOR [Percent]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Enabled]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsGlobal]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (N'default.png') FOR [ImagePath]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT ((5)) FOR [Star]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [TimeCreate]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SaleCampaign] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SaleCampaignFood] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_AppUser_AppUserID] FOREIGN KEY([AppUserID])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_AppUser_AppUserID]
GO
ALTER TABLE [dbo].[AppRoleClaim]  WITH CHECK ADD  CONSTRAINT [FK_AppRoleClaim_AppRole_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AppRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppRoleClaim] CHECK CONSTRAINT [FK_AppRoleClaim_AppRole_RoleId]
GO
ALTER TABLE [dbo].[AppUserClaim]  WITH CHECK ADD  CONSTRAINT [FK_AppUserClaim_AppUser_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppUserClaim] CHECK CONSTRAINT [FK_AppUserClaim_AppUser_UserId]
GO
ALTER TABLE [dbo].[AppUserLogin]  WITH CHECK ADD  CONSTRAINT [FK_AppUserLogin_AppUser_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppUserLogin] CHECK CONSTRAINT [FK_AppUserLogin_AppUser_UserId]
GO
ALTER TABLE [dbo].[AppUserRole]  WITH CHECK ADD  CONSTRAINT [FK_AppUserRole_AppRole_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AppRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppUserRole] CHECK CONSTRAINT [FK_AppUserRole_AppRole_RoleId]
GO
ALTER TABLE [dbo].[AppUserRole]  WITH CHECK ADD  CONSTRAINT [FK_AppUserRole_AppUser_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppUserRole] CHECK CONSTRAINT [FK_AppUserRole_AppUser_UserId]
GO
ALTER TABLE [dbo].[AppUserToken]  WITH CHECK ADD  CONSTRAINT [FK_AppUserToken_AppUser_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppUserToken] CHECK CONSTRAINT [FK_AppUserToken_AppUser_UserId]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_AppUser_AppUserId] FOREIGN KEY([AppUserId])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_AppUser_AppUserId]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Food_FoodID]
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD  CONSTRAINT [FK_Food_SaleCampaign_SaleCampaignID] FOREIGN KEY([SaleCampaignID])
REFERENCES [dbo].[SaleCampaign] ([ID])
GO
ALTER TABLE [dbo].[Food] CHECK CONSTRAINT [FK_Food_SaleCampaign_SaleCampaignID]
GO
ALTER TABLE [dbo].[FoodCategory]  WITH CHECK ADD  CONSTRAINT [FK_FoodCategory_Category_CategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FoodCategory] CHECK CONSTRAINT [FK_FoodCategory_Category_CategoryID]
GO
ALTER TABLE [dbo].[FoodCategory]  WITH CHECK ADD  CONSTRAINT [FK_FoodCategory_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FoodCategory] CHECK CONSTRAINT [FK_FoodCategory_Food_FoodID]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_AppUser_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_AppUser_UserID]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_AppUser_AppUserID] FOREIGN KEY([AppUserID])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_AppUser_AppUserID]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus_OrderStatusID] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus_OrderStatusID]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Promotion_PromotionID] FOREIGN KEY([PromotionID])
REFERENCES [dbo].[Promotion] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Promotion_PromotionID]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_SaleCampaign_SaleCampaignID] FOREIGN KEY([SaleCampaignID])
REFERENCES [dbo].[SaleCampaign] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_SaleCampaign_SaleCampaignID]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Food_FoodID]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order_OrderID]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_SaleCampaign_SaleCampaignID] FOREIGN KEY([SaleCampaignID])
REFERENCES [dbo].[SaleCampaign] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_SaleCampaign_SaleCampaignID]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_AppUser_AppUserId] FOREIGN KEY([AppUserId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_AppUser_AppUserId]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Food_FoodID]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Order_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Order_OrderID]
GO
ALTER TABLE [dbo].[SaleCampaignFood]  WITH CHECK ADD  CONSTRAINT [FK_SaleCampaignFood_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SaleCampaignFood] CHECK CONSTRAINT [FK_SaleCampaignFood_Food_FoodID]
GO
ALTER TABLE [dbo].[SaleCampaignFood]  WITH CHECK ADD  CONSTRAINT [FK_SaleCampaignFood_SaleCampaign_SaleCampaignID] FOREIGN KEY([SaleCampaignID])
REFERENCES [dbo].[SaleCampaign] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SaleCampaignFood] CHECK CONSTRAINT [FK_SaleCampaignFood_SaleCampaign_SaleCampaignID]
GO
USE [master]
GO
ALTER DATABASE [FoodOrder] SET  READ_WRITE 
GO
