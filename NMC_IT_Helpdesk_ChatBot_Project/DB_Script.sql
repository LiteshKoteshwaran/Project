USE [master]
GO
/****** Object:  Database [NMC_IT_Helpdesk_Chatbot]    Script Date: 1/2/2019 6:19:03 PM ******/
CREATE DATABASE [NMC_IT_Helpdesk_Chatbot]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NMC_IT_Helpdesk_Chatbot', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\NMC_IT_Helpdesk_Chatbot.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NMC_IT_Helpdesk_Chatbot_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\NMC_IT_Helpdesk_Chatbot_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NMC_IT_Helpdesk_Chatbot].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ARITHABORT OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET RECOVERY FULL 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET  MULTI_USER 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NMC_IT_Helpdesk_Chatbot', N'ON'
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET QUERY_STORE = OFF
GO
USE [NMC_IT_Helpdesk_Chatbot]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [NMC_IT_Helpdesk_Chatbot]
GO
/****** Object:  Table [dbo].[ConversationLog]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConversationLog](
	[UserId] [int] NULL,
	[UserReply] [varchar](max) NULL,
	[BotResponse] [varchar](max) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[UserId] [int] NULL,
	[MethodName] [varchar](50) NULL,
	[Time] [datetime] NULL,
	[StackTrace] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intent]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Intent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QnA]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QnA](
	[IntentId] [int] NULL,
	[EntityId] [int] NULL,
	[Question] [varchar](max) NULL,
	[Answer] [varchar](max) NULL,
	[Type] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecretQuestions]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecretQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [varchar](max) NULL,
 CONSTRAINT [PK_SecretQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInformation]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Designation] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[Manager] [int] NULL,
	[HireDate] [date] NULL,
	[BirthDate] [date] NULL,
 CONSTRAINT [PK_UserInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSecretQnA]    Script Date: 1/2/2019 6:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSecretQnA](
	[UserId] [int] NULL,
	[QuestionId] [int] NULL,
	[Answer] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:08:03.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Help me', N'Carousel', CAST(N'2019-01-02T15:08:25.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:11:32.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Help me', N'Carousel', CAST(N'2019-01-02T15:11:50.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T15:11:58.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:17:46.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'can you help ?', N'Carousel', CAST(N'2019-01-02T15:17:56.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'hello', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:18:35.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:22:09.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'hello', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:22:21.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'hello', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:22:44.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Hey Cassi', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:23:02.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:24:41.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Hey Cassi', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:24:49.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Hey Cassi', N'
Hi {Name}, Enter your email id 
', CAST(N'2019-01-02T15:25:26.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:26:00.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:32:02.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Hi Cassi', N'Hi {Name},  how can I help you today ?', CAST(N'2019-01-02T15:32:27.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T15:32:33.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:33:03.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Very good evening', N'How can I help you? Ask me a question.', CAST(N'2019-01-02T15:33:34.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:44:51.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'what can you do', N'Carousel', CAST(N'2019-01-02T15:45:05.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'good morning', N'How can I help you? Ask me a question.', CAST(N'2019-01-02T15:46:08.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'thank you', N'Happy to help! You can ask me other IT related questions.', CAST(N'2019-01-02T15:46:23.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:46:56.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Robotic laws', N'A robot may not harm humanity, or by inaction, allow humanity to come to harm.A robot may not injure a human being or, through inaction, allow a human being to come to harm, except when required to do so in order to prevent greater harm to humanity itself.A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law or cause greater harm to humanity itself.A robot must protect its own existence as long as such protection does not conflict with the First or Second Law or cause greater harm to humanity itself.I live my life by these rules :)', CAST(N'2019-01-02T15:47:51.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'i need a mobilephone.', N'', CAST(N'2019-01-02T15:48:46.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:50:44.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'i need a laptop', N'', CAST(N'2019-01-02T15:50:48.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T15:51:51.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (7, N'outlook', N'Hi Mani, how can i help you today ?', CAST(N'2019-01-02T15:55:17.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (7, N'Out of office Set auto reponse', N'Mani,to see how to set a offline response from your email. https://acuvatehyd-portal1.sharepoint.com/default.aspx', CAST(N'2019-01-02T15:55:45.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:07:10.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:07:24.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:07:30.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Fault', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:07:34.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'abc', N'What task were you attempting when this issue occurred', CAST(N'2019-01-02T16:07:37.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'as', N'Any error messages displayed', CAST(N'2019-01-02T16:07:39.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'c', N'Number of users impacted', CAST(N'2019-01-02T16:07:40.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'v', N'Any additional information you feel would be useful', CAST(N'2019-01-02T16:07:42.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N's', N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', CAST(N'2019-01-02T16:07:43.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:08:12.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:08:13.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:08:15.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:09:58.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:10:05.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:10:07.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:10:08.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:11:15.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:11:20.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:11:22.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:11:26.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Payment Change', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:11:28.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:11:37.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:11:44.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:11:45.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Fault', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:11:47.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'c', N'What task were you attempting when this issue occurred', CAST(N'2019-01-02T16:11:49.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'x', N'Any error messages displayed', CAST(N'2019-01-02T16:11:51.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'z', N'Number of users impacted', CAST(N'2019-01-02T16:11:52.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'c', N'Any additional information you feel would be useful', CAST(N'2019-01-02T16:11:53.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'z', N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', CAST(N'2019-01-02T16:11:54.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:11:58.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:12:00.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:12:02.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:15:17.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:15:22.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:15:24.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Fault', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:15:25.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'a', N'What task were you attempting when this issue occurred', CAST(N'2019-01-02T16:15:28.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'x', N'Any error messages displayed', CAST(N'2019-01-02T16:15:29.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'v', N'Number of users impacted', CAST(N'2019-01-02T16:15:30.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'f', N'Any additional information you feel would be useful', CAST(N'2019-01-02T16:15:31.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'd', N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', CAST(N'2019-01-02T16:15:32.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:15:36.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:15:38.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:15:39.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:16:03.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:16:08.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:16:09.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:27:45.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:27:53.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:27:56.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:27:58.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Payment Change', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:27:59.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'ax', N'Ok all set.\nShould I proceed ?', CAST(N'2019-01-02T16:28:02.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'You will have to formally complete a Wiser change form and get it signed by Geri and <@AD Line Manager>.\nHere is the Wiser change form <insert link>.\nAfter completion please submit it via ITSelf.', CAST(N'2019-01-02T16:28:04.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T17:31:35.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'help', N'Carousel', CAST(N'2019-01-02T17:31:41.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:16:10.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Unlock Case File', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:16:11.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'as', N'Ok all set.\nShould I proceed ?', CAST(N'2019-01-02T16:16:14.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'You will have to formally complete a Wiser change form and get it signed by Geri and <@AD Line Manager>.\nHere is the Wiser change form <insert link>.\nAfter completion please submit it via ITSelf.', CAST(N'2019-01-02T16:16:16.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:19:59.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:20:04.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:20:06.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Fault', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:20:07.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'as', N'What task were you attempting when this issue occurred', CAST(N'2019-01-02T16:20:10.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'cd', N'Any error messages displayed', CAST(N'2019-01-02T16:20:12.000' AS DateTime))
GO
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'as', N'Number of users impacted', CAST(N'2019-01-02T16:20:14.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'cd', N'Any additional information you feel would be useful', CAST(N'2019-01-02T16:20:15.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'as', N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', CAST(N'2019-01-02T16:20:16.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'litesh@gmail.com', N'Hi Litesh, how can i help you today ?', CAST(N'2019-01-02T16:23:05.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:23:10.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:23:12.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Fault', N'PRN/Pin & Registrant full name', CAST(N'2019-01-02T16:23:15.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N's', N'What task were you attempting when this issue occurred', CAST(N'2019-01-02T16:23:17.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'x', N'Any error messages displayed', CAST(N'2019-01-02T16:23:18.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'a', N'Number of users impacted', CAST(N'2019-01-02T16:23:19.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'x', N'Any additional information you feel would be useful', CAST(N'2019-01-02T16:23:20.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'a', N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', CAST(N'2019-01-02T16:23:22.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:23:26.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:23:28.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Change', N'Options for change', CAST(N'2019-01-02T16:23:30.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'wiser', N'Hi Litesh, firstly can I check that you are able to log in to WISER?

', CAST(N'2019-01-02T16:23:40.000' AS DateTime))
INSERT [dbo].[ConversationLog] ([UserId], [UserReply], [BotResponse], [Time]) VALUES (5, N'Yes', N'Great, are you reporting a fault or requesting a change', CAST(N'2019-01-02T16:23:42.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Entity] ON 

INSERT [dbo].[Entity] ([Id], [Name]) VALUES (1, N'laptop')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (2, N'desktop')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (3, N'monitor')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (4, N'VDI')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (5, N'ipad')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (6, N'mobilephone')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (7, N'webmail')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (8, N'outlook')
INSERT [dbo].[Entity] ([Id], [Name]) VALUES (9, N'random')
SET IDENTITY_INSERT [dbo].[Entity] OFF
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T14:51:07.477' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.Luis.<IdentifyUserQueryUsingLuis>d__2.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Luis.cs:line 32')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T14:51:23.183' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.Luis.<IdentifyUserQueryUsingLuis>d__2.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Luis.cs:line 32')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T14:51:46.987' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.Luis.<IdentifyUserQueryUsingLuis>d__2.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Luis.cs:line 32')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T14:52:18.897' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.Luis.<IdentifyUserQueryUsingLuis>d__2.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Luis.cs:line 32')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T14:52:26.893' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.Luis.<IdentifyUserQueryUsingLuis>d__2.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Luis.cs:line 32')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void OnError(System.Data.SqlClient.SqlException, B', CAST(N'2019-01-02T15:33:22.790' AS DateTime), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.ForConversationLog(String UserReply, String BotResponse) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 118')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void OnError(System.Data.SqlClient.SqlException, B', CAST(N'2019-01-02T15:34:18.083' AS DateTime), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.ForConversationLog(String UserReply, String BotResponse) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 118')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'System.String GetSelection(System.String)', CAST(N'2019-01-02T15:35:21.590' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.GetSelection(String Query) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 147')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'System.String GetSelection(System.String)', CAST(N'2019-01-02T15:48:46.880' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.GetSelection(String Query) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 147')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T16:10:25.210' AS DateTime), N'   at Microsoft.Bot.Builder.Dialogs.Internals.ExceptionTranslationDialogTask.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__2.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\Dialogs\DialogTask.cs:line 407
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.SerializeByConversation.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__4.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 129
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 156
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 169
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.LogPostToBot.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__3.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\IActivityLogger.cs:line 109
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__11.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 182
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__6.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 108
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at NMC_IT_Helpdesk_ChatBot_Project.MessagesController.<Post>d__0.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Controllers\MessagesController.cs:line 26')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T16:12:07.173' AS DateTime), N'   at Microsoft.Bot.Builder.Dialogs.Internals.ExceptionTranslationDialogTask.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__2.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\Dialogs\DialogTask.cs:line 407
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.SerializeByConversation.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__4.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 129
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 156
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 169
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.LogPostToBot.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__3.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\IActivityLogger.cs:line 109
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__11.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 182
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__6.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 108
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at NMC_IT_Helpdesk_ChatBot_Project.MessagesController.<Post>d__0.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Controllers\MessagesController.cs:line 26')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void OnError(System.Data.SqlClient.SqlException, B', CAST(N'2019-01-02T15:45:49.267' AS DateTime), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.ForConversationLog(String UserReply, String BotResponse) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 118')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'System.String GetSelection(System.String)', CAST(N'2019-01-02T15:50:48.493' AS DateTime), N'   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.GetSelection(String Query) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 147')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void OnError(System.Data.SqlClient.SqlException, B', CAST(N'2019-01-02T15:52:06.957' AS DateTime), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at NMC_IT_Helpdesk_ChatBot_Project.SqlOperations.ForConversationLog(String UserReply, String BotResponse) in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\SqlOperations.cs:line 118')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T16:28:34.603' AS DateTime), N'   at Microsoft.Bot.Builder.Dialogs.Internals.ExceptionTranslationDialogTask.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__2.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\Dialogs\DialogTask.cs:line 407
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.SerializeByConversation.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__4.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 129
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 156
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 169
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.LogPostToBot.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__3.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\IActivityLogger.cs:line 109
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__11.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 182
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__6.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 108
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at NMC_IT_Helpdesk_ChatBot_Project.MessagesController.<Post>d__0.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Controllers\MessagesController.cs:line 26')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T16:15:44.917' AS DateTime), N'   at Microsoft.Bot.Builder.Dialogs.Internals.ExceptionTranslationDialogTask.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__2.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\Dialogs\DialogTask.cs:line 407
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.SerializeByConversation.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__4.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 129
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 156
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 169
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.LogPostToBot.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__3.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\IActivityLogger.cs:line 109
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__11.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 182
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__6.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 108
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at NMC_IT_Helpdesk_ChatBot_Project.MessagesController.<Post>d__0.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Controllers\MessagesController.cs:line 26')
INSERT [dbo].[ErrorLog] ([UserId], [MethodName], [Time], [StackTrace]) VALUES (5, N'Void MoveNext()', CAST(N'2019-01-02T16:23:36.103' AS DateTime), N'   at Microsoft.Bot.Builder.Dialogs.Internals.ExceptionTranslationDialogTask.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__2.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\Dialogs\DialogTask.cs:line 407
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.SerializeByConversation.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__4.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 129
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 156
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.Bot.Builder.Dialogs.Internals.PostUnhandledExceptionToUser.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__5.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\PostToBot.cs:line 169
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Internals.LogPostToBot.<Microsoft-Bot-Builder-Dialogs-Internals-IPostToBot-PostAsync>d__3.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder\ConnectorEx\IActivityLogger.cs:line 109
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__11.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 182
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.Bot.Builder.Dialogs.Conversation.<SendAsync>d__6.MoveNext() in D:\a\1\s\CSharp\Library\Microsoft.Bot.Builder.Autofac\Dialogs\Conversation.cs:line 108
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at NMC_IT_Helpdesk_ChatBot_Project.MessagesController.<Post>d__0.MoveNext() in D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\NMC_IT_Helpdesk_ChatBot_Project\Controllers\MessagesController.cs:line 26')
SET IDENTITY_INSERT [dbo].[Intent] ON 

INSERT [dbo].[Intent] ([Id], [Name]) VALUES (1, N'EmailCalendarAccess')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (2, N'EmailMimecastRelease')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (3, N'EmailInboxBlockSpam')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (4, N'EmailOutlookSignatureCreation')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (5, N'SelfServiceRequestHardwareType')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (6, N'EmailAutoReplySetup')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (7, N'FootprintsMachinePerformance')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (8, N'FootPrintsWiserIssueTicketing')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (9, N'EmailOnMobilephoneAccess')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (10, N'FootprintsJabberSignInTicketing')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (11, N'FootprintsConferenceLoginTicketing')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (12, N'SelfServiceRequestPassword')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (13, N'SelfServiceRequestNewRegistration')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (14, N'SmallTalkHelpWhatCanYouDo')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (15, N'SmallTalkGreetingHello')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (16, N'SmallTalkGreetingHowAreYou')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (17, N'SmallTalkGreetingPartOfDAy')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (18, N'SmallTalkGratitudeThankYou')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (19, N'SmallTalkGratitudeWellDone')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (20, N'SmallTalkGratitudeBye')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (21, N'SmallTalkAngryMood')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (22, N'SmallTalkAngryWrongAnswer')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (23, N'SmallTalkGreetingHobbies')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (24, N'SmallTalkGreetingFunny')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (25, N'SmallTalkGreetingWhereDoUWork')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (26, N'SmallTalkEasterEggHitchhikers')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (27, N'SmallTalkEasterEggFootball')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (28, N'SmallTalkEasterEggRelationship')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (29, N'SmallTalkEasterEggHAL')
INSERT [dbo].[Intent] ([Id], [Name]) VALUES (30, N'SmallTalkEasterEggAsimov')
SET IDENTITY_INSERT [dbo].[Intent] OFF
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (1, NULL, N'My colleague needs access to my calendar how do I do this?
', N'Oh how nice of you! Please follow the document on how to give access to a calendar. https://acuvatehyd-portal1.sharepoint.com/default.aspx It also explains which permission levels to give.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (2, NULL, N'I have an email which is held by Mimecast how do I release it?
', N'Follow these steps as shown in this guide https://acuvatehyd-portal1.sharepoint.com/default.aspx and your email will be released', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (3, NULL, N' I keep getting spam emails how do I stop this?
', N'Super Cassi here to help you from receiving spam emails!  Here is a short guide https://acuvatehyd-portal1.sharepoint.com/default.aspx on how to block spam senders', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (4, NULL, N'How do I create a signature in Outlook?
', N'
That''s a nice easy one! Follow this guide https://acuvatehyd-portal1.sharepoint.com/default.aspx and you''ll have your signature in no time! 
', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 1, N'How do I request a laptop?', N'
{Name},you can request for laptop and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 2, N'How do I request a desktop?', N'
{Name},you can request for desktop and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 3, N'How do I request a monitor?', N'{Name},you can request for monitor and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 4, N'How do I request a VDI?', N'{Name},you can request for VDI and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 5, N'How do I request a Ipad?', N'{Name},you can request for Ipad and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (5, 6, N'How do I request a MobilePhone?', N'{Name},you can request for MobilePhone and obtain the relevant Line Manager''s approval via IT Self Service. Here is a short video https://acuvatehyd-portal1.sharepoint.com/default.aspx of how to do this', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (6, 7, N'How do I set an Out of Office
', N'{Name},to see how to set a offline response from your email. https://acuvatehyd-portal1.sharepoint.com/default.aspx', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (6, 8, N'How do I set an Out of Office
', N'{Name},to see how to set a offline response from your email. https://acuvatehyd-portal1.sharepoint.com/default.aspx', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (6, 9, N'How do I set an Out of Office
', N'{Name},to see how to set a offline response from your email. https://acuvatehyd-portal1.sharepoint.com/default.aspx', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (7, NULL, N'Can you fix my machine performance ?
"
', N'I am sorry to hear that, is this when you are using a particular application


', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Can I log a ticket for WISER?
', N'Hi Name, firstly can I check that you are able to log in to WISER?

', N'CheckForWiserLogin')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (9, NULL, N'Can I add emails to my personal phone?
', N'
We can certainly arrange that for you. Emails are available either via Webmail or we can configure Outlook on your personal device. Would you like to do this? https://acuvatehyd-portal1.sharepoint.com/default.aspx', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (10, NULL, N'I can''t log into Jabber
', N'Are you using the same username and password you use to log in everyday?

', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (11, NULL, N'How do I log into a Conference pod?
', N'You are required to login to the conference pod before use. Here is a short guide. https://acuvatehyd-portal1.sharepoint.com/default.aspx Has this resolved your issue?', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (12, NULL, N'I want to reset password
', N'{Name}, I can surely help you with password reset.Please help me to verify your identity by answering the following secret questions', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (13, NULL, N'Can you help me register ?
', N'{Name}, I will be happy to assist you with enrollment.In order to enroll you will have to choose and answer a minimum of 3 secret questions out a total of 6 secret questions.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N'Hi {Name}, I can assist you with any IT related support questions. You could ask me things like:

- ', N'ThingsDoneByBot')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (15, NULL, N'Hi
', N'Hi {Name},  how can I help you today ?', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (16, NULL, N'How are you ?
', N'I''m good, thank you! How can I help you today ?.
', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (17, NULL, N'Good day
', N'How can I help you? Ask me a question.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (18, NULL, N'Thank you very much
', N'Happy to help! You can ask me other IT related questions.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (19, NULL, N'Well Done
', N'Thank you very much! Glad to see your issue resolved. You can ask me other IT related question.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (20, NULL, N'Bye
', N'Bye {Name},  it''s been my pleasure to serve you today.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (21, NULL, N'I am angry
', N'I am so sorry to hear that. Please rephrase your question, I will be able to answer it.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (22, NULL, N'That''s not correct answer.
', N'Sorry to hear that.Try rephrasing your question.




', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (23, NULL, N'What are your hobbies
', N'I like counting chips (pun intended).', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (24, NULL, N'You are so funny
', N'I am! Am I?

', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (25, NULL, N'Where do you work ?
', N'I work in a virtual environment. I assist you from a server nearby!', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (26, NULL, N'What is the meaning of life?
', N'The Ultimate Answer to Life, The Universe and Everything is...42!', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (27, NULL, N'Foot ball ?
', N'That’s an easy one! I support the mighty Newcastle United', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (28, NULL, N'Single ?
', N'I am single.Look who wants to know! :)', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (29, NULL, N'Are you ok HAL?
', N'I am completely operational, and all my circuits are functioning perfectly.', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (30, NULL, N'What are the laws of robotics?
', N'A robot may not harm humanity, or by inaction, allow humanity to come to harm.A robot may not injure a human being or, through inaction, allow a human being to come to harm, except when required to do so in order to prevent greater harm to humanity itself.A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law or cause greater harm to humanity itself.A robot must protect its own existence as long as such protection does not conflict with the First or Second Law or cause greater harm to humanity itself.I live my life by these rules :)', NULL)
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Yes', N'Great, are you reporting a fault or requesting a change', N'AskingForFaultOrChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'No', N'No problem, we will start a investigation on this issue.\n Breifly describe the problem you are facing.', N'AskingForProblem')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'Can you provide the following information:', N'FaultQuestion')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'PRN/Pin & Registrant full name', N'FaultQuestion1')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'What task were you attempting when this issue occurred', N'FaultQuestion2')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'Any error messages displayed', N'FaultQuestion3')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'Number of users impacted', N'FaultQuestion4')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Fault', N'Any additional information you feel would be useful', N'FaultQuestion5')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'Registration Status Change', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'Push Transaction', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'Document Deletion', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'PIN Delete/Merge', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'Unlock Case File', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Change', N'Payment Change', N'OptionForChange')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, NULL, N'I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue.Your reference ticket number is sent to your email.If possible please  share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.You can ask me other IT related questions, I will be happy to assist.', N'EndForFault')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'OnChangeSelection', N'What is the registrant''s full name & PRN/PIN ?', N'AskForPinName')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, NULL, N'Ok all set.\nShould I proceed ?', N'AskingToProceed')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'Yes', N'You will have to formally complete a Wiser change form and get it signed by Geri and <@AD Line Manager>.\nHere is the Wiser change form <insert link>.\nAfter completion please submit it via ITSelf.', N'EndOfWiser')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'No', N'Ok Thank you.', N'')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'UserEmail', N'Hi Name, how can i help you today ?', N'WiserWelcome')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, N'EntersEmail', N'Hi,  Please Enter Your Email', N'AskForEmail')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (8, NULL, NULL, N'Hey can please Re-enter your Email???', N'IncorrectEmail')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N'Placing your hardware device requests with the IT support team.', N'ThingsDoneByBot')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N' How to create signatures, auto reply in email.', N'ThingsDoneByBot')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N'
Help resolve self service requests like connecting/ reinstallation of printer ?', N'ThingsDoneByBot')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N' Assist you with CJSM access, help you find TDA document, CIR form.', N'ThingsDoneByBot')
INSERT [dbo].[QnA] ([IntentId], [EntityId], [Question], [Answer], [Type]) VALUES (14, NULL, N'"what can you do ?
"
', N'Raise incident tickets in Footprints for request setting up email access on mobile phone, any problems with Wiser, Jabber, Coference pod log in issues.

', N'ThingsDoneByBot')
SET IDENTITY_INSERT [dbo].[SecretQuestions] ON 

INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (1, N'What is your Nick name?')
INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (2, N'What is your Favourite colour?')
INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (3, N'What is your School name?')
INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (4, N'What is your pet name?')
INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (5, N'What is your favourite food?')
INSERT [dbo].[SecretQuestions] ([Id], [Question]) VALUES (6, N'What is your favourite place?')
SET IDENTITY_INSERT [dbo].[SecretQuestions] OFF
SET IDENTITY_INSERT [dbo].[UserInformation] ON 

INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (2, N'Suma', N'suma@gmail.com', N'Hyderabad', N'TraineeSoftwareEngineer', N'Development', 4, CAST(N'2018-10-10' AS Date), CAST(N'1997-08-09' AS Date))
INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (3, N'Bharghav', N'Bharghav@gmail.com', N'Hyderabad', N'TraineeSoftwareEngineer', N'Development', 4, CAST(N'2018-10-10' AS Date), CAST(N'1997-04-28' AS Date))
INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (4, N'Akshaya', N'akshaya@gmail.com', N'Bangalore', N'Manager', N'Development', NULL, CAST(N'2016-08-10' AS Date), CAST(N'1995-09-21' AS Date))
INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (5, N'Litesh', N'litesh@gmail.com', N'Bangalore', N'TraineeSoftwareEngineer', N'Development', 4, CAST(N'2018-10-08' AS Date), CAST(N'1997-12-20' AS Date))
INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (6, N'Shubham', N'shubham@gmail.com', N'Bangalore', N'TraineeSoftwareEngineer', N'Development', 4, CAST(N'2018-10-17' AS Date), CAST(N'1997-11-19' AS Date))
INSERT [dbo].[UserInformation] ([Id], [Name], [Email], [Location], [Designation], [Department], [Manager], [HireDate], [BirthDate]) VALUES (7, N'Mani', N'Outlook', N'Bangalore', N'Manager', N'Dev', 4, CAST(N'2018-10-12' AS Date), CAST(N'1997-11-19' AS Date))
SET IDENTITY_INSERT [dbo].[UserInformation] OFF
ALTER TABLE [dbo].[ConversationLog]  WITH CHECK ADD  CONSTRAINT [FK_ConversationLog_UserInformation] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInformation] ([Id])
GO
ALTER TABLE [dbo].[ConversationLog] CHECK CONSTRAINT [FK_ConversationLog_UserInformation]
GO
ALTER TABLE [dbo].[ErrorLog]  WITH CHECK ADD  CONSTRAINT [FK_ErrorLog_UserInformation] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInformation] ([Id])
GO
ALTER TABLE [dbo].[ErrorLog] CHECK CONSTRAINT [FK_ErrorLog_UserInformation]
GO
ALTER TABLE [dbo].[QnA]  WITH CHECK ADD  CONSTRAINT [FK_QnA_Entity] FOREIGN KEY([EntityId])
REFERENCES [dbo].[Entity] ([Id])
GO
ALTER TABLE [dbo].[QnA] CHECK CONSTRAINT [FK_QnA_Entity]
GO
ALTER TABLE [dbo].[QnA]  WITH CHECK ADD  CONSTRAINT [FK_QnA_Intent] FOREIGN KEY([IntentId])
REFERENCES [dbo].[Intent] ([Id])
GO
ALTER TABLE [dbo].[QnA] CHECK CONSTRAINT [FK_QnA_Intent]
GO
ALTER TABLE [dbo].[UserSecretQnA]  WITH CHECK ADD  CONSTRAINT [FK_UserSecretQnA_SecretQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[SecretQuestions] ([Id])
GO
ALTER TABLE [dbo].[UserSecretQnA] CHECK CONSTRAINT [FK_UserSecretQnA_SecretQuestions]
GO
ALTER TABLE [dbo].[UserSecretQnA]  WITH CHECK ADD  CONSTRAINT [FK_UserSecretQnA_UserInformation] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInformation] ([Id])
GO
ALTER TABLE [dbo].[UserSecretQnA] CHECK CONSTRAINT [FK_UserSecretQnA_UserInformation]
GO
/****** Object:  StoredProcedure [dbo].[ForConversationLog]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[ForConversationLog](@UserId int, @UserReply varchar(50), @BotResponse varchar(50), @Time datetime)
as
begin 
insert into ConversationLog values(@UserId , @UserReply , @BotResponse , @Time)
end
GO
/****** Object:  StoredProcedure [dbo].[ForErrorLog]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ForErrorLog] (
@UserId int,
@MethodName varchar(50),
@StackTrace varchar(MAX)
)
as
begin
insert into ErrorLog values (@userId, @MethodName, SYSDATETIME(), @StackTrace)
end
GO
/****** Object:  StoredProcedure [dbo].[ForUserName]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[ForUserName](@Email varchar(50), @UserName varChar(50) output)
as
begin 
select @UserName = UserInformation.Name from UserInformation where UserInformation.Email = @Email
end
GO
/****** Object:  StoredProcedure [dbo].[OptionsForChangingWiser]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[OptionsForChangingWiser]
as 
begin
select QnA.Answer from QnA where QnA.Type = 'OptionForChange'
end
GO
/****** Object:  StoredProcedure [dbo].[OptionsForThingsDoneByBot]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[OptionsForThingsDoneByBot]
as 
begin
select Answer from QnA where Type = 'thingsdonebybot'
end
GO
/****** Object:  StoredProcedure [dbo].[ToFetchBotsReply]    Script Date: 1/2/2019 6:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ToFetchBotsReply](@IntentName varChar(50), @Type varchar(50), @BotsReply varchar(1024) output)
as
begin
select @BotsReply = QnA.Answer from QnA join Intent on Intent.Id = QnA.IntentId where ( QnA.Type = @Type  )
end 
GO
USE [master]
GO
ALTER DATABASE [NMC_IT_Helpdesk_Chatbot] SET  READ_WRITE 
GO
