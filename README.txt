MULTIPLE REGRESSION ANALYSIS:  A CASE FOR BIKE SHARING IN LOS ANGELES 

STUDENT: CHLOE ZELLER
COMPUTER SCIENCE 347: MACHINE LEARNING
FALL 2017, PROFESSOR KATHRYN LEONARD

PROJECT DESCRIPTION:
- Analysis of data from a Bike Share system implemented in Washington D.C.
  The data spans two years of implementation, and tracks 11 features that 
  may be correlated with how many bikes were rented each day. 
- Using this data, we define the best multiple regression we can (by
  maximizing the Adjusted R Squared Statistic), and then test the model on 
  average winter, spring, summer and autumn days in Los Angeles, looking 
  for the model that mximized number of bikes checked out in one day. 


INITIALIZATIONS:
- Required Files
    - README.txt (which you obviously have if you're reading this, congrats!)
    - RUNME.m
    - InitialRegression.m
    - CollinearRegression.m
    - LassoRegression.m
    - LassoRegressionColinear.m
    - RidgeRegression.m
    - day.csv
    - Proj2_Tech_Report.docx
- Importing Data
    - Before beginning, you will need to import the bike share data as a 
      numerical array.
        - To do this, go to HOME tab, click "Import Data," and once the 
          window appears, double-click the "day" file. 
        - Once in the file, select all columns except columns 1 and 2, and 
          make sure "Numeric Matrix" is selected. Then you can click the 
          green checkmark above "import selection"
        - The numeric "day" should now be saved in your workspace as a 
          731x14 double.

RUNNING EXPERIMENT:
- Execution
    - To execute, simply run the RUNME.m script. 
- Output Expectations
    - This script will return 41 plots total. Do not be alarmed! All graphs
      are titled with a name describing what is being plotted. 
    - Running this script will also save 31 variables in the workspace, all
      of these correspond to the actual regression model, the adjusted r 
      squared statistic for each regression, the mean number of bikers, the 
      expected number of bikers for peak and low demand days, and 
      confidence intervals for the models. For detailed explanation of 
      these ariables and their meaning, consult the included Technical 
      Report. 