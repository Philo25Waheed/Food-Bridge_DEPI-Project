USE [master];
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'FoodBridgeDb')
BEGIN
    CREATE DATABASE [FoodBridgeDb];
END
GO
USE [FoodBridgeDb];
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/22/2026 1:03:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'33ad887e-9452-4aff-9d66-6b743d3a15c4', N'Charity', N'CHARITY', N'01dc502d-69aa-46de-8784-8745bd186bf6')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c', N'Provider', N'PROVIDER', N'621db90c-a16b-45d6-a2c5-7b483c0b57fd')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'a4730b9d-6b38-4b3b-8bf8-e466e8aa8729', N'Admin', N'ADMIN', N'6b979576-446e-4b58-8144-87c4e0a5277e')
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 10/22/2026 1:03:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:17 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:17 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/22/2026 1:03:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 10/22/2026 1:03:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RoleId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'33ad887e-9452-4aff-9d66-6b743d3a15c4', N'Charity', N'CHARITY', N'01dc502d-69aa-46de-8784-8745bd186bf6')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c', N'Provider', N'PROVIDER', N'621db90c-a16b-45d6-a2c5-7b483c0b57fd')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'a4730b9d-6b38-4b3b-8bf8-e466e8aa8729', N'Admin', N'ADMIN', N'6b979576-446e-4b58-8144-87c4e0a5277e')
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'33ad887e-9452-4aff-9d66-6b743d3a15c4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'33ad887e-9452-4aff-9d66-6b743d3a15c4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'33ad887e-9452-4aff-9d66-6b743d3a15c4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'33ad887e-9452-4aff-9d66-6b743d3a15c4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'33ad887e-9452-4aff-9d66-6b743d3a15c4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'a4730b9d-6b38-4b3b-8bf8-e466e8aa8729')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'a4730b9d-6b38-4b3b-8bf8-e466e8aa8729')
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 10/22/2026 1:03:21 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:21 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:21 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 10/22/2026 1:03:21 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 10/22/2026 1:03:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClaimType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClaimValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:24 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:24 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 10/22/2026 1:03:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/22/2026 1:03:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 10/22/2026 1:03:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClaimType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClaimValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'33ad887e-9452-4aff-9d66-6b743d3a15c4', N'Charity', N'CHARITY', N'01dc502d-69aa-46de-8784-8745bd186bf6')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'883e87ed-bb89-4e2f-a8e7-f21fe09ae12c', N'Provider', N'PROVIDER', N'621db90c-a16b-45d6-a2c5-7b483c0b57fd')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'a4730b9d-6b38-4b3b-8bf8-e466e8aa8729', N'Admin', N'ADMIN', N'6b979576-446e-4b58-8144-87c4e0a5277e')
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 10/22/2026 1:03:27 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 10/22/2026 1:03:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 10/22/2026 1:03:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProviderKey] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProviderDisplayName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:30 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:30 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 10/22/2026 1:03:30 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 10/22/2026 1:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LoginProvider] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:33 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 10/22/2026 1:03:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[Key] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UpdatedAt] [datetimeoffset](7) NOT NULL,
	[UpdatedBy] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[SystemSettings] ([Key], [Value], [UpdatedAt], [UpdatedBy]) VALUES (N'MaintenanceMode', N'{"IsMaintenanceActive":false,"Reason":"Database server upgrade \u0026 security enhancements","ReasonAr":"\u062A\u062D\u062F\u064A\u062B\u0627\u062A \u0623\u0645\u0646\u064A\u0629 \u0648\u062A\u0631\u0642\u064A\u0629 \u0642\u0627\u0639\u062F\u0629 \u0627\u0644\u0628\u064A\u0627\u0646\u0627\u062A","EstimatedDuration":null,"ActivatedAt":null,"ActivatedByAdminName":null}', CAST(N'2026-10-22T09:38:51.6196641+00:00' AS DateTimeOffset), N'Platform Administrator')
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodListings]    Script Date: 10/22/2026 1:03:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodListings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodCategory] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[UnitOfMeasurement] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PreparationDate] [datetime2](7) NOT NULL,
	[PickupDeadline] [datetime2](7) NOT NULL,
	[PickupAddress] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StorageConditions] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Allergens] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ImageUrl] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[IsReported] [bit] NOT NULL,
	[ReportReason] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UpdatedAt] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_FoodListings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] ON 

GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1, N'110ce996-162b-4701-b968-71c28ca5246d', N'Fresh Mediterranean Lasagna & Penne Trays', N'Prepared with Italian beef ragù, béchamel, and mozzarella. Freshly cooked at noon in individual catering trays, ready for immediate distribution.', 1, CAST(35.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T07:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T19:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Kitchen entrance rear alley)', N'Refrigerated (0-4°C) or Keep Warm (>63°C)', N'Gluten, Dairy, Celery', N'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T07:45:34.1104408+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.7680602+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Assorted Artisan Sourdough & French Croissants', N'Daily surplus batch of whole-wheat sourdough loaves, ciabatta, and buttery golden croissants. Baked this morning at 6:00 AM.', 2, CAST(55.00 AS Decimal(18, 2)), N'items', CAST(N'2026-10-21T03:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T23:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Dry & Room Temperature (20-22°C)', N'Gluten, Dairy, Eggs', N'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-21T04:45:34.1104639+00:00' AS DateTimeOffset), CAST(N'2026-10-21T09:46:18.2827337+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (3, N'110ce996-162b-4701-b968-71c28ca5246d', N'Crispy Garden Salad Bowls & Olive Oil Dressing', N'Fresh romaine lettuce, cherry tomatoes, cucumbers, black olives, and feta cheese with balsamic dressing on the side.', 3, CAST(25.00 AS Decimal(18, 2)), N'boxes', CAST(N'2026-10-21T06:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T17:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T06:45:34.1104642+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9150357+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (4, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Natural Greek Yogurt & Farmer White Cheese', N'Unopened wholesale cartons of high-protein plain Greek yogurt and unsalted farmer white cheese, optimal for shelters.', 5, CAST(40.00 AS Decimal(18, 2)), N'kg', CAST(N'2026-10-20T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-23T09:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&auto=format&fit=crop&q=80', 1, 0, NULL, CAST(N'2026-10-20T21:45:34.1104653+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (5, N'110ce996-162b-4701-b968-71c28ca5246d', N'Catering Roast Chicken with Oriental Spiced Rice', N'Surplus executive banquet buffet: tender roasted whole chickens, seasoned saffron rice, and roasted mixed vegetables.', 1, CAST(60.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-16T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-17T09:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Nuts (Pine nuts in rice garnish)', N'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-16T09:45:34.1104697+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (6, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'يييييي', N'صصصصصصصص', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:00:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:00:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, NULL, CAST(N'2026-10-21T11:00:42.0868194+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9197989+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1002, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'يييييي', N'ييييييي', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:44:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:44:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, N'Disposal Logged: لالالالالا', CAST(N'2026-10-21T11:44:32.1236874+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9216986+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2002, N'110ce996-162b-4701-b968-71c28ca5246d', N'Freshly Baked Artisan Focaccia', N'Surplus batch of herb focaccia baked this afternoon.', 2, CAST(25.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T15:00:10.2011526' AS DateTime2), CAST(N'2026-10-21T23:00:10.2032785' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Room temperature (20-25C)', N'Gluten', NULL, 3, 0, NULL, CAST(N'2026-10-21T12:00:10.2436474+00:00' AS DateTimeOffset), CAST(N'2026-10-21T12:00:10.7013550+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2003, N'110ce996-162b-4701-b968-71c28ca5246d', N'يييييي', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:30:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:30:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:30:57.8802002+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2004, N'110ce996-162b-4701-b968-71c28ca5246d', N'اي حاجه', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:31:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:31:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:31:27.0308858+00:00' AS DateTimeOffset), NULL)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_FoodCategory]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_FoodCategory] ON [dbo].[FoodListings]
(
	[FoodCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_PickupDeadline]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_PickupDeadline] ON [dbo].[FoodListings]
(
	[PickupDeadline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FoodListings_ProviderId]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_ProviderId] ON [dbo].[FoodListings]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_Status]    Script Date: 10/22/2026 1:03:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_Status] ON [dbo].[FoodListings]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FoodListings]  WITH CHECK ADD  CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[FoodListings] CHECK CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodListings]    Script Date: 10/22/2026 1:03:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodListings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodCategory] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[UnitOfMeasurement] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PreparationDate] [datetime2](7) NOT NULL,
	[PickupDeadline] [datetime2](7) NOT NULL,
	[PickupAddress] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StorageConditions] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Allergens] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ImageUrl] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[IsReported] [bit] NOT NULL,
	[ReportReason] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UpdatedAt] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_FoodListings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 10/22/2026 1:03:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FoodListingId] [int] NOT NULL,
	[CharityId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RequestDate] [datetimeoffset](7) NOT NULL,
	[PickupDateTime] [datetime2](7) NULL,
	[ConfirmedLocation] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[CancellationReason] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProblemDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompletedAt] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] ON 

GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1, N'110ce996-162b-4701-b968-71c28ca5246d', N'Fresh Mediterranean Lasagna & Penne Trays', N'Prepared with Italian beef ragù, béchamel, and mozzarella. Freshly cooked at noon in individual catering trays, ready for immediate distribution.', 1, CAST(35.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T07:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T19:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Kitchen entrance rear alley)', N'Refrigerated (0-4°C) or Keep Warm (>63°C)', N'Gluten, Dairy, Celery', N'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T07:45:34.1104408+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.7680602+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Assorted Artisan Sourdough & French Croissants', N'Daily surplus batch of whole-wheat sourdough loaves, ciabatta, and buttery golden croissants. Baked this morning at 6:00 AM.', 2, CAST(55.00 AS Decimal(18, 2)), N'items', CAST(N'2026-10-21T03:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T23:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Dry & Room Temperature (20-22°C)', N'Gluten, Dairy, Eggs', N'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-21T04:45:34.1104639+00:00' AS DateTimeOffset), CAST(N'2026-10-21T09:46:18.2827337+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (3, N'110ce996-162b-4701-b968-71c28ca5246d', N'Crispy Garden Salad Bowls & Olive Oil Dressing', N'Fresh romaine lettuce, cherry tomatoes, cucumbers, black olives, and feta cheese with balsamic dressing on the side.', 3, CAST(25.00 AS Decimal(18, 2)), N'boxes', CAST(N'2026-10-21T06:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T17:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T06:45:34.1104642+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9150357+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (4, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Natural Greek Yogurt & Farmer White Cheese', N'Unopened wholesale cartons of high-protein plain Greek yogurt and unsalted farmer white cheese, optimal for shelters.', 5, CAST(40.00 AS Decimal(18, 2)), N'kg', CAST(N'2026-10-20T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-23T09:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&auto=format&fit=crop&q=80', 1, 0, NULL, CAST(N'2026-10-20T21:45:34.1104653+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (5, N'110ce996-162b-4701-b968-71c28ca5246d', N'Catering Roast Chicken with Oriental Spiced Rice', N'Surplus executive banquet buffet: tender roasted whole chickens, seasoned saffron rice, and roasted mixed vegetables.', 1, CAST(60.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-16T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-17T09:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Nuts (Pine nuts in rice garnish)', N'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-16T09:45:34.1104697+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (6, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'يييييي', N'صصصصصصصص', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:00:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:00:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, NULL, CAST(N'2026-10-21T11:00:42.0868194+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9197989+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1002, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'يييييي', N'ييييييي', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:44:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:44:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, N'Disposal Logged: لالالالالا', CAST(N'2026-10-21T11:44:32.1236874+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9216986+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2002, N'110ce996-162b-4701-b968-71c28ca5246d', N'Freshly Baked Artisan Focaccia', N'Surplus batch of herb focaccia baked this afternoon.', 2, CAST(25.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T15:00:10.2011526' AS DateTime2), CAST(N'2026-10-21T23:00:10.2032785' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Room temperature (20-25C)', N'Gluten', NULL, 3, 0, NULL, CAST(N'2026-10-21T12:00:10.2436474+00:00' AS DateTimeOffset), CAST(N'2026-10-21T12:00:10.7013550+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2003, N'110ce996-162b-4701-b968-71c28ca5246d', N'يييييي', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:30:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:30:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:30:57.8802002+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2004, N'110ce996-162b-4701-b968-71c28ca5246d', N'اي حاجه', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:31:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:31:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:31:27.0308858+00:00' AS DateTimeOffset), NULL)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 

GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1, 5, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-16T09:45:34.1791302+00:00' AS DateTimeOffset), CAST(N'2026-10-17T07:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Loading dock B)', 5, NULL, NULL, CAST(N'2026-10-17T09:45:34.1792373+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (2, 1, N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', CAST(N'2026-10-21T09:15:34.1792905+00:00' AS DateTimeOffset), NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (3, 2, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-21T09:46:18.0407654+00:00' AS DateTimeOffset), CAST(N'2026-10-21T14:46:18.1642976' AS DateTime2), N'15 El-Horreya St, Front Bakery Counter', 5, NULL, NULL, CAST(N'2026-10-21T09:46:18.2827333+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1002, 2002, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-21T12:00:10.5054877+00:00' AS DateTimeOffset), CAST(N'2026-10-21T17:00:10.6017325' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Side Kitchen Entrance)', 5, NULL, NULL, CAST(N'2026-10-21T12:00:10.7012928+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1003, 4, N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', CAST(N'2026-10-22T08:42:09.1491348+00:00' AS DateTimeOffset), NULL, NULL, 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_FoodCategory]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_FoodCategory] ON [dbo].[FoodListings]
(
	[FoodCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_PickupDeadline]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_PickupDeadline] ON [dbo].[FoodListings]
(
	[PickupDeadline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FoodListings_ProviderId]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_ProviderId] ON [dbo].[FoodListings]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_Status]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_Status] ON [dbo].[FoodListings]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Reservations_CharityId]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_CharityId] ON [dbo].[Reservations]
(
	[CharityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservations_FoodListingId]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_FoodListingId] ON [dbo].[Reservations]
(
	[FoodListingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservations_Status]    Script Date: 10/22/2026 1:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_Status] ON [dbo].[Reservations]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FoodListings]  WITH CHECK ADD  CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[FoodListings] CHECK CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_AspNetUsers_CharityId] FOREIGN KEY([CharityId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_AspNetUsers_CharityId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_FoodListings_FoodListingId] FOREIGN KEY([FoodListingId])
REFERENCES [dbo].[FoodListings] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_FoodListings_FoodListingId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodListings]    Script Date: 10/22/2026 1:03:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodListings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FoodCategory] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[UnitOfMeasurement] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PreparationDate] [datetime2](7) NOT NULL,
	[PickupDeadline] [datetime2](7) NOT NULL,
	[PickupAddress] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StorageConditions] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Allergens] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ImageUrl] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[IsReported] [bit] NOT NULL,
	[ReportReason] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UpdatedAt] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_FoodListings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 10/22/2026 1:03:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FoodListingId] [int] NOT NULL,
	[CharityId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RequestDate] [datetimeoffset](7) NOT NULL,
	[PickupDateTime] [datetime2](7) NULL,
	[ConfirmedLocation] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[CancellationReason] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProblemDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompletedAt] [datetimeoffset](7) NULL,
	[RowVersion] [timestamp] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 10/22/2026 1:03:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReservationId] [int] NOT NULL,
	[ReviewerId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RevieweeId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsReported] [bit] NOT NULL,
	[ReportReason] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] ON 

GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1, N'110ce996-162b-4701-b968-71c28ca5246d', N'Fresh Mediterranean Lasagna & Penne Trays', N'Prepared with Italian beef ragù, béchamel, and mozzarella. Freshly cooked at noon in individual catering trays, ready for immediate distribution.', 1, CAST(35.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T07:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T19:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Kitchen entrance rear alley)', N'Refrigerated (0-4°C) or Keep Warm (>63°C)', N'Gluten, Dairy, Celery', N'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T07:45:34.1104408+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.7680602+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Assorted Artisan Sourdough & French Croissants', N'Daily surplus batch of whole-wheat sourdough loaves, ciabatta, and buttery golden croissants. Baked this morning at 6:00 AM.', 2, CAST(55.00 AS Decimal(18, 2)), N'items', CAST(N'2026-10-21T03:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T23:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Dry & Room Temperature (20-22°C)', N'Gluten, Dairy, Eggs', N'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-21T04:45:34.1104639+00:00' AS DateTimeOffset), CAST(N'2026-10-21T09:46:18.2827337+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (3, N'110ce996-162b-4701-b968-71c28ca5246d', N'Crispy Garden Salad Bowls & Olive Oil Dressing', N'Fresh romaine lettuce, cherry tomatoes, cucumbers, black olives, and feta cheese with balsamic dressing on the side.', 3, CAST(25.00 AS Decimal(18, 2)), N'boxes', CAST(N'2026-10-21T06:45:34.1100924' AS DateTime2), CAST(N'2026-10-21T17:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80', 4, 0, NULL, CAST(N'2026-10-21T06:45:34.1104642+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9150357+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (4, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Natural Greek Yogurt & Farmer White Cheese', N'Unopened wholesale cartons of high-protein plain Greek yogurt and unsalted farmer white cheese, optimal for shelters.', 5, CAST(40.00 AS Decimal(18, 2)), N'kg', CAST(N'2026-10-20T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-23T09:45:34.1100924' AS DateTime2), N'15 El-Horreya St, Heliopolis, Cairo', N'Refrigerated (0-4°C)', N'Dairy', N'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&auto=format&fit=crop&q=80', 1, 0, NULL, CAST(N'2026-10-20T21:45:34.1104653+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (5, N'110ce996-162b-4701-b968-71c28ca5246d', N'Catering Roast Chicken with Oriental Spiced Rice', N'Surplus executive banquet buffet: tender roasted whole chickens, seasoned saffron rice, and roasted mixed vegetables.', 1, CAST(60.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-16T09:45:34.1100924' AS DateTime2), CAST(N'2026-10-17T09:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Refrigerated (0-4°C)', N'Nuts (Pine nuts in rice garnish)', N'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&auto=format&fit=crop&q=80', 3, 0, NULL, CAST(N'2026-10-16T09:45:34.1104697+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (6, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'يييييي', N'صصصصصصصص', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:00:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:00:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, NULL, CAST(N'2026-10-21T11:00:42.0868194+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9197989+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (1002, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'يييييي', N'ييييييي', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-21T14:44:00.0000000' AS DateTime2), CAST(N'2026-10-22T02:44:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 4, 0, N'Disposal Logged: لالالالالا', CAST(N'2026-10-21T11:44:32.1236874+00:00' AS DateTimeOffset), CAST(N'2026-10-22T05:28:10.9216986+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2002, N'110ce996-162b-4701-b968-71c28ca5246d', N'Freshly Baked Artisan Focaccia', N'Surplus batch of herb focaccia baked this afternoon.', 2, CAST(25.00 AS Decimal(18, 2)), N'portions', CAST(N'2026-10-21T15:00:10.2011526' AS DateTime2), CAST(N'2026-10-21T23:00:10.2032785' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo', N'Room temperature (20-25C)', N'Gluten', NULL, 3, 0, NULL, CAST(N'2026-10-21T12:00:10.2436474+00:00' AS DateTimeOffset), CAST(N'2026-10-21T12:00:10.7013550+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2003, N'110ce996-162b-4701-b968-71c28ca5246d', N'يييييي', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:30:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:30:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:30:57.8802002+00:00' AS DateTimeOffset), NULL)
GO
INSERT [dbo].[FoodListings] ([Id], [ProviderId], [FoodName], [Description], [FoodCategory], [Quantity], [UnitOfMeasurement], [PreparationDate], [PickupDeadline], [PickupAddress], [StorageConditions], [Allergens], [ImageUrl], [Status], [IsReported], [ReportReason], [CreatedAt], [UpdatedAt]) VALUES (2004, N'110ce996-162b-4701-b968-71c28ca5246d', N'اي حاجه', N'اي حاجه', 1, CAST(22.00 AS Decimal(18, 2)), N'222', CAST(N'2026-10-22T08:31:00.0000000' AS DateTime2), CAST(N'2026-10-22T20:31:00.0000000' AS DateTime2), N'42 Nile Corniche, Cairo', N'Refrigerated (0-4°C)', N'None', NULL, 1, 0, NULL, CAST(N'2026-10-22T05:31:27.0308858+00:00' AS DateTimeOffset), NULL)
GO
SET IDENTITY_INSERT [dbo].[FoodListings] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 

GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1, 5, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-16T09:45:34.1791302+00:00' AS DateTimeOffset), CAST(N'2026-10-17T07:45:34.1100924' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Loading dock B)', 5, NULL, NULL, CAST(N'2026-10-17T09:45:34.1792373+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (2, 1, N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', CAST(N'2026-10-21T09:15:34.1792905+00:00' AS DateTimeOffset), NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (3, 2, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-21T09:46:18.0407654+00:00' AS DateTimeOffset), CAST(N'2026-10-21T14:46:18.1642976' AS DateTime2), N'15 El-Horreya St, Front Bakery Counter', 5, NULL, NULL, CAST(N'2026-10-21T09:46:18.2827333+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1002, 2002, N'c63004e9-8326-40ff-b382-eadce2c34d14', CAST(N'2026-10-21T12:00:10.5054877+00:00' AS DateTimeOffset), CAST(N'2026-10-21T17:00:10.6017325' AS DateTime2), N'42 Nile Corniche, Zamalek, Cairo (Side Kitchen Entrance)', 5, NULL, NULL, CAST(N'2026-10-21T12:00:10.7012928+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reservations] ([Id], [FoodListingId], [CharityId], [RequestDate], [PickupDateTime], [ConfirmedLocation], [Status], [CancellationReason], [ProblemDescription], [CompletedAt]) VALUES (1003, 4, N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', CAST(N'2026-10-22T08:42:09.1491348+00:00' AS DateTimeOffset), NULL, NULL, 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

GO
INSERT [dbo].[Reviews] ([Id], [ReservationId], [ReviewerId], [RevieweeId], [Rating], [Comment], [IsReported], [ReportReason], [CreatedAt]) VALUES (1, 1, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'110ce996-162b-4701-b968-71c28ca5246d', 5, N'Exceptional food quality and packaging! The chicken was piping hot and cleanly packed in deep thermal containers. Helped us feed over 50 residents today. Thank you Mario!', 0, NULL, CAST(N'2026-10-17T11:45:34.2211742+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reviews] ([Id], [ReservationId], [ReviewerId], [RevieweeId], [Rating], [Comment], [IsReported], [ReportReason], [CreatedAt]) VALUES (2, 1, N'110ce996-162b-4701-b968-71c28ca5246d', N'c63004e9-8326-40ff-b382-eadce2c34d14', 5, N'Hope Food Bank arrived exactly on time with a refrigerated van and sanitary handling gear. Fantastic communication and great partners!', 0, NULL, CAST(N'2026-10-17T12:45:34.2211986+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reviews] ([Id], [ReservationId], [ReviewerId], [RevieweeId], [Rating], [Comment], [IsReported], [ReportReason], [CreatedAt]) VALUES (3, 3, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', 5, N'Fresh sourdough in perfect condition! Thank you Sarah!', 0, NULL, CAST(N'2026-10-21T09:46:18.3144384+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Reviews] ([Id], [ReservationId], [ReviewerId], [RevieweeId], [Rating], [Comment], [IsReported], [ReportReason], [CreatedAt]) VALUES (1002, 1002, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'110ce996-162b-4701-b968-71c28ca5246d', 5, N'Outstanding food quality and seamless pickup coordination! Thank you Chef Mario.', 0, NULL, CAST(N'2026-10-21T12:00:10.7355919+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_FoodCategory]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_FoodCategory] ON [dbo].[FoodListings]
(
	[FoodCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_PickupDeadline]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_PickupDeadline] ON [dbo].[FoodListings]
(
	[PickupDeadline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FoodListings_ProviderId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_ProviderId] ON [dbo].[FoodListings]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FoodListings_Status]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_FoodListings_Status] ON [dbo].[FoodListings]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Reservations_CharityId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_CharityId] ON [dbo].[Reservations]
(
	[CharityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservations_FoodListingId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_FoodListingId] ON [dbo].[Reservations]
(
	[FoodListingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservations_Status]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reservations_Status] ON [dbo].[Reservations]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Reviews_ReservationId_ReviewerId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reviews_ReservationId_ReviewerId] ON [dbo].[Reviews]
(
	[ReservationId] ASC,
	[ReviewerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Reviews_RevieweeId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_RevieweeId] ON [dbo].[Reviews]
(
	[RevieweeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Reviews_ReviewerId]    Script Date: 10/22/2026 1:03:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_ReviewerId] ON [dbo].[Reviews]
(
	[ReviewerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FoodListings]  WITH CHECK ADD  CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[FoodListings] CHECK CONSTRAINT [FK_FoodListings_AspNetUsers_ProviderId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_AspNetUsers_CharityId] FOREIGN KEY([CharityId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_AspNetUsers_CharityId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_FoodListings_FoodListingId] FOREIGN KEY([FoodListingId])
REFERENCES [dbo].[FoodListings] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_FoodListings_FoodListingId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_AspNetUsers_RevieweeId] FOREIGN KEY([RevieweeId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_AspNetUsers_RevieweeId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_AspNetUsers_ReviewerId] FOREIGN KEY([ReviewerId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_AspNetUsers_ReviewerId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Reservations_ReservationId] FOREIGN KEY([ReservationId])
REFERENCES [dbo].[Reservations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Reservations_ReservationId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 10/22/2026 1:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Title] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Message] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsRead] [bit] NOT NULL,
	[RelatedEntityId] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (1, N'110ce996-162b-4701-b968-71c28ca5246d', N'New Reservation Request', N'St. Jude Family Shelter submitted a reservation request for ''Fresh Mediterranean Lasagna & Penne Trays''.', 1, N'reservation:2', CAST(N'2026-10-21T09:15:34.2361595+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Donation Completed', N'Your reservation for ''Catering Roast Chicken with Oriental Spiced Rice'' was confirmed completed. Thank you for your partnership!', 1, N'reservation:1', CAST(N'2026-10-17T09:45:34.2361850+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (3, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'New Organizations Awaiting Verification', N'Grand Palace Hotel and Al-Noor Refugee Relief have submitted registration credentials for review.', 1, N'admin:verifications', CAST(N'2026-10-20T09:45:34.2361855+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (4, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'New Reservation Request', N'Hope Community Food Bank requested reservation for ''Assorted Artisan Sourdough & French Croissants''.', 1, N'reservation:3', CAST(N'2026-10-21T09:46:18.0448091+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (5, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Reservation Accepted!', N'Your reservation for ''Assorted Artisan Sourdough & French Croissants'' has been accepted. Pickup confirmed for 10/21/2026 2:46 PM at 15 El-Horreya St, Front Bakery Counter.', 0, N'reservation:3', CAST(N'2026-10-21T09:46:18.2338001+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (6, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Food Ready For Pickup!', N'''Assorted Artisan Sourdough & French Croissants'' is packaged and ready for collection at 15 El-Horreya St, Front Bakery Counter.', 0, N'reservation:3', CAST(N'2026-10-21T09:46:18.2593480+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (7, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Donation Completed!', N'Hope Community Food Bank has confirmed pickup of ''Assorted Artisan Sourdough & French Croissants''. Please leave a review!', 0, N'reservation:3', CAST(N'2026-10-21T09:46:18.2875860+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (8, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'New Review Received', N'Hope Community Food Bank rated you 5 stars.', 0, N'reservation:3', CAST(N'2026-10-21T09:46:18.3172014+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (9, N'76525670-81f7-4441-b6f6-4165ea458a14', N'Organization Verified!', N'Your organization verification has been approved by the platform administrator. You have full access to donation features!', 0, N'user:76525670-81f7-4441-b6f6-4165ea458a14', CAST(N'2026-10-21T09:46:30.0382549+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (1002, N'032cd086-d5af-4095-bd30-23039fbc697a', N'Organization Verified!', N'Your organization verification has been approved by the platform administrator. You have full access to donation features!', 0, N'user:032cd086-d5af-4095-bd30-23039fbc697a', CAST(N'2026-10-21T11:33:06.4055024+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (1003, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-21T11:33:08.2402690+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2002, N'110ce996-162b-4701-b968-71c28ca5246d', N'New Reservation Request', N'Hope Community Food Bank requested reservation for ''Freshly Baked Artisan Focaccia''.', 0, N'reservation:1002', CAST(N'2026-10-21T12:00:10.5374915+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2003, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Reservation Accepted!', N'Your reservation for ''Freshly Baked Artisan Focaccia'' has been accepted. Pickup confirmed for 10/21/2026 5:00 PM at 42 Nile Corniche, Zamalek, Cairo (Side Kitchen Entrance).', 0, N'reservation:1002', CAST(N'2026-10-21T12:00:10.6593165+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2004, N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Food Ready For Pickup!', N'''Freshly Baked Artisan Focaccia'' is packaged and ready for collection at 42 Nile Corniche, Zamalek, Cairo (Side Kitchen Entrance).', 0, N'reservation:1002', CAST(N'2026-10-21T12:00:10.6882003+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2005, N'110ce996-162b-4701-b968-71c28ca5246d', N'Donation Completed!', N'Hope Community Food Bank has confirmed pickup of ''Freshly Baked Artisan Focaccia''. Please leave a review!', 0, N'reservation:1002', CAST(N'2026-10-21T12:00:10.7061616+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2006, N'110ce996-162b-4701-b968-71c28ca5246d', N'New Review Received', N'Hope Community Food Bank rated you 5 stars.', 0, N'reservation:1002', CAST(N'2026-10-21T12:00:10.7462879+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2007, N'110ce996-162b-4701-b968-71c28ca5246d', N'Listing Expired', N'Your food listing ''Fresh Mediterranean Lasagna & Penne Trays'' has expired as the pickup deadline passed.', 0, N'listing:1', CAST(N'2026-10-22T05:28:10.7694011+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2008, N'110ce996-162b-4701-b968-71c28ca5246d', N'Listing Expired', N'Your food listing ''Crispy Garden Salad Bowls & Olive Oil Dressing'' has expired as the pickup deadline passed.', 0, N'listing:3', CAST(N'2026-10-22T05:28:10.9150526+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2009, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Listing Expired', N'Your food listing ''يييييي'' has expired as the pickup deadline passed.', 0, N'listing:6', CAST(N'2026-10-22T05:28:10.9198009+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2010, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'Listing Expired', N'Your food listing ''يييييي'' has expired as the pickup deadline passed.', 0, N'listing:1002', CAST(N'2026-10-22T05:28:10.9216997+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2011, N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'New Reservation Request', N'NTI requested reservation for ''Natural Greek Yogurt & Farmer White Cheese''.', 0, N'reservation:1003', CAST(N'2026-10-22T08:42:09.1946253+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2012, N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'Organization Verified!', N'Your organization verification has been approved by the platform administrator. You have full access to donation features!', 0, N'user:b926e509-ad4c-45cf-98a9-89d3d3e9b80f', CAST(N'2026-10-22T08:44:14.6473069+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2013, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'Organization Verified!', N'Your organization verification has been approved by the platform administrator. You have full access to donation features!', 0, N'user:5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', CAST(N'2026-10-22T08:44:15.5256140+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2014, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:17.0555712+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2015, N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:e9c4c35e-1b88-4d29-b382-29d60e1a371f', CAST(N'2026-10-22T09:11:19.6186391+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2016, N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:7539fba2-f9f2-432a-9061-30cf8cf63664', CAST(N'2026-10-22T09:11:20.5598020+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2017, N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Organization Verified!', N'Your organization verification has been approved by the platform administrator. You have full access to donation features!', 0, N'user:e9c4c35e-1b88-4d29-b382-29d60e1a371f', CAST(N'2026-10-22T09:11:28.9084769+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2018, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:29.9206161+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2019, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:30.3863231+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2020, N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:7539fba2-f9f2-432a-9061-30cf8cf63664', CAST(N'2026-10-22T09:11:32.5284463+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2021, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:36.4716936+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2022, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:37.0960723+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2023, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:11:39.4796350+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2024, N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'Account Suspended', N'Your FoodBridge account has been suspended due to platform policy review.', 0, N'user:b926e509-ad4c-45cf-98a9-89d3d3e9b80f', CAST(N'2026-10-22T09:11:48.7393760+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2025, N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:7539fba2-f9f2-432a-9061-30cf8cf63664', CAST(N'2026-10-22T09:12:15.8339293+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2026, N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:7539fba2-f9f2-432a-9061-30cf8cf63664', CAST(N'2026-10-22T09:12:26.9763270+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2027, N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', CAST(N'2026-10-22T09:12:27.6584308+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2028, N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'Food Waste Advisory Warning', N'Administrative Notice: Listing ''يييييي'' (22.00 222) expired without redistribution. Please schedule earlier pickup windows. Notes: برررررررررررررررررر', 0, N'listing:1002', CAST(N'2026-10-22T09:12:43.5436328+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2029, N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:92928a87-f55f-4a50-a860-4a9141a185cb', CAST(N'2026-10-22T09:14:45.3427495+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2030, N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:92928a87-f55f-4a50-a860-4a9141a185cb', CAST(N'2026-10-22T09:26:37.7415476+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2031, N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:92928a87-f55f-4a50-a860-4a9141a185cb', CAST(N'2026-10-22T09:26:39.3323577+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2032, N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:92928a87-f55f-4a50-a860-4a9141a185cb', CAST(N'2026-10-22T09:38:26.7465762+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [IsRead], [RelatedEntityId], [CreatedAt]) VALUES (2033, N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Verification Update', N'Your organization verification request was not approved. Please contact platform support for guidance.', 0, N'user:b8cee188-8887-4e0f-b12c-305c2ee0313b', CAST(N'2026-10-22T09:44:26.3392236+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:50 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Notifications_UserId_IsRead]    Script Date: 10/22/2026 1:03:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_UserId_IsRead] ON [dbo].[Notifications]
(
	[UserId] ASC,
	[IsRead] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/22/2026 1:03:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrganizationAddress] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [int] NOT NULL,
	[SpecificType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetCommunityDescription] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVerified] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedUserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NormalizedEmail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConcurrencyStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 10/22/2026 1:03:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdminId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Action] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetEntity] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TargetId] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Details] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Timestamp] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'032cd086-d5af-4095-bd30-23039fbc697a', N'Hassan Bakery', N'Hassan Bakery Studio', N'15 Dokki St, Giza', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-10-21T09:47:53.9408848+00:00' AS DateTimeOffset), N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', N'hassan@bakerystudio.com', N'HASSAN@BAKERYSTUDIO.COM', 1, N'AQAAAAIAAYagAAAAEOCFFfqN3rO468gm2egfogAoEAOnfXG6Ashg5ed4RJgQEF40JA/l8jmlMchE4DOZ8w==', N'UJRVWLQPJ6E5AVPJCZTFU4S34GPOODYQ', N'7d3bc8f1-dc16-4c13-92fa-94524e995948', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Tariq Mahmoud', N'FoodBridge Platform Administration', N'FoodBridge Operations Center', 3, N'Quality Assurance & Compliance', NULL, 1, 1, CAST(N'2026-10-21T13:41:40.2003161+00:00' AS DateTimeOffset), N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', N'tariq.admin@foodbridge.com', N'TARIQ.ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEAnhtR6B+oHi12gE2QoskKXa12qQxpae9TbzqWWOv/xw4CBI4E8lW2G4AYkmm71w2g==', N'BPAD7S7FK3YKQKQRFTVCAIQCOBJO237B', N'ffe7db0b-89e4-4bcf-9117-dc6f29327f3e', N'+201012345678', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'110ce996-162b-4701-b968-71c28ca5246d', N'Chef Mario Rossi', N'Bella Italia Ristorante', N'42 Nile Corniche, Zamalek, Cairo', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-08-21T09:45:33.7500599+00:00' AS DateTimeOffset), N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', N'chef.mario@bellaitalia.com', N'CHEF.MARIO@BELLAITALIA.COM', 1, N'AQAAAAIAAYagAAAAEHzhbWHQ2LtOI6aiB4f/R6dF7PVNRjQIVzCup/otRBCKV52WHxCsg9zH08tJE3Womw==', N'ZNCG35XSBP75LSVS6RVLOSYFA44SHXXD', N'3a9aeab3-4cc2-40a6-8a12-b073b7bc4983', N'+20 100 123 4567', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'57f16288-9318-44b0-815e-fbf0bbf74669', N'Platform Administrator', N'FoodBridge Platform Ops', N'100 Innovation Way, Smart Village, Cairo', 3, N'Platform Ops', NULL, 1, 1, CAST(N'2026-07-21T09:45:33.5123031+00:00' AS DateTimeOffset), N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', N'admin@foodbridge.com', N'ADMIN@FOODBRIDGE.COM', 1, N'AQAAAAIAAYagAAAAEMI0QpcHKCoJLgLqhIcuwsIKAVW5mCv04otjpb54j0fSSTCDcbMf6tYxdMytw9R5tg==', N'LPT7VCRH3G4VZ6RJLKUEVGQNWF6EOZ2Z', N'0e0e74f1-f771-4661-ae0b-d2ed4fadc069', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'abdallah sharaf', N'NTI', N'giza', 1, N'Restaurant', NULL, 1, 1, CAST(N'2026-10-21T11:44:10.8640433+00:00' AS DateTimeOffset), N'd66659285@gmail.com', N'D66659285@GMAIL.COM', N'd66659285@gmail.com', N'D66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEAHJM0xr7d6YAbOCbXKj7dxKpetNojz+dTYhoQG3vU1MQpjnJlyfX6mxXmsNWPTdNg==', N'7EC3UXQ7VI5TAQVQXLW73WWM3W4IP45V', N'b601ae62-45f9-4549-8652-046f9de04025', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'2222', 0, 1, CAST(N'2026-10-21T11:43:29.7825367+00:00' AS DateTimeOffset), N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', N'abdall6659285@gmail.com', N'ABDALL6659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEPL5n651S6UYAzeUnI9hTEi/gWkH/lX4++IK+qaECYHe6EDOgj7ztDKO/X+W45IA4g==', N'NJUNUWOGAGFYMQFAGJ445ZZNPSNJEIMR', N'ab4b9ac8-4417-4883-a03f-8ace58b80f88', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76525670-81f7-4441-b6f6-4165ea458a14', N'Karim Mansour', N'Grand Palace Hotel & Banquets', N'88 Tahrir Square, Cairo', 1, N'Hotel', NULL, 1, 1, CAST(N'2026-10-18T09:45:33.8791046+00:00' AS DateTimeOffset), N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', N'banquets@grandpalace.com', N'BANQUETS@GRANDPALACE.COM', 1, N'AQAAAAIAAYagAAAAECWD+7Q+EBgXb5P4KIiEAeDEFZdv6byNmFMUy0PG5Umm8XP+cKxNbw5w5T25qOD/sg==', N'CLPSLVIXSUC5IA7OLTQO7GB6MCY6FFDE', N'c2c1379e-5026-4d76-97cb-446479a0ffc3', N'+20 102 555 1234', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Tarek Bakery Chef', N'The Bakery Studio', N'10 Dokki St, Giza', 1, N'Bakery', NULL, 0, 1, CAST(N'2026-10-21T09:47:21.8019341+00:00' AS DateTimeOffset), N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', N'tarek@bakerystudio.com', N'TAREK@BAKERYSTUDIO.COM', 0, N'AQAAAAIAAYagAAAAEDJ6iqU50AWxt9wrAGa22XAv83d8gM1BjruzRr2p0ufJQBXofwvhEEsjnkF4n0srlA==', N'DJXMMCCEZOQ7PRDIIELJPKWGXKE5GZ4B', N'e0de968e-1ede-402b-8c26-811767cc77db', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92928a87-f55f-4a50-a860-4a9141a185cb', N'abdallah', N'aa', N'giza', 1, N'Hotel', NULL, 0, 2, CAST(N'2026-10-22T09:13:57.9322491+00:00' AS DateTimeOffset), N'ahmed@gmail.com', N'AHMED@GMAIL.COM', N'ahmed@gmail.com', N'AHMED@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEDBK7ws9G7FePCHVeRyKBNN8BfmHhmw3O0/w9j6auTA7bMMVYXKcn1UtPNOBU6Quvw==', N'DVZ6P4LKS55OS2KQ7VZQFYEDENAIKQ5E', N'2a348e65-1245-47cb-858b-e47ef20565ec', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Test Chef 5990', N'Test Kitchen 5990', N'15 Nile Corniche, Cairo', 1, N'Restaurant', NULL, 0, 2, CAST(N'2026-10-22T09:44:25.8886181+00:00' AS DateTimeOffset), N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', N'chef5990@testkitchen.com', N'CHEF5990@TESTKITCHEN.COM', 0, N'AQAAAAIAAYagAAAAENe8i7X6OTmHsxSkagbmcrfcVyyW2/sQ3B086MQVFfAFhRwjJ2tuEznF1AOhTK1tow==', N'QEGFDL25OH5JHE3LAL5LBJJGN32LPFNU', N'ba719858-b25f-4509-b405-9040a8c6a063', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'abdallah sharaf', N'NTI', N'giza', 2, N'Food Bank', N'ءءءءءءءء', 1, 2, CAST(N'2026-10-22T08:41:52.8210124+00:00' AS DateTimeOffset), N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', N'abdallahahmed66659285@gmail.com', N'ABDALLAHAHMED66659285@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEJfq2AjhqTCTM7875JQV24jupllE5m/v7Yd2kM4zRoz8AnTiT3MkfhAbv0DqgkwyEA==', N'ZR4AHMQZ34FRKLROU5USC6PM5V3B3EJ3', N'048ca066-520a-4fb0-93cd-6d203820a002', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c63004e9-8326-40ff-b382-eadce2c34d14', N'Laila El-Sayed', N'Hope Community Food Bank', N'22 Al-Gomhoria St, Downtown Cairo', 2, N'Food Bank', N'Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.', 1, 1, CAST(N'2026-08-21T09:45:33.9316252+00:00' AS DateTimeOffset), N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', N'coordinator@hopefoodbank.org', N'COORDINATOR@HOPEFOODBANK.ORG', 1, N'AQAAAAIAAYagAAAAEI2087+UB3eiWCepejwIZYwjjdncWhFL8AHcrnCHXgllUsnIul36rrGgAn3mBbUU2w==', N'OMFK2NESU55ARGHZZNYWWMEDELMCUCID', N'58c852ee-7a13-4af6-946c-62ebc2346ac6', N'+20 111 888 9999', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ccc12244-d9e8-4374-a9a0-9a52ed80c14d', N'Sarah Jenkins', N'Artisan Bread & Pastry Co.', N'15 El-Horreya St, Heliopolis, Cairo', 1, N'Bakery', NULL, 1, 1, CAST(N'2026-09-21T09:45:33.8260443+00:00' AS DateTimeOffset), N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', N'sarah@lebreadcraft.com', N'SARAH@LEBREADCRAFT.COM', 1, N'AQAAAAIAAYagAAAAEAbVdzmx+kVKNqleX6gH4u72KPIBOENgJGKR7Vc1SeC6cduIWvZl88jHk2etoPn7hg==', N'BB6DUX32DIX36IAKMTIWLNWDLMEYZCHM', N'b6450b90-ae27-477c-870c-bd9898e7d362', N'+20 100 765 4321', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e7e572d0-b053-43b6-8d3c-dde5e00108d4', N'Father Thomas Hanna', N'St. Jude Family Shelter', N'12 Shoubra St, Cairo', 2, N'Shelter', N'Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.', 1, 1, CAST(N'2026-09-21T09:45:33.9845070+00:00' AS DateTimeOffset), N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', N'shelter@stjude-care.org', N'SHELTER@STJUDE-CARE.ORG', 1, N'AQAAAAIAAYagAAAAENrbZeEZwxvj72C4f6Hv3AJTBBXkrjxqfF6belAwx0Pp9y+Ww1uGZLUHNux0I8gb4w==', N'7CLIJYC2BXOBYSHYYX7DOGA5ZM2TAPIE', N'a96627e4-023b-400f-9546-b424415731c2', N'+20 122 333 4444', 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [OrganizationName], [OrganizationAddress], [UserType], [SpecificType], [TargetCommunityDescription], [IsVerified], [Status], [CreatedAt], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Tarek Nabil', N'Al-Noor Refugee Relief', N'5 Nasr City, Zone 6, Cairo', 2, N'Community Center', N'Distributing meal packages and dietary aid to displaced families and international students.', 1, 1, CAST(N'2026-10-19T09:45:34.0395839+00:00' AS DateTimeOffset), N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', N'youth@alnoor-foundation.org', N'YOUTH@ALNOOR-FOUNDATION.ORG', 1, N'AQAAAAIAAYagAAAAEIsqxu2+skHXMvEJwAYVWzEKHIRt8gkzUPJsi5LrDPZzzSJMzZjN3v9GLLQ19huFcg==', N'4ZFY6BVCUROOOZ2TE5J4O4ATYTVE35YN', N'09ebfa08-8880-42a6-bc28-d317bd92d52e', N'+20 114 999 0000', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] ON 

GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (1, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'SystemProvisioning', N'System', N'0', N'FoodBridge platform database initialized and default administrative account provisioned.', CAST(N'2026-07-21T09:45:33.7264592+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (2, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'ApproveVerification', N'ApplicationUser', N'76525670-81f7-4441-b6f6-4165ea458a14', N'Organization ''Grand Palace Hotel & Banquets'' verification approved.', CAST(N'2026-10-21T09:46:30.0340948+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (1002, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'ApproveVerification', N'ApplicationUser', N'032cd086-d5af-4095-bd30-23039fbc697a', N'Organization ''Hassan Bakery Studio'' verification approved.', CAST(N'2026-10-21T11:33:06.2654092+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (1003, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-21T11:33:08.2367395+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (2002, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'CreateAdmin', N'ApplicationUser', N'045b21e8-e4cf-4e5b-a8df-8e0f73f308ec', N'Administrator created new admin account for ''Tariq Mahmoud'' (tariq.admin@foodbridge.com) - Department/Role: Quality Assurance & Compliance', CAST(N'2026-10-21T13:41:40.3905809+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (2003, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Core system upgrades and database schema enhancements. Duration: 30 ????? / 30 Minutes.', CAST(N'2026-10-22T07:38:19.8628794+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (2004, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T07:38:20.1196169+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3003, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 30-45 دقيقة / 30-45 Minutes.', CAST(N'2026-10-22T07:53:27.5253821+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3004, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T08:17:13.1877007+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3005, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 30-45 دقيقة / 30-45 Minutes.', CAST(N'2026-10-22T08:23:38.9656118+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3006, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 30-45 دقيقة / 30-45 Minutes.', CAST(N'2026-10-22T08:40:06.8556605+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3007, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T08:40:14.9936515+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3008, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'ApproveVerification', N'ApplicationUser', N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'Organization ''NTI'' verification approved.', CAST(N'2026-10-22T08:44:14.5441073+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3009, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'ApproveVerification', N'ApplicationUser', N'5e8a22e2-fd86-4246-b4dd-3c0ba09284b8', N'Organization ''NTI'' verification approved.', CAST(N'2026-10-22T08:44:15.5221136+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3010, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 30-45 دقيقة / 30-45 Minutes.', CAST(N'2026-10-22T08:46:15.0556077+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3011, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T09:09:42.5957312+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3012, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 15-20 دقيقة / 15-20 Minutes.', CAST(N'2026-10-22T09:10:07.4080800+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3013, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 15-20 دقيقة / 15-20 Minutes.', CAST(N'2026-10-22T09:10:28.0079481+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3014, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T09:10:31.9437318+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3015, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:16.9538752+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3016, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Organization ''Al-Noor Refugee Relief'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:19.6165013+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3017, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Organization ''NTI'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:20.5580510+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3018, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'ApproveVerification', N'ApplicationUser', N'e9c4c35e-1b88-4d29-b382-29d60e1a371f', N'Organization ''Al-Noor Refugee Relief'' verification approved.', CAST(N'2026-10-22T09:11:28.8865557+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3019, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:29.9191247+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3020, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:30.3829190+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3021, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Organization ''NTI'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:32.5265038+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3022, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:36.4704945+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3023, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:37.0943681+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3024, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:11:39.4784039+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3025, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'SuspendUser', N'ApplicationUser', N'b926e509-ad4c-45cf-98a9-89d3d3e9b80f', N'User ''abdallah sharaf'' (NTI) was suspended.', CAST(N'2026-10-22T09:11:48.7340469+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3026, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Organization ''NTI'' verification revoked/rejected.', CAST(N'2026-10-22T09:12:15.8305640+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3027, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'7539fba2-f9f2-432a-9061-30cf8cf63664', N'Organization ''NTI'' verification revoked/rejected.', CAST(N'2026-10-22T09:12:26.9748608+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3028, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'811e5d5a-e32d-4aa8-8f7a-a51c44d25aec', N'Organization ''The Bakery Studio'' verification revoked/rejected.', CAST(N'2026-10-22T09:12:27.6549864+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3029, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'WarnProviderFoodWaste', N'FoodListing', N'1002', N'Official advisory sent to provider for expired surplus ''يييييي'' (22.00 222). Notes: برررررررررررررررررر', CAST(N'2026-10-22T09:12:43.5434979+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3030, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Organization ''aa'' verification revoked/rejected.', CAST(N'2026-10-22T09:14:45.2483641+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3031, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Security and database optimization. Duration: 30 minutes.', CAST(N'2026-10-22T09:21:31.3293903+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3032, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T09:21:44.4220992+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3033, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Organization ''aa'' verification revoked/rejected.', CAST(N'2026-10-22T09:26:37.6512105+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3034, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Organization ''aa'' verification revoked/rejected.', CAST(N'2026-10-22T09:26:39.3286989+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3035, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'EnableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform locked for maintenance by Platform Administrator. Reason: Database server upgrade & security enhancements. Duration: 30-45 دقيقة / 30-45 Minutes.', CAST(N'2026-10-22T09:37:43.4299882+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3036, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'92928a87-f55f-4a50-a860-4a9141a185cb', N'Organization ''aa'' verification rejected and suspended.', CAST(N'2026-10-22T09:38:26.7350511+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3037, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'DisableMaintenanceMode', N'System', N'MaintenanceMode', N'Platform returned to live operation by Platform Administrator.', CAST(N'2026-10-22T09:38:51.6196661+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3038, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RejectVerification', N'ApplicationUser', N'b8cee188-8887-4e0f-b12c-305c2ee0313b', N'Organization ''Test Kitchen 5990'' verification rejected and suspended.', CAST(N'2026-10-22T09:44:26.3007682+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[AuditLogs] ([Id], [AdminId], [Action], [TargetEntity], [TargetId], [Details], [Timestamp]) VALUES (3039, N'57f16288-9318-44b0-815e-fbf0bbf74669', N'RecordWasteDisposal', N'FoodListing', N'1002', N'Safe disposal audit logged for expired surplus ''يييييي'' (22.00 222). Notes: لالالالالا', CAST(N'2026-10-22T10:03:08.8470453+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 10/22/2026 1:03:53 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/22/2026 1:03:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AuditLogs_AdminId]    Script Date: 10/22/2026 1:03:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_AuditLogs_AdminId] ON [dbo].[AuditLogs]
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AuditLogs_Timestamp]    Script Date: 10/22/2026 1:03:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_AuditLogs_Timestamp] ON [dbo].[AuditLogs]
(
	[Timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLogs]  WITH CHECK ADD  CONSTRAINT [FK_AuditLogs_AspNetUsers_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AuditLogs] CHECK CONSTRAINT [FK_AuditLogs_AspNetUsers_AdminId]
GO
