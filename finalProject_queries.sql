/* 6 */
create view xReportsByModel as
select xxModel.ModelNumber,
	   count (*) ProblemReportReportId
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
group by xxModel.ModelNumber

select *
from xReportsByModel

create view xInjuryReportByModel as
select xxModel.ModelNumber,
	   count (*) Injury
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
where Injury like '%yes%'
group by xxModel.ModelNumber

select *
from xInjuryReportByModel

create view xCountOfTestsByModel as
select xxModel.ModelNumber,
	   count (*) TestId
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
right join xxTestForm
on xxProblemReport.ProblemReportReportId = xxTestForm.ProblemReportReportId
group by xxModel.ModelNumber

select *
from xCountOfTestsByModel

create view xMostRecentReportdate as
select xxModel.ModelNumber,
	   max(xxProblemReport.ReportDate) 'MostRecentReportDate'
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
group by xxModel.ModelNumber

select *
from xMostRecentReportdate

create view xEarliestReportdate as
select xxModel.ModelNumber,
	   min(xxProblemReport.ReportDate) 'EarliestReportDate'
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
group by xxModel.ModelNumber

select *
from xEarliestReportdate

create view xMostRecentTestdate as
select xxModel.ModelNumber,
	   max(xxTestForm.TestDate) 'MostRecentTestDate'
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
right join xxTestForm
on xxProblemReport.ProblemReportReportId = xxTestForm.ProblemReportReportId
group by xxModel.ModelNumber

select *
from xMostRecentTestdate

create view xEarliestTestdate as
select xxModel.ModelNumber,
	   min(xxTestForm.TestDate) 'EarliestTestDate'
from xxModel
right join xxItem
on xxModel.ModelNumber = xxItem.ToyModel
right join xxProblemReport
on xxItem.Serialid = xxProblemReport.SerialNumber
right join xxTestForm
on xxProblemReport.ProblemReportReportId = xxTestForm.ProblemReportReportId
group by xxModel.ModelNumber

select *
from xEarliestTestdate


select xxModel.ModelNumber,
	   xxModel.ModelDescription,
	   isnull(xReportsByModel.ProblemReportReportId,0) 'CountOfReports',
	   isnull(xInjuryReportByModel.Injury,0) 'CountofInjuryReports',
	   isnull(convert(varchar, xMostRecentReportdate.MostRecentReportDate, 107),'n\a') 'MostRecentReportDate',
	   isnull(convert(varchar, xEarliestReportdate.EarliestReportDate, 107),'n\a') 'EarliestReportDate',
	   isnull(xCountOfTestsByModel.TestId,0) 'CountOfTests',
	   isnull(convert(varchar, xMostRecentTestdate.MostRecentTestDate, 107),'n\a') 'MostRecentTestDate',
	   isnull(convert(varchar, xEarliestTestdate.EarliestTestDate, 107), 'n\a') 'EarliestTestDate'
	  


from xxModel
left join xReportsByModel
on xxModel.ModelNumber = xReportsByModel.ModelNumber
left join xInjuryReportByModel
on xxModel.ModelNumber = xInjuryReportByModel.ModelNumber
left join xMostRecentReportdate
on xxModel.ModelNumber = xMostRecentReportdate.ModelNumber
left join xEarliestReportdate
on xxModel.ModelNumber = xEarliestReportdate.ModelNumber
left join xCountOfTestsByModel
on xxModel.ModelNumber = xCountOfTestsByModel.ModelNumber
left join xMostRecentTestdate
on xxModel.ModelNumber = xMostRecentTestdate.ModelNumber
left join xEarliestTestdate
on xxModel.ModelNumber = xEarliestTestdate.ModelNumber


/* 7 */
select xxModel.ModelNumber,
	   xxModel.ModelDescription,
	   isnull(xReportsByModel.ProblemReportReportId,0) 'CountOfReports',
	   isnull(xInjuryReportByModel.Injury,0) 'CountofInjuryReports',
	   isnull(convert(varchar, xMostRecentReportdate.MostRecentReportDate, 107),'n\a') 'MostRecentReportDate',
	   isnull(convert(varchar, xEarliestReportdate.EarliestReportDate, 107),'n\a') 'EarliestReportDate',
	   isnull(xCountOfTestsByModel.TestId,0) 'CountOfTests',
	   isnull(convert(varchar, xMostRecentTestdate.MostRecentTestDate, 107),'n\a') 'MostRecentTestDate',
	   isnull(convert(varchar, xEarliestTestdate.EarliestTestDate, 107), 'n\a') 'EarliestTestDate'
	  


from xxModel
left join xReportsByModel
on xxModel.ModelNumber = xReportsByModel.ModelNumber
left join xInjuryReportByModel
on xxModel.ModelNumber = xInjuryReportByModel.ModelNumber
left join xMostRecentReportdate
on xxModel.ModelNumber = xMostRecentReportdate.ModelNumber
left join xEarliestReportdate
on xxModel.ModelNumber = xEarliestReportdate.ModelNumber
left join xCountOfTestsByModel
on xxModel.ModelNumber = xCountOfTestsByModel.ModelNumber
left join xMostRecentTestdate
on xxModel.ModelNumber = xMostRecentTestdate.ModelNumber
left join xEarliestTestdate
on xxModel.ModelNumber = xEarliestTestdate.ModelNumber
where ProblemReportReportId = (select max(ProblemReportReportId) from xReportsByModel)
