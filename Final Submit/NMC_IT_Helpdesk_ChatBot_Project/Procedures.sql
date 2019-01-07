create Procedure ForUserName(@Email varchar(50), @UserName varChar(50) output)
as
begin 
select @UserName = UserInformation.Name from UserInformation where UserInformation.Email = @Email
end


create Procedure OptionsForChangingWiser
as 
begin
select QnA.Answer from QnA where QnA.Type = 'OptionForChange'
end


alter Procedure ToFetchBotsReply(@IntentName varChar(50), @Type varchar(50), @BotsReply varchar(1024) output)
as
begin
select @BotsReply = QnA.Answer from QnA join Intent on Intent.Id = QnA.IntentId where ( QnA.Type = @Type  )
end 



declare @BotsReply varchar(1024)
exec ToFetchBotsReply 'FootPrintsWiserIssueTicketing', 'EndOfWiser', @BotsReply output
select @BotsReply
select Answer from QnA where QnA.Type='EndOfWiser' 


create Procedure ForConversationLog(@UserId int, @UserReply varchar(50), @BotResponse varchar(50), @Time datetime)
as
begin 
insert into ConversationLog values(@UserId , @UserReply , @BotResponse , @Time)
end


select Id from UserInformation where Name = 'Litesh'


delete from ConversationLog



create procedure ForErrorLog (
@UserId int,
@MethodName varchar(50),
@StackTrace varchar(MAX)
)
as
begin
insert into ErrorLog values (@userId, @MethodName, SYSDATETIME(), @StackTrace)
end

create Procedure OptionsForThingsDoneByBot
as 
begin
select Answer from QnA where Type = 'thingsdonebybot'
end

select Answer from QnA join Intent on Intent.Id = QnA.IntentId where Intent.Name='SmallTalkGreetingHello'



CREATE TABLE [dbo].[Token](
 [TokenNo] [varchar](50) NULL,
 [UserId] [int] NULL,
 [status] [nvarchar](50) NULL,
 [Issue] [varchar](50) NULL,
 [DateOfIssue] [datetime] NULL,
 [ValidatyDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD  CONSTRAINT [FK_Token_UserInformation] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInformation] ([Id])
GO
ALTER TABLE [dbo].[Token] CHECK CONSTRAINT [FK_Token_UserInformation]
GO








select Answer from QnA join Intent on Intent.Id = QnA.IntentId join Entity on Entity.Id = QnA.EntityId where (Intent.Name= 'SelfServiceRequestHardwareType' and Entity.Name='ipad');