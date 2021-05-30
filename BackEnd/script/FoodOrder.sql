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
/****** Object:  Table [dbo].[Address]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppRole]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppRoleClaim]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppUser]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppUserClaim]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppUserLogin]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppUserRole]    Script Date: 5/30/2021 2:47:13 PM ******/
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
/****** Object:  Table [dbo].[AppUserToken]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Food]    Script Date: 5/30/2021 2:47:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Count] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[SaleCampaignID] [int] NULL,
 CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 5/30/2021 2:47:14 PM ******/
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
	[PromotionAmount] [decimal](18, 2) NULL,
	[AddressName] [nvarchar](max) NOT NULL,
	[AddressString] [nvarchar](max) NOT NULL,
	[SaleCampaignID] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 5/30/2021 2:47:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[FoodID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[Promotion]    Script Date: 5/30/2021 2:47:14 PM ******/
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
	[Max] [int] NULL,
	[MinPrice] [int] NULL,
	[IsGlobal] [bit] NOT NULL,
	[Priority] [int] NOT NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 5/30/2021 2:47:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[AppUserID] [uniqueidentifier] NOT NULL,
	[FoodID] [int] NOT NULL,
	[Star] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[LastCreatedTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[AppUserID] ASC,
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCampaign]    Script Date: 5/30/2021 2:47:14 PM ******/
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
/****** Object:  Table [dbo].[SaleCampaignFood]    Script Date: 5/30/2021 2:47:14 PM ******/
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
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (1, N'5d597675-8179-4575-7872-08d90b25fb90', N'Ký túc xá', N'140/11 Đường Bình Quới')
INSERT [dbo].[Address] ([ID], [AppUserID], [Name], [AddressString]) VALUES (2, N'5d597675-8179-4575-7872-08d90b25fb90', N'Nhà', N'Ký túc xá khu B DHQG')
SET IDENTITY_INSERT [dbo].[Address] OFF
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'74d17d8b-3f91-4d3a-893f-09b4e51e3834', N'This is User role.', N'user', N'User', N'71ccdfaa-ea59-45d7-a5dc-e59db5167f74')
INSERT [dbo].[AppRole] ([Id], [Description], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b9e08f48-883c-42dc-a700-da5cf1d81aa3', N'This is Admintrator role.', N'admin', N'ADMIN', N'dd79eca4-0825-441b-8539-929fb11309a9')
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', N'Quang', N'Lien Minh', CAST(N'2021-04-04T00:00:00.0000000' AS DateTime2), N'admin', N'ADMIN', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, NULL, N'NMLFA5HOHLVMCLJWJSLNHI2CBKINFTQB', N'cc63b69f-8bac-4562-ab07-3d511a9099f8', NULL, 0, 0, CAST(N'2021-05-14T08:10:41.6475326+00:00' AS DateTimeOffset), 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'dd292c53-6484-47fb-da8b-08d90b239691', N'Quang', N'Quang', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'quang.lienminh', N'QUANG.LIENMINH', N'quang.lienminh@gameloft.com', N'QUANG.LIENMINH@GAMELOFT.COM', 0, NULL, N'D2LOCU2VAZDWIHZGGIYWANP7QLQANG5M', N'e8184f93-d375-4d1f-952d-df9ee03ab312', NULL, 0, 0, NULL, 1, 2)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', N'admin', N'admin', CAST(N'2021-04-29T00:00:00.0000000' AS DateTime2), N'admin2', N'ADMIN2', N'quang@gmail.com', N'QUANG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEN1rpZFc37EJ07GfBctD7qYfN8Ly1PHPrqcB2grqflLzIMaJISGT720qnj6JuEUgaw==', N'YWGRVV7LEAW34TN6G4OBV3OIVACNYZRM', N'31907f48-ed5d-4403-a869-c0caf0bbd2ce', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'85d43a71-1d8d-450f-b899-08d90d5198d2', N'duong', N'duong', CAST(N'2021-05-04T00:00:00.0000000' AS DateTime2), N'duong', N'DUONG', N'duong@gmail.com', N'DUONG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGYgKRET8IR+ZfBy+cUbwAcGEbckj7340Z4W4jNZhN5aQcdUIRQddvUPd1AQll1Vww==', N'XK4EUBQTYGUOECXUGXNHRNWLMW6KDUKH', N'528d81c0-3b7f-455c-9ffe-da7e1866a61d', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', N'dung', N'dung', CAST(N'2021-05-05T00:00:00.0000000' AS DateTime2), N'dung', N'DUNG', N'dung@gmail.com', N'DUNG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAELk6gwfL8HDbgX7YlZpvOUj3efuQWt/ySOLHHpdxMkJNQOVAU+cLt1jYwrkjtMLMlA==', N'IMXLAGMD23O2BLQ667MQMH3GJIMCACL5', N'995a2c51-8f0b-42d3-a76a-2b65f2aec405', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', N'Lonen', N'Messi', CAST(N'1990-07-05T00:00:00.0000000' AS DateTime2), N'messi10', NULL, N'messi10@gmail.com', N'MESSI10@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEMV6DBZOI8fBIgE5MXaaQU1K4DxmMtxlHeeNQi30TW5krfu9PQWSBlKhKEjXPgb5YA==', NULL, N'3f325bb9-58f6-41c6-aa13-db9808e7c222', N'+111111111', 0, 0, NULL, 0, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [DateOfBirth], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b4e253b2-756e-48b8-9c42-b5acb139bed4', N'Mary', N'Jame', CAST(N'1999-05-21T00:00:00.0000000' AS DateTime2), N'admin', NULL, N'jame@gmail.com', N'JAME@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGEGfnVEBx4HAxWf01nlUf05/0CWZV9MvCqxt3wvgBIE0yNF6Ygr41wkirJXETWGmg==', NULL, N'1a43fd5c-a063-44a7-8c1d-d8281ef9ab30', N'+111111111', 0, 0, NULL, 0, 0)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', 1, 1)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', 2, 2)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', 3, 13)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', 18, 1)
INSERT [dbo].[Cart] ([AppUserId], [FoodID], [Quantity]) VALUES (N'5d597675-8179-4575-7872-08d90b25fb90', 24, 1)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (1, N'cơm trưa', N'com7', N'7f2df061-af4f-4d35-b7c5-b5e7040b657d.jpeg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (2, N'Drink', N'Nước giải khát, trà sữa, chè, ...', N'2ab67aad-6533-48ad-a4e9-c6da8eac62b9.jpeg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (3, N'Cakes', N'Bánh', N'800446cf-c01d-40b3-b1ff-91e740659ac9.jpg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (9, N'Bò', N'Các món ăn chế biến từ thịt bò', N'cec32dc6-367f-47ae-aeb0-b8a848cfbb7b.jpg')
INSERT [dbo].[Category] ([ID], [Name], [Description], [ImagePath]) VALUES (10, N'Milk tea', N'Milk tea and coffee', N'a84c3eb9-fa30-4ebd-a65c-c4c340e18455.jpg')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (1, N'Steak thăn ngoại bò úc', N'Steak thăn ngoại bò úc', CAST(163900.00 AS Decimal(18, 2)), 100, N'18249668-5fd5-4ff8-9df1-378251640710.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (2, N'Súp kem bí đỏ', N'Súp kem bí đỏ', CAST(60000.00 AS Decimal(18, 2)), 57, N'fd1d7a40-5eca-4537-b4b5-97e093bdbb24.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (3, N'Steak thăn lưng bò úc', N'Steak thăn lưng bò úc', CAST(203500.00 AS Decimal(18, 2)), 1000, N'5befbb2f-f0fa-4bda-9a17-193b7eb91524.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (4, N'Mỳ ý cua bể', N'Mỳ ý cua bể', CAST(159000.00 AS Decimal(18, 2)), 200, N'1c0bb4e3-257c-4ef8-bd91-a24f344cf1b0.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (6, N'Steak thăn nội bò úc', N'Steak thăn nội bò úc', CAST(200000.00 AS Decimal(18, 2)), 6, N'f2d2eb6c-7174-4770-82bd-1612a3441caf.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (16, N'Bánh kem cupcake', N'Bánh kem cupcake', CAST(50000.00 AS Decimal(18, 2)), 10, N'5946ae36-ea8d-4dc8-a343-9d39f8c322ce.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (17, N'Bánh mỳ nho sữa', N'Bánh mỳ nho sữa', CAST(60000.00 AS Decimal(18, 2)), 100, N'0390a39f-e76a-4c16-a037-b37f334c5845.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (18, N'Cua phô mai', N'Cua phô mai', CAST(20000.00 AS Decimal(18, 2)), 30, N'78f53767-eee5-4639-88d8-5d59ac7a7696.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (19, N'Donut', N'Donut', CAST(73000.00 AS Decimal(18, 2)), 100, N'89ddb3b5-d654-4f09-8340-5d7faba4da89.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (20, N'Hồng trà thập cẩm', N'Hồng trà thập cẩm', CAST(15000.00 AS Decimal(18, 2)), 123, N'f33034b7-5fed-4e7f-9784-9b7d449d83ef.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (21, N'Milo dầm phô mai tươi', N'Milo dầm phô mai tươi', CAST(23000.00 AS Decimal(18, 2)), 132, N'88a577b9-3c92-4c3d-842d-7f08369b4b19.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (22, N'Milo dầm thập cẩm', N'Milo dầm thập cẩm', CAST(23000.00 AS Decimal(18, 2)), 321, N'0620e610-4906-4986-8ad1-3a8bc34ce165.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (23, N'Milo dầm pudding', N'Milo dầm pudding', CAST(25000.00 AS Decimal(18, 2)), 335, N'513dc882-989a-48d3-a3f3-c5ea88ed79ac.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (24, N'Trà đào', N'Trà đào', CAST(16000.00 AS Decimal(18, 2)), 666, N'19545579-90e8-4fa8-97b6-50172c3a51d1.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (25, N'Trà olong hạt sen', N'Trà olong hạt sen', CAST(26000.00 AS Decimal(18, 2)), 330, N'565150e1-eca0-4d0f-b15a-7bb6829acd93.jpeg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (26, N'Trà trái cây', N'Trà trái cây', CAST(20000.00 AS Decimal(18, 2)), 200, N'b30e9c7f-38ac-48a1-b1df-053f31ba75b1.jpg', NULL)
INSERT [dbo].[Food] ([ID], [Name], [Description], [Price], [Count], [ImagePath], [SaleCampaignID]) VALUES (27, N'Trà vải', N'Trà vải', CAST(18000.00 AS Decimal(18, 2)), 180, N'1ca9fda1-2e53-4861-a50a-fa640e32de17.jpeg', NULL)
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

INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (8, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:08:48.9688416' AS DateTime2), 1, CAST(N'2021-05-22T17:45:11.6354643' AS DateTime2), 4, NULL, CAST(0.00 AS Decimal(18, 2)), N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (11, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-21T22:09:51.5907874' AS DateTime2), 0, NULL, 5, NULL, CAST(0.00 AS Decimal(18, 2)), N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
INSERT [dbo].[Order] ([ID], [AppUserID], [CreatedDate], [IsPaid], [DatePaid], [OrderStatusID], [PromotionID], [PromotionAmount], [AddressName], [AddressString], [SaleCampaignID]) VALUES (19, N'5d597675-8179-4575-7872-08d90b25fb90', CAST(N'2021-05-22T02:51:53.6168379' AS DateTime2), 0, NULL, 5, NULL, CAST(0.00 AS Decimal(18, 2)), N'Ký túc xá', N'140/11 Đường Bình Quới', NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price]) VALUES (8, 1, 2, CAST(163900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price]) VALUES (8, 20, 2, CAST(15000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price]) VALUES (11, 1, 2, CAST(163900.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price]) VALUES (11, 20, 2, CAST(15000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetail] ([OrderID], [FoodID], [Amount], [Price]) VALUES (19, 21, 1, CAST(23000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (2, N'Dang chuan bi', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (3, N'Dang giao hang', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (4, N'Da nhan hang', N'')
INSERT [dbo].[OrderStatus] ([ID], [Name], [Description]) VALUES (5, N'Da huy', N'')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority]) VALUES (1, N'Chào thành viên mới | Giảm 50%', N'THANHVIENMOI', N'Chào thành viên mới, giảm ngay 50% cho tất cả các đơn hàng. Tối đa 50.000 đồng.', CAST(N'2021-05-29T15:37:23.2990000' AS DateTime2), CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 3, 50, 1, 30000, 0, 1, 4)
INSERT [dbo].[Promotion] ([ID], [Name], [Code], [Desciption], [StartDate], [EndDate], [UseTimes], [Percent], [Enabled], [Max], [MinPrice], [IsGlobal], [Priority]) VALUES (3, N'Ăn ở nhà cũng ngon | Khao 60%.', N'KHAO60', N'Ăn ở nhà cũng ngon. Khao 60% cho tất cả các đơn hàng từ ngày 5/5/2021 đến 5/6/2021. Tối đa 30K.', CAST(N'2021-05-05T17:56:00.0000000' AS DateTime2), CAST(N'2021-06-05T17:56:00.0000000' AS DateTime2), 1000, 60, 0, 60000, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
INSERT [dbo].[Rating] ([AppUserID], [FoodID], [Star], [Comment], [LastCreatedTime]) VALUES (N'cb3e2dbe-bcfa-482f-e070-08d90b22d283', 1, 3, N'Cơm ngon đấy :)', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Rating] ([AppUserID], [FoodID], [Star], [Comment], [LastCreatedTime]) VALUES (N'd102d641-a67f-462e-709d-08d90d51d53e', 1, 5, N'nấu đỉnh vl', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Rating] ([AppUserID], [FoodID], [Star], [Comment], [LastCreatedTime]) VALUES (N'daeb6f0d-eefe-4250-9ecd-28b3243eb684', 1, 5, N'Good jobbbb', CAST(N'2021-05-29T15:37:23.3002991' AS DateTime2))
SET IDENTITY_INSERT [dbo].[SaleCampaign] ON 

INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority]) VALUES (1, N'Ăn no không lo giá | Giảm 15%', N'Giảm 15% tất cả các món ăn trong danh sách', CAST(N'2021-05-11T16:39:00.0000000' AS DateTime2), CAST(N'2021-05-31T16:39:00.0000000' AS DateTime2), 15, 1, 1)
INSERT [dbo].[SaleCampaign] ([ID], [Name], [Desciption], [StartDate], [EndDate], [Percent], [Enabled], [Priority]) VALUES (2, N'test', N'test', CAST(N'2021-05-27T21:24:00.0000000' AS DateTime2), CAST(N'2021-06-01T21:24:00.0000000' AS DateTime2), 30, 0, 0)
SET IDENTITY_INSERT [dbo].[SaleCampaign] OFF
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (1, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (3, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (4, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (16, 1)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (2, 2)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (4, 2)
INSERT [dbo].[SaleCampaignFood] ([FoodID], [SaleCampaignID]) VALUES (16, 2)
/****** Object:  Index [IX_Address_AppUserID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Address_AppUserID] ON [dbo].[Address]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AppRole]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppRoleClaim_RoleId]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppRoleClaim_RoleId] ON [dbo].[AppRoleClaim]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AppUser]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AppUser]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserClaim_UserId]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserClaim_UserId] ON [dbo].[AppUserClaim]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserRole_RoleId]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppUserRole_RoleId] ON [dbo].[AppUserRole]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cart_AppUserId]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cart_AppUserId] ON [dbo].[Cart]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Food_SaleCampaignID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Food_SaleCampaignID] ON [dbo].[Food]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodCategory_CategoryID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodCategory_CategoryID] ON [dbo].[FoodCategory]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Image_FoodID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Image_FoodID] ON [dbo].[Image]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notification_UserID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notification_UserID] ON [dbo].[Notification]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_AppUserID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_AppUserID] ON [dbo].[Order]
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_OrderStatusID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_OrderStatusID] ON [dbo].[Order]
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_PromotionID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_PromotionID] ON [dbo].[Order]
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_SaleCampaignID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_SaleCampaignID] ON [dbo].[Order]
(
	[SaleCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetail_FoodID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetail_FoodID] ON [dbo].[OrderDetail]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_FoodID]    Script Date: 5/30/2021 2:47:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Rating_FoodID] ON [dbo].[Rating]
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SaleCampaignFood_SaleCampaignID]    Script Date: 5/30/2021 2:47:14 PM ******/
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
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-05-29T15:37:23.2627201+07:00') FOR [StartDate]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ('2021-05-29T15:37:23.2638902+07:00') FOR [EndDate]
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
ALTER TABLE [dbo].[Rating] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [LastCreatedTime]
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
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_AppUser_AppUserID] FOREIGN KEY([AppUserID])
REFERENCES [dbo].[AppUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_AppUser_AppUserID]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Food_FoodID] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Food_FoodID]
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
