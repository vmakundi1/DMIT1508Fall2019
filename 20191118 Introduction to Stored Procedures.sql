--1. create a stored procedure called StudentClubCount. it will accept a ClubID as a parameter. if the count of students in that club is greater that 2, print 'a successful club. if the count is not greater than 2, print 'Needs more members!'
go
alter Procedure StudentClubCount (@ClubID varchar (10) = null)
as
if @ClubID is null
      begin
	  --print 'Must provide a clubID'
	  raiserror ('must provide a ClubID', 16, 1)
	  end
else
      begin
	  declare @Count int
	  select @Count = COUNT(*) from activity where ClubID = @ClubID
	  if @Count > 2
	       Begin
		   Print 'A successfull club'
		   End
	  else
	       Begin
		   Print 'Needs more members!'
		   end
	  end
Return

--2. Create a stored procedure called BalanceOrNoBalance. it will accept a studentID as a parameter. each course has a cost
--if the total of the costs for the courses the student is registered in is more than the total of the payments that the student has made, then
--print 'Balance owing' otherwise print 'Paid in full. welcome to school'
go
alter procedure BalanceOrNoBalance (@StudentID int = null)
as
if @StudentID is null
        begin
		print 'must provide a student ID'
		end
else
        begin
		declare @fees decimal (6,2), @Payments money
		select @fees = SUM(CourseCost) from Course inner join Offering on Course.CourseID = Offering.CourseID inner join Registration on Offering.OfferingCode = Registration.OfferingCode