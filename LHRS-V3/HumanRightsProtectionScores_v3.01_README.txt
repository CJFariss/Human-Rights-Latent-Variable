# ------------------------------------------------------- #
# HumanRightsProtectionScores_Version_v3.01_README.txt
# ------------------------------------------------------- #

 File Date: 2019-05-28

 Author: Christopher Fariss

 Contact: Chris Fariss: cjf0006@gmail.com
 All inquires about the models and code should be sent to Chris Fariss 

 Copyright (c) 2019, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
 For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
 All rights reserved. 


# ------------------------------------------------------- #
# INFORMATION ABOUT THIS FILE: 
# ------------------------------------------------------- #

This README file provides a information about the data contained in the following file (1946-2017):

This new datafile replicates and extends the latent variable estimates contained in this file (1946-2017):


# ------------------------------------------------------- #
# INFORMATION ABOUT THE UPDATED DATA FILE for version 3: 
# ------------------------------------------------------- #

The new data files contains estimates from 1946-2017. The original file contained estimates from 1949-2010 and was updated to go through 2013.

There are new variables now included in the model:

The Political Terror Scale now codes Human Rights Watch reports from 2013-2017.

Negative Sanctions, a binary variable, are taken from the World Handbook of Political Indicators for the period 1949-1982

A new mass killing binary variable is taken from Ulfelder and Valentino (2008). It is currently available in the version 9 updated for the Varities of Democracy dataset.

Fixed some typos from the earlier README file.

# ------------------------------------------------------- #
# INFORMATION ABOUT THE UPDATED DATA FILE for version 2: 
# ------------------------------------------------------- #

The latent variable model now uses a student's t distrubution for the latent trait following recommendations in: Reuning, Kevin, Michael R. Kenwick, and Christopher J. Fariss. "Exploring the Dynamics of Latent Variable Models" Political Analysis (Forthcoming)

The new data files contain new latent variable estimates for the years 2011-2013.

The CIRI data are included up to 2011 (unfortunately the 2012 and 2013 will not be coded for a while if at all). 

The PTS data are available up to 2013 (though not based on Amnesty Human Rights reports in 2013 because of report quality, the PTS Amnesty scale is included up to 2012). 

The UCDP one sided government killing data is included up to 2013. 

Everything about the data and model used to generate these updated scores are the same as the model that includes data through 2010. There will be future extensions but those aren't quite ready yet. Let me know if you have any questions. 


# ------------------------------------------------------- #
# CITATION INFORMATION: 
# ------------------------------------------------------- #

The latent variable model and its extensions are discussed at length in:

Fariss, Christopher J.  "Yes, Human Rights Practices Are Improving Over Time" American Political Science Review (Forthcoming)

Reuning, Kevin, Michael R. Kenwick, and Christopher J. Fariss. "Exploring the Dynamics of Latent Variable Models" Political Analysis (Forthcoming)

Fariss, Christopher J. 2014. "Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability" American Political Science Review 108(2):297-318. 

Schnakenberg, Keith E. and Christopher J. Fariss "Dynamic Patterns of Human Rights Practices" Political Science Research and Methods 2(1):1-31 (April 2014)


You should also cite the following papers because the latent variable makes use of original data from these sources:

Cingranelli, David L. and David L. Richards. 1999. “Measuring the Level, Pattern, and Sequence of Government Respect for Physical Integrity Rights.” International Studies Quarterly 43(2):407–417.

Cingranelli, David L., David L. Richards, and K. Chad Clay. 2014. "The CIRI Human Rights Dataset."  http://www.humanrightsdata.com. Version 2014.04.14.

Conrad, Courtenay R., Jillienne Haglund and Will H. Moore. 2013. “Disaggregating Torture Allegations: Introducing the Ill-Treatment and Torture (ITT) Country-Year Data.” International Studies Perspec- tives 14(2):199–220.

Conrad, Courtenay R. and Will H. Moore. 2011. “The Ill-Treatment & Torture (ITT) Data Project (Beta) Country–Year Data User’s Guide.” Ill Treatment and Torture Data Project.
URL: http://www.politicalscience.uncc.edu/cconra16/UNCC/Under the Hood.html

Eck, Kristine and Lisa Hultman. 2007. “Violence Against Civilians in War.” Journal of Peace Research 44(2):233–246.

Gib­ney, Mark, Linda Cor­nett, Reed Wood, Peter Hasch­ke, Daniel Arnon, and Attilio Pisanò. 2018. The Polit­ic­al Ter­ror Scale 1976-2017. Date Re­trieved, from the Polit­ic­al Ter­ror Scale website: ht­tp://www.polit­ic­al­ter­rorscale.org.

Gibney, Mark and Matthew Dalton. 1996. The Political Terror Scale. In Human Rights and Developing Countries, ed. D. L. Cingranelli. Vol. 4 of Policy Studies and Developing Nations Greenwich, CT: JAI Press pp. 73–84.

Harff, Barabara. 2003. “No Lessons Learned from the Holocaust? Assessing Risks of Genocide and Political Mass Murder since 1955.” American Political Science Review 97(1):57–73.

Harff, Barbara and Ted R. Gurr. 1988. “Toward Empirical Theory of Genocides and Politicides: Identification and Measurement of Cases Since 1945.” International Studies Quarterly 32(3):359–371.

Hathaway, Oona A. 2002. “Do human rights treaties make a difference?” Yale Law Journal 111(8):1935– 2042.

Rummel, Rudolph J. 1994. “Power, Geocide and Mass Murder.” Journal of Peace Research 31(1):1–10. 

Rummel, Rudolph J. 1995. “Democracy, power, genocide, and mass murder.” Journal of Conflict Resolution 39(1):3–26.

Taylor, Charles Lewis and David A. Jodice. 1983. World Handbook of Political and Social Indicators Third Edition. Vol. 2, Political Protest and Government Change. New Haven: Yale University Press.

Ulfelder, Jay and Benjamin Valentino. 2008. “Assessing Risks of State-Sponsored Mass Killing.”
http://dx.doi.org/10.2139/ssrn.1703426.

Wayman, Frank W. and Atsushi Tago. 2010. “Explaining the onset of mass killing, 1949–87.” Journal of Peace Research 47(1):3–13.


# ------------------------------------------------------- #
# VARIABLE INFORMATION:
# ------------------------------------------------------- #

Brief descriptions of the variables contained in the file (see section 3 in the article and the online appendix for much more detailed information about these variables). Full citation information for each variable is contained in both of these documents.


YEAR --- year identifier  

CIRI --- CIRI country identifier 

COW --- correlates of war country identifier

DISAP --- 3 category, ordered variable for disappearances from the CIRI dataset

KILL --- 3 category, ordered variable from extra-judical killing the CIRI dataset

POLPRIS --- 3 category, ordered variable for political imprisonment from the CIRI dataset

TORT --- 3 category, ordered variable for torture from the CIRI dataset

Amnesty --- 5 category ordinal variable from the Political Terror Scale.

State --- 5 category ordinal variable from the Political Terror Scale.

HRW --- 5 category ordinal variable from the Political Terror Scale. 

hathaway --- 5 category, ordered variable for torture from the Hathaway (2002) article.

ITT --- 6 category, ordered variable for torture from the ITT dataset

genocide --- a binary variable for genocide from Harff's 2003 APSR article

rummel --- a binary variable for politicide/genocide based on data from Rummel

massive_repression --- a binary variable for massive repressive events taken from Harff and Gurr's 1988 ISQ article

executions --- a binary variable taken from the World Handbook of Political Indicators

negative_sanctions --- a binary variable taken from the World Handbook of Political Indicators	

mass_killing --- a binary variable taken from Ulfelder and Valentino (2008)

killing_low  --- UCDP one sided violence count data low estimate	 
 
killing_best  --- UCDP one sided violence count data best estimate	

killing_high --- UCDP one sided violence count data high estimate	

killing_present (formerly killing) --- binary version based on the UCDP one sided violence count data

COW_YEAR --- combination of the COW and YEAR identifiers 

id --- unique unit identifier

theta_mean (formerly latent mean) --- the posterior mean of the new latent variable described in the paper.

theta_sd (formerly latentsd) --- the standard deviation of the posterior estimates

NAME --- country name from the correlates of war dataset for each country


# ------------------------------------------------------- #
# ADDITIONAL NOTES: 
# ------------------------------------------------------- #

The latent variable is the posterior mean so you can use that as the DV. You can just use a standard OLS with this DV since it is continuous. You also don't need to worry about the uncertainty of the estimates (captured by the standard deviation) because the error term in the OLS will capture this uncertainty. However, if you used a lagged DV you should try and incorporate this uncertainty. This can be done using simulations. I discuss this procedure in the paper.


These codes are no longer contained in the PTS dataset so are now no longer available in the updated scores
One final note, 666.001, 666.002, 666.003 are listed as cow codes because of extra reports produced from some years in the state department reports and coded by the PTS team. 
666 --- Israel
666.001 --- Israel, pre-1967 borders
666.002 --- Israel, occupied territories only
666.003 --- Palestinian Authority

# ------------------------------------------------------- #
# End of file 
# ------------------------------------------------------- #
