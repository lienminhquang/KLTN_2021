USE [FoodOrder]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
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
/****** Object:  Table [dbo].[Address]    Script Date: 6/6/2021 8:38:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppUserID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[AddressString] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRole]    Script Date: 6/6/2021 8:38:19 PM ******/
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
 CONSTRAINT [PK_AppRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRoleClaim]    Script Date: 6/6/2021 8:38:19 PM ******/
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
/****** Object:  Table [dbo].[AppUser]    Script Date: 6/6/2021 8:38:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NOT NULL,
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
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserClaim]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[AppUserLogin]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[AppUserRole]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[AppUserToken]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 6/6/2021 8:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 6/6/2021 8:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[Price] [float] NOT NULL,
	[Count] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[SaleCampaignID] [int] NULL,
 CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 6/6/2021 8:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[FoodID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_FoodCategory] PRIMARY KEY CLUSTERED 
(
	[FoodID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 6/6/2021 8:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FoodID] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
	[Caption] [nvarchar](max) NULL,
	[SortOrder] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 6/6/2021 8:38:20 PM ******/
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
/****** Object:  Table [dbo].[Promotion]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCampaign]    Script Date: 6/6/2021 8:38:20 PM ******/
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
 CONSTRAINT [PK_SaleCampaign] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCampaignFood]    Script Date: 6/6/2021 8:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleCampaignFood](
	[FoodID] [int] NOT NULL,
	[SaleCampaignID] [int] NOT NULL,
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
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (1, N'5d597675-8179-4575-7872-08d90b25fb90', N'Ký túc xá', N'140/11 Đường Bình Quới')
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (2, N'5d597675-8179-4575-7872-08d90b25fb90', N'Nhà', N'Ký túc xá khu B DHQG')
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (13, N'ca0740d8-cd01-45e1-fa78-08d925bd8d37', N'pari', N'pari sant')
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (14, N'5d597675-8179-4575-7872-08d90b25fb90', N'test', N'test')
SET IDENTITY_INSERT [dbo].[Address] OFF
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'74d17d8b-3f91-4d3a-893f-09b4e51e3834', N'This is User role.', N'user', N'USER', N'2445637a-03ac-49af-94c9-6f3d4d368b81')
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'1267bf30-8eea-4370-bbcd-12f74e29c656', N'This is Manager role.', N'manager', N'MANAGER', N'6682e8eb-cf7a-4a54-a8ee-9fe4cb3c5d71')
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b9e08f48-883c-42dc-a700-da5cf1d81aa3', N'This is Admintrator role.', N'admin', N'ADMIN', N'ad20edcb-1450-4354-a88a-69df305bff67')
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', N'Quang', N'Lien Minh', CAST(N'2021-04-04T00:00:00.0000000' AS DateTime2), N'admin', N'ADMIN', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKjagYUseYWIHsqNAFeA6DNyAuVKtb/FtRfk577UAQOGmS3MQDCBIAxgAchPbd/Xlg==', N'CODK33HAJEEDGGAAM3RPO2SYTZENHL5A', N'0d064502-4465-448f-bf5b-1d3dc83ab2bd', NULL, 0, 0, CAST(N'2021-06-03T13:26:46.0939323+00:00' AS DateTimeOffset), 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'dd292c53-6484-47fb-da8b-08d90b239691', N'Quang', N'Quang', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'quang.lienminh', N'QUANG.LIENMINH', N'quang.lienminh@gameloft.com', N'QUANG.LIENMINH@GAMELOFT.COM', 0, NULL, N'D2LOCU2VAZDWIHZGGIYWANP7QLQANG5M', N'd4f59c0a-c593-46df-9170-3e114a04b547', NULL, 0, 0, NULL, 1, 2)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'admin', N'admin', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'admin2', N'ADMIN2', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEN1rpZFc37EJ07GfBctD7qYfN8Ly1PHPrqcB2grqflLzIMaJISGT720qnj6JuEUgaw==', N'YWGRVV7LEAW34TN6G4OBV3OIVACNYZRM', N'6a60ea8a-29fd-4d37-88f6-7a9614277de8', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'85d43a71-1d8d-450f-b899-08d90d5198d2', N'duong', N'duong', CAST(N'2021-05-04T00:00:00.0000000' AS DateTime2), N'duong', N'DUONG', N'duong@gmail.com', N'DUONG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGYgKRET8IR+ZfBy+cUbwAcGEbckj7340Z4W4jNZhN5aQcdUIRQddvUPd1AQll1Vww==', N'XK4EUBQTYGUOECXUGXNHRNWLMW6KDUKH', N'8b8c1fb8-b51c-45af-937c-11bc5944a15e', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', N'dung', N'dung', CAST(N'2021-05-05T00:00:00.0000000' AS DateTime2), N'dung', N'DUNG', N'dung@gmail.com', N'DUNG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAELk6gwfL8HDbgX7YlZpvOUj3efuQWt/ySOLHHpdxMkJNQOVAU+cLt1jYwrkjtMLMlA==', N'IMXLAGMD23O2BLQ667MQMH3GJIMCACL5', N'95ea9b2f-33e2-4d52-a548-352fc34287ca', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ca0740d8-cd01-45e1-fa78-08d925bd8d37', N'Em', N'Pape', CAST(N'2021-06-15T00:00:00.0000000' AS DateTime2), N'empape', N'EMPAPE', N'empape@gmail.com', N'EMPAPE@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEA8cPyG/Gp2xETIDtEzcV/GcZftNIqucP0GWz84DSSO+mbJP2CQwlWSTjYGTxLbdPg==', N'QAHBOAGA2QZEG7GHB2KEVWAHNNVOT6XN', N'0b33868f-7833-4f99-8e17-a94425b43aba', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'grandma', N'grandma', CAST(N'2021-06-07T00:00:00.0000000' AS DateTime2), N'grandma', N'GRANDMA', N'grandma@gmail.com', N'GRANDMA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFpYu0UlmEbJwKRwM0lEcaOF3256gB33Qx3U4io28N7tvVIngO82hoeWRneX25SBeA==', N'JOWQKQ2SEXXWH3XIDG3APPTANHPITFR2', N'113f22f9-b328-40e7-aab4-bd51e0925a99', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8cc76e82-270a-4aaf-e215-08d928271684', N'test2', N'test2', CAST(N'2021-06-23T00:00:00.0000000' AS DateTime2), N'test2', N'TEST2', N'test2@test2.com', N'TEST2@TEST2.COM', 0, N'AQAAAAEAACcQAAAAEOVbGEhtaTUpbHLhL2iz4XXieLIVryqqkUH8mWgAkB5fQaduiW6b+V5guUq6K9+CPg==', N'ZQQKLPGNI3KGAFOORJWD4ZCS3D3SRSG4', N'f10f1bbc-84ce-4fbe-bbc4-f35831262376', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', N'Lonen', N'Messi', CAST(N'1990-07-05T00:00:00.0000000' AS DateTime2), N'messi10', NULL, N'messi10@gmail.com', N'MESSI10@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJSJFg9Wa9X/y0PGThMzcY0ZjWRLXr74k4uPoqjVY5uFRyktzdcRYveLVSTnSRHngg==', NULL, N'7bfa3ab3-5d20-4060-bef1-638297e87e2f', N'+111111111', 0, 0, NULL, 0, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b4e253b2-756e-48b8-9c42-b5acb139bed4', N'Mary', N'Jame', CAST(N'1999-05-21T00:00:00.0000000' AS DateTime2), N'admin', NULL, N'jame@gmail.com', N'JAME@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOhk1dlxZ08l0AWfJbClIC6TQLriDZ72NoHmn9MODLwaox3NMFSLdfJkqnzKmueKWw==', NULL, N'0acebcc0-bfb6-46a9-95e9-834ee41e72dd', N'+111111111', 0, 0, NULL, 0, 0)
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'dd292c53-6484-47fb-da8b-08d90b239691', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'85d43a71-1d8d-450f-b899-08d90d5198d2', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'ca0740d8-cd01-45e1-fa78-08d925bd8d37', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'8cc76e82-270a-4aaf-e215-08d928271684', N'74d17d8b-3f91-4d3a-893f-09b4e51e3834')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', N'1267bf30-8eea-4370-bbcd-12f74e29c656')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'879239a7-f194-4d0d-4484-08d926a1a06c', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[AppUserRole] ([UserId], [RoleId]) VALUES (N'b4e253b2-756e-48b8-9c42-b5acb139bed4', N'b9e08f48-883c-42dc-a700-da5cf1d81aa3')
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'ca0740d8-cd01-45e1-fa78-08d925bd8d37', 1, 1)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', 2, 2)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', 3, 13)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (1, N'cơm trưa', N'com7', N'7f2df061-af4f-4d35-b7c5-b5e7040b657d.jpeg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (2, N'Drink', N'Nước giải khát, trà sữa, chè, ...', N'2ab67aad-6533-48ad-a4e9-c6da8eac62b9.jpeg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (3, N'Cakes', N'Bánh', N'800446cf-c01d-40b3-b1ff-91e740659ac9.jpg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (9, N'Bò', N'Các món ăn chế biến từ thịt bò', N'cec32dc6-367f-47ae-aeb0-b8a848cfbb7b.jpg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (10, N'Milk tea', N'Milk tea and coffee', N'a84c3eb9-fa30-4ebd-a65c-c4c340e18455.jpg')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (1, N'Steak thăn ngoại bò úc', N'Steak thăn ngoại bò úc', 15000, 100, N'18249668-5fd5-4ff8-9df1-378251640710.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (2, N'Súp kem bí đỏ', N'Súp kem bí đỏ', 10000, 57, N'fd1d7a40-5eca-4537-b4b5-97e093bdbb24.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (3, N'Steak thăn lưng bò úc', N'Steak thăn lưng bò úc', 7000, 1000, N'5befbb2f-f0fa-4bda-9a17-193b7eb91524.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (4, N'Mỳ ý cua bể', N'Mỳ ý cua bể', 5000, 200, N'1c0bb4e3-257c-4ef8-bd91-a24f344cf1b0.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (6, N'Steak thăn nội bò úc', N'Steak thăn nội bò úc', 200000, 6, N'f2d2eb6c-7174-4770-82bd-1612a3441caf.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (16, N'Bánh kem cupcake', N'Bánh kem cupcake', 50000, 10, N'5946ae36-ea8d-4dc8-a343-9d39f8c322ce.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (17, N'Bánh mỳ nho sữa', N'Bánh mỳ nho sữa', 60000, 100, N'0390a39f-e76a-4c16-a037-b37f334c5845.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (18, N'Cua phô mai', N'Cua phô mai', 20000, 30, N'78f53767-eee5-4639-88d8-5d59ac7a7696.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (19, N'Donut', N'Donut', 73000, 100, N'89ddb3b5-d654-4f09-8340-5d7faba4da89.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (20, N'Hồng trà thập cẩm', N'Hồng trà thập cẩm', 15000, 123, N'f33034b7-5fed-4e7f-9784-9b7d449d83ef.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (21, N'Milo dầm phô mai tươi', N'Milo dầm phô mai tươi', 23000, 132, N'88a577b9-3c92-4c3d-842d-7f08369b4b19.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (22, N'Milo dầm thập cẩm', N'Milo dầm thập cẩm', 23000, 321, N'0620e610-4906-4986-8ad1-3a8bc34ce165.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (23, N'Milo dầm pudding', N'Milo dầm pudding', 25000, 335, N'513dc882-989a-48d3-a3f3-c5ea88ed79ac.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (24, N'Trà đào', N'Trà đào', 16000, 666, N'19545579-90e8-4fa8-97b6-50172c3a51d1.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (25, N'Trà olong hạt sen', N'Trà olong hạt sen', 26000, 330, N'565150e1-eca0-4d0f-b15a-7bb6829acd93.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (26, N'Trà trái cây', N'Trà trái cây', 20000, 200, N'b30e9c7f-38ac-48a1-b1df-053f31ba75b1.jpg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (27, N'Trà vải', N'Trà vải', 18000, 180, N'1ca9fda1-2e53-4861-a50a-fa640e32de17.jpeg', NULL)
SET IDENTITY_INSERT [dbo].[Food] OFF
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (24, 1)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (20, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (21, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (22, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (23, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (24, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (25, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (26, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (27, 2)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (16, 3)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (17, 3)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (18, 3)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (19, 3)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (24, 3)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (1, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (2, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (3, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (4, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (6, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (24, 9)
INSERT [dbo].[FoodCategory] ([FoodID], [CategoryID]) VALUES (24, 10)
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ID], [FoodID], [ImagePath], [Caption], [SortOrder], [IsDefault]) VALUES (6, 1, N'057ef6f1-89b7-4662-a1ae-e32bda4dcea8.png', N'123', 123, 0)
INSERT [dbo].[Image] ([ID], [FoodID], [ImagePath], [Caption], [SortOrder], [IsDefault]) VALUES (7, 2, N'054c1343-aa80-4c88-812c-354b7f094ae0.jpg', NULL, 2, 0)
INSERT [dbo].[Image] ([ID], [FoodID], [ImagePath], [Caption], [SortOrder], [IsDefault]) VALUES (8, 2, N'fbcee259-b393-463c-9886-de89bbe332bf.gif', NULL, 1, 0)
INSERT [dbo].[Image] ([ID], [FoodID], [ImagePath], [Caption], [SortOrder], [IsDefault]) VALUES (9, 1, N'ea2b9e3b-ea95-45db-bcf4-eda79e4c402f.jpg', N'Meo ngu', 1, 1)
SET IDENTITY_INSERT [dbo].[Image] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([ID], [UserID], [Title], [Message], [TimeCreated], [Type], [UserReceived]) VALUES (1, N'5d597675-8179-4575-7872-08d90b25fb90', N'TEst', N'Test message', CAST(N'2021-05-22T22:46:54.1942777' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (8, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:08:48.9688416' AS DateTime2), 1, CAST(N'2021-05-22T17:45:11.6354643' AS DateTime2), 4, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (11, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:09:51.5907874' AS DateTime2), 0, NULL, 5, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (19, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-22T02:51:53.6168379' AS DateTime2), 0, NULL, 5, NULL, 0, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (44, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T11:09:16.3904508' AS DateTime2), 1, CAST(N'2021-05-31T22:17:29.1421333' AS DateTime2), 4, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (45, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:16:18.3551142' AS DateTime2), 0, NULL, 2, 3, 10800, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (46, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:19:58.1456997' AS DateTime2), 1, CAST(N'2021-06-02T14:18:36.0967419' AS DateTime2), 4, 1, 5000, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (47, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-31T13:20:38.0550788' AS DateTime2), 0, NULL, 2, 1, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (58, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:14:58.5293736' AS DateTime2), 0, NULL, 2, 3, 3570, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (59, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:16:39.0079887' AS DateTime2), 0, NULL, 2, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (60, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:48:31.7255892' AS DateTime2), 0, NULL, 2, 3, 11220, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (61, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:49:26.9676837' AS DateTime2), 0, NULL, 2, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (62, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T14:50:40.3511312' AS DateTime2), 0, NULL, 2, 3, 7650, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (69, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:24:46.8557270' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (70, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:25:04.5202583' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (71, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T15:27:39.4842848' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Nhà', N'Ký túc xá khu B DHQG', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (72, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-01T16:55:13.0638867' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (73, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-06-02T17:59:29.0045317' AS DateTime2), 0, NULL, 2, NULL, NULL, N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (74, N'ca0740d8-cd01-45e1-fa78-08d925bd8d37', CAST(N'2021-06-02T19:10:10.8529905' AS DateTime2), 1, CAST(N'2021-06-02T19:10:59.7603062' AS DateTime2), 4, 3, 7650, N'pari', N'pari sant', NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (8, 1, 2, 163900, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (8, 20, 2, 15000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (11, 1, 2, 163900, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (11, 20, 2, 15000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (19, 21, 1, 23000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (44, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (45, 27, 1, 18000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (46, 17, 1, 60000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (47, 18, 1, 20000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (58, 3, 1, 7000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (59, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (60, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (60, 3, 1, 7000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (61, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (62, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (69, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (69, 20, 1, 15000, NULL, NULL)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (70, 4, 1, 5000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (71, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (72, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (73, 1, 1, 15000, 1, 15)
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price], [SaleCampaignID], [SalePercent]) VALUES (74, 1, 1, 15000, 1, 15)
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (2, N'Đang chuẩn bị', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (3, N'Đang giao hàng', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (4, N'Đã nhận hàng', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (5, N'Đã hủy', N'')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority]) VALUES (1, N'Chào thành viên mới | Giảm 50%', N'THANHVIENMOI', N'Chào thành viên mới, giảm ngay 50% cho tất cả các đơn hàng. Tối đa 50.000 đồng.', CAST(N'2021-06-03T20:30:09.3841440' AS DateTime2), CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 3, 50, 1, 5000, 50000, 1, 4)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority]) VALUES (3, N'Ăn ở nhà cũng ngon | Khao 60%.', N'KHAO60', N'Ăn ở nhà cũng ngon. Khao 60% cho tất cả các đơn hàng từ ngày 5/5/2021 đến 5/6/2021. Tối đa 30K.', CAST(N'2021-05-05T17:56:00.0000000' AS DateTime2), CAST(N'2021-06-05T17:56:00.0000000' AS DateTime2), 3, 60, 1, 60000, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 4, N'ngon vãi', CAST(N'2021-06-02T09:42:42.4197752' AS DateTime2), 8)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 20, 3, N'yiyfg', CAST(N'2021-06-02T10:07:28.7493548' AS DateTime2), 8)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 27, 5, N'hahs', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 45)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 17, 4, N'đỉnh', CAST(N'2021-06-02T16:59:52.8643872' AS DateTime2), 46)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 1, N'1', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 61)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 5, N'haha', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 62)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 5, N'ngon vl haha', CAST(N'2021-06-01T23:36:35.7996196' AS DateTime2), 69)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 20, 3, N'vl có gì đó sai sai', CAST(N'2021-06-01T23:37:06.3343718' AS DateTime2), 69)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 4, 5, N'test', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 70)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 1, N'test', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 71)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 1, N'fhgse', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 72)
INSERT [dbo].[Rating] ([AppUserId], [FoodID], [Star], [Comment], [TimeCreate], [OrderID]) VALUES (NULL, 1, 4, N'cũng được', CAST(N'2021-06-02T19:11:21.2438667' AS DateTime2), 74)
SET IDENTITY_INSERT [dbo].[SaleCampaign] ON 

INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority]) VALUES (1, N'Ăn no không lo giá | Giảm 15%', N'Giảm 15% tất cả các món ăn trong danh sách', CAST(N'2021-05-11T16:39:00.0000000' AS DateTime2), CAST(N'2021-06-30T16:39:00.0000000' AS DateTime2), 15, 1, 1)
INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority]) VALUES (2, N'test', N'test', CAST(N'2021-05-27T21:24:00.0000000' AS DateTime2), CAST(N'2021-06-01T21:24:00.0000000' AS DateTime2), 30, 0, 0)
SET IDENTITY_INSERT [dbo].[SaleCampaign] OFF
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (1, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (3, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (4, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (16, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (2, 2)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (4, 2)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (16, 2)
/****** Object:  Index [IX_Address_AppUserID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Address_AppUserID] ON [dbo].[Address]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AppRole]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppRoleClaim_RoleId]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppRoleClaim_RoleId] ON [dbo].[AppRoleClaim]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AppUser]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AppUser]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserClaim_UserId]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserClaim_UserId] ON [dbo].[AppUserClaim]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserRole_RoleId]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserRole_RoleId] ON [dbo].[AppUserRole]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cart_AppUserId]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cart_AppUserId] ON [dbo].[Cart]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Food_SaleCampaignID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Food_SaleCampaignID] ON [dbo].[Food]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodCategory_CategoryID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodCategory_CategoryID] ON [dbo].[FoodCategory]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Image_FoodID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Image_FoodID] ON [dbo].[Image]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notification_UserID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notification_UserID] ON [dbo].[Notification]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_AppUserID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_AppUserID] ON [dbo].[Order]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_OrderStatusID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_OrderStatusID] ON [dbo].[Order]
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_PromotionID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_PromotionID] ON [dbo].[Order]
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_SaleCampaignID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_SaleCampaignID] ON [dbo].[Order]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetail_FoodID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetail_FoodID] ON [dbo].[OrderDetail]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetail_SaleCampaignID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetail_SaleCampaignID] ON [dbo].[OrderDetail]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_AppUserId]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Rating_AppUserId] ON [dbo].[Rating]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_FoodID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Rating_FoodID] ON [dbo].[Rating]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SaleCampaignFood_SaleCampaignID]    Script Date: 6/6/2021 8:38:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_SaleCampaignFood_SaleCampaignID] ON [dbo].[SaleCampaignFood]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[Image] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDefault]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsPaid]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (N'') FOR [AddressName]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (N'') FOR [AddressString]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((1)) FOR [Amount]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-06-03T20:30:09.3106966+07:00') FOR [StartDate]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-06-03T20:30:09.3126471+07:00') FOR [EndDate]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([real],(10))) FOR [Percent]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Enabled]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsGlobal]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT ((5)) FOR [Star]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [TimeCreate]
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
ALTER TABLE [dbo].[Image]  WITH CHECK ADD  CONSTRAINT [FK_Image_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Image_Food_FoodID]
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
