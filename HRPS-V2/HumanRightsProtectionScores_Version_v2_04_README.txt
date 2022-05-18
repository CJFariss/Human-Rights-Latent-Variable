# -------------------------------------------------- #
# HumanRightsProtectionScores_Version2_README.txt
# -------------------------------------------------- #

 File Date: 2015-02-22

 Author: Christopher Fariss

 Title: "Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability"

 Contact: Chris Fariss: cjf0006@gmail.com
 All inquires about the models and code should be sent to Chris Fariss 

 Copyright (c) 2014, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
 For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
 All rights reserved. 


# -------------------------------------------------- #
# INFORMATION ABOUT THIS FILE: 
# -------------------------------------------------- #

This README file provides a information about the data contained in the following file (1949-2013):

CYLatentRepressionDynamicStandardDynamicX_v2.04.csv


This new datafile replicates and extends the latent variable estimates contained in this file (1949-2010):

CYLatentRepressionDynamicStandardDynamicX_v2.03.csv


# -------------------------------------------------- #
# INFORMATION ABOUT THE UPDATED DATA FILE: 
# -------------------------------------------------- #

The new data files contain new latent variable estimates for the years 2011-2013.

The CIRI data are included up to 2011 (unfortunately the 2012 and 2013 will not be coded for a while if at all). 

The PTS data are available up to 2013 (though not based on Amnesty Human Rights reports in 2013 because of report quality, the PTS Amnesty scale is included up to 2012). 

The UCDP one sided government killing data is included up to 2013. 

Everything about the data and model used to generated these updated scores are the same as the model that includes data through 2010. There will be future extensions but those aren't quite ready yet. Let me know if you have any questions. 


# -------------------------------------------------- #
# CITATION INFORMATION: 
# -------------------------------------------------- #

The latent variable is discussed at length in:

Fariss, Christopher J. 2014. "Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability". American Political Science Review 108(2):TBD 


An un-gated version of the paper is available here:

http://cfariss.com/documents/Fariss2014APSR.pdf

and here:

http://ssrn.com/abstract=2358014

An online appendix is available here:

http://cfariss.com/documents/FarissForthcomingAPSR_SupplementaryAppendix.pdf


You should also cite the following papers because the latent variable makes use of original data from these sources:

Cingranelli, David L. and David L. Richards. 1999. “Measuring the Level, Pattern, and Sequence of Government Respect for Physical Integrity Rights.” International Studies Quarterly 43(2):407–417.

Cingranelli, David L., David L. Richards, and K. Chad Clay. 2014. "The CIRI Human Rights Dataset."  http://www.humanrightsdata.com. Version 2014.04.14.

Conrad, Courtenay R., Jillienne Haglund and Will H. Moore. 2013. “Disaggregating Torture Allegations: Introducing the Ill-Treatment and Torture (ITT) Country-Year Data.” International Studies Perspec- tives 14(2):199–220.Conrad, Courtenay R. and Will H. Moore. 2011. “The Ill-Treatment & Torture (ITT) Data Project (Beta) Country–Year Data User’s Guide.” Ill Treatment and Torture Data Project .URL: http://www.politicalscience.uncc.edu/cconra16/UNCC/Under the Hood.html

Eck, Kristine and Lisa Hultman. 2007. “Violence Against Civilians in War.” Journal of Peace Research 44(2):233–246.

Gibney, Mark, Linda Cornett and Reed M. Wood. 2013. “Political Terror Scale.”.URL: http://www.politicalterrorscale.org/Gibney, Mark and Matthew Dalton. 1996. The Political Terror Scale. In Human Rights and Developing Countries, ed. D. L. Cingranelli. Vol. 4 of Policy Studies and Developing Nations Greenwich, CT: JAI Press pp. 73–84.

Harff, Barabara. 2003. “No Lessons Learned from the Holocaust? Assessing Risks of Genocide and Political Mass Murder since 1955.” American Political Science Review 97(1):57–73.Harff, Barbara and Ted R. Gurr. 1988. “Toward Empirical Theory of Genocides and Politicides: Identification and Measurement of Cases Since 1945.” International Studies Quarterly 32(3):359–371.

Hathaway, Oona A. 2002. “Do human rights treaties make a difference?” Yale Law Journal 111(8):1935– 2042.

Rummel, Rudolph J. 1994. “Power, Geocide and Mass Murder.” Journal of Peace Research 31(1):1–10. 

Rummel, Rudolph J. 1995. “Democracy, power, genocide, and mass murder.” Journal of Conflict Resolution 39(1):3–26.

Taylor, Charles Lewis and David A. Jodice. 1983. World Handbook of Political and Social Indicators Third Edition. Vol. 2, Political Protest and Government Change. New Haven: Yale University Press.Wayman, Frank W. and Atsushi Tago. 2010. “Explaining the onset of mass killing, 1949–87.” Journal of Peace Research 47(1):3–13.


# -------------------------------------------------- #
# VARIABLE INFORMATION:
# -------------------------------------------------- #

Brief descriptions of the variables contained in the file (see section 3 in the article and the online appendix for much more detailed information about these variables). Full citation information for each variable is contained in both of these documents.


YEAR --- year identifier  

CIRI --- CIRI country identifier 

COW --- correlates of war country identifier

DISAP --- 3 category, ordered variable for disappearances from the CIRI dataset

KILL --- 3 category, ordered variable from extra-judical killing the CIRI dataset

POLPRIS --- 3 category, ordered variable for political imprisonment from the CIRI dataset

TORT --- 3 category, ordered variable for torture from the CIRI dataset

Amnesty --- 5 category, 

State --- 5 category, 

hathaway --- 5 category, ordered variable for torture from the Hathaway (2002) article.

ITT --- 6 category, ordered variable for torture from the ITT dataset

genocide --- a binary variable for genocide from Harff's 2003 APSR article

rummel --- a binary variable for politicide/genocide based on data from Rummel

massive_repression --- a binary variable for massive repressive events taken from Harff and Gurr's 1988 ISQ article

executions --- a binary variable taken from the World Handbook of political indicators

killing --- binary version based on the UCDP one sided violence count data

additive --- the CIRI Physint scale

latentmean --- the posterior mean of the new latent variable described in the paper.

latentsd --- the standard deviation of the posterior estimates

NAME --- country name from the correlates of war dataset for each country


# -------------------------------------------------- #
# ADDITIONAL NOTES: 
# -------------------------------------------------- #

The latent variable is the posterior mean so you can use that as the DV. You can just use a standard OLS with this DV since it is continuous. You also don't need to worry about the uncertainty of the estimates (captured by the standard deviation) because the error term in the OLS will capture this uncertainty. However, if you used a lagged DV you should try and incorporate this uncertainty. This can be done using simulations. I discuss this procedure in the paper.

One final note, 666.001, 666.002, 666.003 are listed as cow codes because of extra reports produced from some years in the state department reports and coded by the PTS team. 
666 --- Israel
666.001 --- Israel, pre-1967 borders
666.002 --- Israel, occupied territories only
666.003 --- Palestinian Authority

# -------------------------------------------------- #
# End of file 
# -------------------------------------------------- #
