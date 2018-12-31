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



create Procedure ToFetchBotsReply(@IntentName varChar(50), @Type varchar(50), @UserReply varchar(50), @BotsReply varchar(50) output)
as
begin
select @BotsReply = QnA.Answer from QnA join Intent on Intent.Id = QnA.IntentId where (QnA.Type = @Type or QnA.Question = @UserReply or Intent.Name=@IntentName)
end 