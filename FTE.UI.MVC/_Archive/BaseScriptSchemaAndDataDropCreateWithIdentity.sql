IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserDetails]') AND type in (N'U'))
ALTER TABLE [dbo].[UserDetails] DROP CONSTRAINT IF EXISTS [FK_UserDetails_AspNetUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reservations]') AND type in (N'U'))
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT IF EXISTS [FK_Reservations_OwnerAssets]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reservations]') AND type in (N'U'))
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT IF EXISTS [FK_Reservations_Events]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerAssets]') AND type in (N'U'))
ALTER TABLE [dbo].[OwnerAssets] DROP CONSTRAINT IF EXISTS [FK_OwnerAssets_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerAssets]') AND type in (N'U'))
ALTER TABLE [dbo].[OwnerAssets] DROP CONSTRAINT IF EXISTS [FK_OwnerAssets_TruckFoodType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Events]') AND type in (N'U'))
ALTER TABLE [dbo].[Events] DROP CONSTRAINT IF EXISTS [FK_Events_Locations]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[UserDetails]
GO
/****** Object:  Table [dbo].[TruckFoodType]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[TruckFoodType]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[Reservations]
GO
/****** Object:  Table [dbo].[OwnerAssets]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[OwnerAssets]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[Locations]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[Events]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/3/2021 9:21:43 AM ******/
DROP TABLE IF EXISTS [dbo].[__MigrationHistory]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/3/2021 9:21:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/3/2021 9:21:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/3/2021 9:21:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/3/2021 9:21:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/3/2021 9:21:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
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
/****** Object:  Table [dbo].[Events]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](100) NOT NULL,
	[LocationID] [int] NOT NULL,
	[EventDate] [date] NOT NULL,
	[IsCancelled] [bit] NOT NULL,
	[Notes] [varchar](300) NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [varchar](50) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[State] [char](2) NOT NULL,
	[ZipCode] [char](5) NOT NULL,
	[ReservationLimit] [tinyint] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerAssets]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerAssets](
	[OwnerAssetID] [int] IDENTITY(1,1) NOT NULL,
	[TruckName] [varchar](50) NOT NULL,
	[TruckFoodTypeID] [int] NOT NULL,
	[TruckPhoto] [varchar](100) NULL,
	[OwnerID] [nvarchar](128) NOT NULL,
	[SpecialNotes] [varchar](300) NULL,
	[IsActive] [bit] NOT NULL,
	[DateAdded] [date] NOT NULL,
 CONSTRAINT [PK_OwnerAssets] PRIMARY KEY CLUSTERED 
(
	[OwnerAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerAssetID] [int] NOT NULL,
	[EventID] [int] NOT NULL,
	[ReservationDate] [date] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TruckFoodType]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TruckFoodType](
	[TruckFoodTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Cuisine] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_TruckFoodType] PRIMARY KEY CLUSTERED 
(
	[TruckFoodTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 2/3/2021 9:21:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetails](
	[UserID] [nvarchar](128) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202101251934548_InitialCreate', N'IdentitySample.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE4B8117D0F907F10F49404DE962F99C1C468EFC2DBB61323E30BA6ED41DE066C89DD1646A2B412E5B511EC97E5219F945F4851A22EBCE9D22D77B7170B2CDC2279AA583C248BC5E2FCEF3FFF9DFEF41206D6334E523F2267F6D1E4D0B6307123CF27AB333BA3CB1F3ED93FFDF8C73F4C2FBDF0C5FA5AD63B61F5A02549CFEC274AE353C749DD271CA27412FA6E12A5D1924EDC2874901739C787877F738E8E1C0C10366059D6F44B46A81FE2FC07FC9C45C4C531CD507013793848F9772899E7A8D62D0A711A23179FD9D71E86B6F4758EC238C093A2816D9D073E0265E63858DA162224A28882AAA78F299ED32422AB790C1F50F0F01A63A8B744418A79174EEBEA7D7B7378CC7AE3D40D4B28374B69140E043C3AE1E671E4E66B19D9AECC0706BCCC8DC57A9D1BB1B6DF97280003C8024F6741C22A9FD9379588F334BEC57452369C14905709C0FD1A25DF274DC403AB77BB838A4EC79343F6DF8135CB029A25F88CE08C262838B0EEB345E0BBFFC4AF0FD1774CCE4E8E16CB934F1F3E22EFE4E35FF1C987664FA1AF504FF8009FEE9328C609E8869755FF6DCB11DB3972C3AA59A34D6115E012CC0CDBBA412F9F3159D1279833C79F6CEBCA7FC15EF98593EB91F83091A0114D32F8799B05015A04B82A775A65B2FFB7483DFEF07114A9B7E8D95FE5432FC9878993C0BCFA8283BC347DF2E3627A09E3FD8D57BB4AA290FD16F955947E9B4759E2B2CE44C62A0F2859612A6A37756AF2F6A234831A9FD625EAFE539B69AAD25B5B9575689D99508AD8F66C28F57D5BB9BD19771EC7307839B59845DA08A7DDAF2612C08175F5703979BC9EDC7C9DD5E439EA4B1E029DFA3DAF859721F2831116C31E52C01559FA4988AB5EFE1C01F51019ACF33D4A53580BBC7FA0F4A94575F87304D5E7D8CD1246320A2C7B7369F74F11C1B759B860CCDF9EACD186E6E1D7E80AB9344A2E096BB531DEE7C8FD1E65F492781788E247EA9680ECE7831FF60718459D73D7C5697A0564C6DE2C024FBB04BC26F4E478301C5B9F76ED8CCC02E4877A6F445A49BF95556B8F445F43F14A0CD5749E499BAA9FA3954FFAA95A5635AB5AD4E85495571BAA2A03EBA729AF695634AFD0A967516B345F2F1FA1F19DBD1C76FFBDBDCD366FD35AD030E31C5648FC774C7002CB98778F28C509A947A0CFBAB10B67211F3E26F4CDF7A65CD2571464638B5A6B36E48BC0F8B32187DDFFD990AB099F9F7D8F79253D8E40656580EF555F7FBAEA9E739266DB9E0E4237B72D7C3B6B8069BA9CA769E4FAF92CD004BF78E842D41F7C38AB3B8E51F4468E8540C780E83EDBF2E00BF4CD964975472E708029B6CEDD22383843A98B3CD58CD0216F8062E58EAA51AC8E8988CAFD4591094CC7096B84D821288599EA13AA4E0B9FB87E8C824E2B492D7B6E61ACEF950CB9E402C79830819D96E8235C1F02610A5472A441E9B2D0D46930AE9D8806AFD534E65D2E6C3DEE4A64622B9CECF09D0DBCE4FEDB9B10B3DD625B2067BB49FA28600CE7ED82A0FCACD29700F2C165DF082A9D980C04E52ED556082A5A6C0704154DF2EE085A1C51FB8EBF745EDD377A8A07E5ED6FEBADE6DA0137057BEC19350BDF13DA50688113959E170B56885FA8E670067AF2F359CA5D5D9922F9DD01A662C8A6F677B57EA8D30E2293A80DB0265A0728BF08548094093540B93296D7AA1DF72206C09671B75658BEF64BB00D0EA8D8CD0BD14645F3B5A94CCE5EA78FAA67151B1492F73A2C3470348490172FB1E33D8C628ACBAA86E9E30B0FF1861B1DE383D162A00ECFD560A4B233A35BA9A466B795740ED910976C232B49EE93C14A656746B712E768B791344EC100B7602313895BF84893AD8C7454BB4D5536758A5429FE61EA1872AAA637288E7DB26AE458F12FD6BC48B09AFD301F9E761416188E9B6AB28F2A6D2B49344AD00A4BA5201A34BDF293945E208A1688C579665EA854D3EEAD86E5BF14D9DC3ED5412CF781B236FB5B5CDBC5EB7B61BB55FD110E73059D0C99539347D23514D037B758DA1B0A50A209DECFA2200B89D9C732B72EAEF09AED8B2F2AC2D491F4577C28C5608AA72B5ABFD7D8A8F362BC71AABC98F5C7CA0C61B278E983366D6EF24BCD286598AA89620A5DED6CEC4CEECCD0F1929DC5E1C3D589F036B38B67A83401F8A781188D240705AC51D61F55CC4369628A25FD11A5649326A4543440CB664A89A064B3602D3C8345F535FA4B5093489AE86A697F644D3A49135A53BC06B64667B9AC3FAA26E3A409AC29EE8F5DA79FC8EBE81EEF5FC623CC261B5871D0DD6C073360BCCDA238CE06D8B8CF6F02353E0FC4E237F60A18FFBE9784329EF636215411E2D88C50060CF3FA235C868BCB4FEB0DBE1953B8E11696F8B61B7E33DE30DABE293994F39E5CA5925E9DFBA4F3DD949FB5BA1FD62887AFA28A6D956684EDFD35A5389CB00A93F92FC12CF0315BCCCB0A3788F84B9CD222ABC33E3E3C3A961EE6ECCF2319274DBD40735635BD9411C76C0B095AE41925EE134AD474890D1E92D4A04A24FA9A78F8E5CCFE77DEEA340F6AB0BFF2CF07D675FA48FC5F32287848326CFDA6A67F8E9358DFE32947A5E86FEFE28D447F935FFFEB5BD1F4C0BA4B603A9D5A8792A1D7197EF1E5C4206D8AA61B68B3F67B8AF73BDB84A70A5A5469B6ACFF3261E1D3515E25945AFE29442F7F1EAA9AF6E5C146889AD70563E18D6242D3EB8175B08C2F073CF849F39703C33AAB7F49B08E6AC657043E190E26BF21E8BF0C952D77B80F69CE4CDB5892723B77E6606F9490B9EBBD4949D5DE68A2ABE9D803E0464DB9DECC457967A9CCA36D9D9A4CE5D1B077C9FB374F4FDE978CE4DA69DF6D22F236738F5B6E967E5729C77B9024A749FAD97D62F1B6B9660A02EF7976E6B0F4E13D231BDFE6779F24BC6DB29902C47B4EB641A9C07BC6B55DED9F3B665AEF2D74E789BD6A8E92E132471745EE4ADC2D42EE70FC5F444082C2A32CDE5BEA33C54CC26AB21805D655CC42CD296AB26065E22872951AED6287F5956FF8AD9DE575DAC51A123BDB64F3F5BF5536AFD32EDB902EB98B94636DC2A22E0DBC631D6BCBA37A4F29C6424F3A32DABB7CD6D69BF9F794513C8A5184D963B85D7E3F09C4A39864CCA933206158BD2886BDB3F1EF34C2FE9DFAAB1A82FDAB8D04BBC2AE59D5B926CBA8DCBC258DCA2A5284E60653E4C1967A9E507F895C0AC52C009D3F18CF837AEC1A6481BD6B7297D138A3D0651C2E0221E0C59C8036F97956B4A8F3F42E66BFD231BA006AFA2C707F477ECEFCC0ABF4BED2C4840C10CCBBE0E15E369694857D57AF15D26D447A0271F3554ED1030EE300C0D23B3247CF781DDD807E9FF10AB9AF7504D004D23D10A2D9A7173E5A25284C3946DD1E7E0287BDF0E5C7FF0335BF6F58AE540000, N'6.2.0-61023')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'86946c1c-7bc3-4f31-8d74-abc2757bdf5e', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'aabbeb0b-5b0b-4ef9-a214-fc65c892886c', N'Employee')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'f93f4de8-7e5a-4c66-b442-0834372966d7', N'Owner')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'fd26d31a-44bc-49db-8d3b-2f71ae53aac1', N'SysAdmin')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'69efb202-44b2-4f79-813b-b8a71e75793b', N'86946c1c-7bc3-4f31-8d74-abc2757bdf5e')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1e787a2a-71e4-4ae9-9889-6771093153ce', N'aabbeb0b-5b0b-4ef9-a214-fc65c892886c')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1df9ceb8-eb45-471d-9a80-69afe6495f87', N'f93f4de8-7e5a-4c66-b442-0834372966d7')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4575956b-86ea-409e-8889-24278e8a14d1', N'f93f4de8-7e5a-4c66-b442-0834372966d7')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'522f01ca-47b1-4a2f-9533-c8c04baf1daa', N'f93f4de8-7e5a-4c66-b442-0834372966d7')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'188c3be9-1603-4b6d-a279-777d9b175270', N'fd26d31a-44bc-49db-8d3b-2f71ae53aac1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8797a9ed-7c50-4799-8fef-8a3e9c1340d5', N'fd26d31a-44bc-49db-8d3b-2f71ae53aac1')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'188c3be9-1603-4b6d-a279-777d9b175270', N'SysAdmin@test.com', 0, N'AIJrKyIu0kcWe6SSCIs0zOZnWi2E8LBBv2eXkdYQBUEglnP6/UUnb75ZDuJD8Qoiqg==', N'dbf4dac7-3a56-47d5-82de-512c967b4642', NULL, 0, 0, NULL, 1, 0, N'SysAdmin@test.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1df9ceb8-eb45-471d-9a80-69afe6495f87', N'owner2@test.com', 0, N'APf5kYtDEx86B6aQ0as21LEOKYvDh47doRUGu7uQEGCQdCjUmNg+i43UrKsCg7l1KQ==', N'5f9303d6-3134-4962-aaf7-3b63ef0e7fa5', NULL, 0, 0, NULL, 1, 0, N'owner2@test.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1e787a2a-71e4-4ae9-9889-6771093153ce', N'Employee@test.com', 0, N'AC6ZLZuEFqrlEYmkDhp42/FKjVpzHPXXiIY6oZ8FfyVNttlSlMAq4KY2KFzVXUTYWA==', N'a639d2c2-1a2c-4f35-bed6-00c803c2b030', NULL, 0, 0, NULL, 1, 0, N'Employee@test.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'4575956b-86ea-409e-8889-24278e8a14d1', N'Owner@test.com', 0, N'AHjLGQlfmMakxm0vZNOgILIH87aHCuB9/0U+GyxW/8ukgUsLvRindJzRZc3BPBO5Tw==', N'577c06b2-6a8d-4e89-828f-73e37f672408', NULL, 0, 0, NULL, 1, 0, N'Owner@test.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'522f01ca-47b1-4a2f-9533-c8c04baf1daa', N'elvis@presley.com', 0, N'AIzu3UlrPnpwykIKrzk619nkfTyc8BzLD70Eue5Vno/HgUnqxg0GkCXwtJWjy5DgRg==', N'9d778db4-c061-41d9-8111-3d19cfc90bb5', NULL, 0, 0, NULL, 1, 0, N'elvis@presley.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'69efb202-44b2-4f79-813b-b8a71e75793b', N'Admin@test.com', 0, N'AHLVWQiEfPY2jyAOvsljjTOnTgRbwT5RGls4+ap2M5sooDdZBVBJi3hpdCixNGKS8w==', N'a85756c3-d707-440f-98c5-339ff1b06f75', NULL, 0, 0, NULL, 1, 0, N'Admin@test.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'8797a9ed-7c50-4799-8fef-8a3e9c1340d5', N'stacy.toney@protonmail.com', 0, N'AOZx0QxqD5CUbPFMVcvd5ciQWXqYQFJFNQU8z3LWK7GQ6bxW6aR1cMLNs8gCTjHxkw==', N'750a4fed-4795-4322-84ba-df29c0f8570d', NULL, 0, 0, NULL, 1, 0, N'stacy.toney@protonmail.com')
GO
SET IDENTITY_INSERT [dbo].[Events] ON 

INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (1, N'Rodeo Day 2', 1, CAST(N'2021-02-05' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (2, N'Spring Circus', 4, CAST(N'2021-02-05' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (5, N'Balloon Lift Day 2', 5, CAST(N'2021-02-04' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (6, N'Balloon Lift Day 1', 5, CAST(N'2021-02-03' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (7, N'Rodeo Day 3', 1, CAST(N'2021-02-06' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (8, N'Rodeo Day 1', 1, CAST(N'2021-02-04' AS Date), 0, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [LocationID], [EventDate], [IsCancelled], [Notes]) VALUES (9, N'arhafh', 1, CAST(N'2021-02-21' AS Date), 0, NULL)
SET IDENTITY_INSERT [dbo].[Events] OFF
GO
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [LocationName], [Address], [State], [ZipCode], [ReservationLimit]) VALUES (1, N'Shawnee County Stables', N'23 County Line Rd', N'KS', N'66617', 7)
INSERT [dbo].[Locations] ([LocationID], [LocationName], [Address], [State], [ZipCode], [ReservationLimit]) VALUES (4, N'Jackson County Fair Grounds', N'124', N'TN', N'77773', 3)
INSERT [dbo].[Locations] ([LocationID], [LocationName], [Address], [State], [ZipCode], [ReservationLimit]) VALUES (5, N'Prairie Fields Event Center', N'68412 field row', N'MO', N'66633', 5)
SET IDENTITY_INSERT [dbo].[Locations] OFF
GO
SET IDENTITY_INSERT [dbo].[OwnerAssets] ON 

INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (1, N'Soul', 1, N'7a2ed2a4-d56d-4fb8-93ae-30a8aa71649a.jpg', N'1df9ceb8-eb45-471d-9a80-69afe6495f87', N'bladi bladi bladi blah', 1, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (5, N'Eureka Street Food', 3, N'45cfa051-5ca2-4b63-b606-0b852fc14503.jpg', N'4575956b-86ea-409e-8889-24278e8a14d1', NULL, 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (6, N'Vietnamese Street Food', 3, N'973a4596-8081-4b94-b91f-39e5045e79e5.jpg', N'1df9ceb8-eb45-471d-9a80-69afe6495f87', NULL, 0, CAST(N'2021-01-29' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (7, N'Kaffe Dronet', 8, N'7c39394b-549f-4d3d-8544-2f22fb2e0b16.jpg', N'1df9ceb8-eb45-471d-9a80-69afe6495f87', N'Beverages only', 1, CAST(N'2021-01-30' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (8, N'testing', 6, N'd5f76221-5a2b-4587-b931-aec0d5513db6.jpg', N'4575956b-86ea-409e-8889-24278e8a14d1', NULL, 0, CAST(N'2021-01-31' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (9, N'Cookie', 10, NULL, N'188c3be9-1603-4b6d-a279-777d9b175270', NULL, 0, CAST(N'2021-02-02' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (10, N'Cookie', 10, N'4e8a0686-6e57-495f-b247-55c7c0487a4c.jpeg', N'4575956b-86ea-409e-8889-24278e8a14d1', NULL, 1, CAST(N'2021-02-02' AS Date))
INSERT [dbo].[OwnerAssets] ([OwnerAssetID], [TruckName], [TruckFoodTypeID], [TruckPhoto], [OwnerID], [SpecialNotes], [IsActive], [DateAdded]) VALUES (11, N'Popcorn', 6, N'5c2dd392-d9fa-46d6-89e1-7e7efe6dd391.jpg', N'1df9ceb8-eb45-471d-9a80-69afe6495f87', NULL, 0, CAST(N'2021-02-03' AS Date))
SET IDENTITY_INSERT [dbo].[OwnerAssets] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 

INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (1, 5, 2, CAST(N'2021-02-04' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (2, 7, 2, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (3, 1, 2, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (4, 7, 2, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (5, 6, 2, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (6, 5, 2, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (7, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (8, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (9, 5, 6, CAST(N'2021-02-03' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (10, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (11, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (12, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (13, 5, 1, CAST(N'2021-02-05' AS Date))
INSERT [dbo].[Reservations] ([ReservationID], [OwnerAssetID], [EventID], [ReservationDate]) VALUES (14, 5, 1, CAST(N'2021-02-05' AS Date))
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[TruckFoodType] ON 

INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (1, N'Cajun', N'Cajun cuisine is a style of cooking developed by the Cajun - Acadians who were deported from Acadia to Louisiana during the 18th century and who incorporated West African, French and Spanish cooking techniques into their original cuisine. ')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (3, N'Chinese', N'Chinese food staples such as rice, soy sauce, noodles, tea, chili oil and tofu, and utensils such as chopsticks and the wok, can now be found worldwide.')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (4, N'Vietnamese', N'Each Vietnamese dish has a distinctive flavor which reflects one or more of these elements. Common ingredients include shrimp paste, fish sauce, bean sauce, rice, fresh herbs, fruit and vegetables.')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (5, N'Mexican', N'Mexican cuisine is a complex and ancient cuisine with techniques and skills developed over thousands of years. It is created mostly with ingredients native to Mexico & some brought over by the Spanish conquistadors & some new influences since then.')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (6, N'Tex-Mex', N'Tex-Mex cuisine is characterized by its heavy use of shredded cheese, meat (particularly beef, pork and chicken), beans, peppers and spices, in addition to flour tortillas. ')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (7, N'Greek', N'In common with many other cuisines of the Mediterranean, it is founded on the triad of wheat, olive oil, and wine.[3] It uses vegetables, olive oil, grains, fish, and meat, including pork, poultry, veal and beef, lamb, rabbit, and goat.')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (8, N'French', N'French cuisine developed through centuries influenced by the many surrounding cultures of Spain, Italy, Switzerland, Germany & Belgium, & its own food traditions on the long western coastlines of the Atlantic, the Channel and of course inland.')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (10, N'Southern', N'Yum')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (11, N'Snacks', N'Snacks')
INSERT [dbo].[TruckFoodType] ([TruckFoodTypeID], [Cuisine], [Description]) VALUES (12, N'Beverages', N'Beverages')
SET IDENTITY_INSERT [dbo].[TruckFoodType] OFF
GO
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'188c3be9-1603-4b6d-a279-777d9b175270', N'Demo', N'SysAdmin')
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'1df9ceb8-eb45-471d-9a80-69afe6495f87', N'Test2', N'Owner')
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'1e787a2a-71e4-4ae9-9889-6771093153ce', N'Demo', N'Employee')
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'4575956b-86ea-409e-8889-24278e8a14d1', N'Demo', N'Owner')
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'522f01ca-47b1-4a2f-9533-c8c04baf1daa', N'Elvis', N'Presley')
INSERT [dbo].[UserDetails] ([UserID], [FirstName], [LastName]) VALUES (N'69efb202-44b2-4f79-813b-b8a71e75793b', N'Demo', N'Admin')
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
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Locations]
GO
ALTER TABLE [dbo].[OwnerAssets]  WITH CHECK ADD  CONSTRAINT [FK_OwnerAssets_TruckFoodType] FOREIGN KEY([TruckFoodTypeID])
REFERENCES [dbo].[TruckFoodType] ([TruckFoodTypeID])
GO
ALTER TABLE [dbo].[OwnerAssets] CHECK CONSTRAINT [FK_OwnerAssets_TruckFoodType]
GO
ALTER TABLE [dbo].[OwnerAssets]  WITH CHECK ADD  CONSTRAINT [FK_OwnerAssets_UserDetails] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[UserDetails] ([UserID])
GO
ALTER TABLE [dbo].[OwnerAssets] CHECK CONSTRAINT [FK_OwnerAssets_UserDetails]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Events] FOREIGN KEY([EventID])
REFERENCES [dbo].[Events] ([EventID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Events]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_OwnerAssets] FOREIGN KEY([OwnerAssetID])
REFERENCES [dbo].[OwnerAssets] ([OwnerAssetID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_OwnerAssets]
GO
ALTER TABLE [dbo].[UserDetails]  WITH CHECK ADD  CONSTRAINT [FK_UserDetails_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[UserDetails] CHECK CONSTRAINT [FK_UserDetails_AspNetUsers]
GO
