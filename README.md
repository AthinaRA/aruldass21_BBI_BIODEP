# aruldass21_BBI_BIODEP

Research data and scripts supporting ‘Dysconnectivity of a brain functional network was associated with blood inflammatory markers in depression’, 
Aruldass et al. (2021) Brain, Behavior, & Immunity

Author : Miss Athina Aruldass (ara49@cam.ac.uk or athina@aruldass.co.uk)
Date created : 23rd Aug 2021; 7.15pm (version 1) | 31st Aug 2021; 2.13am (v2) | 19th Feb 2022; 9.13pm (v3)


############################################################################################################################################################

DATA ORIGIN :
Data made available on this platform was collected as part of a wider academic-industry initiative to investigate novel therapeutics for inflammation-linked depression 
(detailed under Study Funding below). The present data is from the secondary cohort of the Biomarkers for Depression (BioDep) study - a 3-group observational 
case-control study conducted to explore functional connectivity abnormalities in inflammation-linked depression across : Healthy controls (N=46, CRP < 3mg/L), low inflammation depression cases (loCRP, N=50, CRP < 3mg/L) 
and high inflammation depression cases (hiCRP, N=33, CRP > 3mg/L). All procedures were approved by an independent national research ethics service (NRES) committee 
(NRES: East of England, Cambridge Central, UK; Reference: 15/EE/0092) and all participants provided written informed consent. 

Corresponding Author : Miss Athina Aruldass 
Principal Investigator : Professor Edward Bullmore (etb23@cam.ac.uk)


SHARED DATA :
In line with the Wellcome Trust open research policy, BioDep data cannot be made available publically. Restrcited access could be provided to accredited groups via IDE-CAM Repository.
Please contact PI for access to functional connectivity (FC) matrices for cases and controls, CRP (c-reactive protein) concentrations, sociodemographic data e.g. age, sex, BMI, and behavioral data i.e. total scores from behavioral instruments. 
All shared data have been sufficiently anonimized to contain no sensitive data i.e. birthdate, ethnicity, recruitment centre, medical history omitted. 
Participant ID appended in sociodemographic and behavioral datasets contain no identifiable personal information. Full details on fMRI preprocessing and related data available in main publication.
Other data e.g. other immune variables cannot be made available following restrictions instituted by the informed consent process. 
Queries regarding shared data should be directed to Corresponding Author or Principal Investigator.


STUDY FUNDING :
The study was funded by an award from the Wellcome Trust (grant number: 104025/Z/14/Z) for the Neuroimmunology of Mood Disorders and Alzheimer’s Disease (NIMA) Consortium 
in partnership with Janssen, GlaxoSmithKline, Lundbeck and Pfizer. Additional support was provided by the National Institute for Health Research (NIHR) Biomedical Research Centre (BRC) 
at Cambridge (Mental Health and Cell Phenotyping Hub), the NIHR BRC at South London and Maudsley NHS Foundation Trust and King’s College London, 
and an NIHR Senior Investigator award (to Principal Investigator - Prof Edward Bullmore).


CITATION :
Please cite data usage as - Athina Aruldass, Edward Bullmore. 2021. Research data supporting “Dysconnectivity of a brain functional network was associated with blood inflammatory markers in depression. 
(2021)” IDE-CAM Repository. https://portal.ide-cam.org.uk/collections



############################################################# FILES / SCRIPTS FOR FIGURES ###################################################################

Glasser cortical and (Free Surfer aseg) ROI labels (for FC matrices) : FCmatsROIorder_glasser.txt (see INFO ON DATA USAGE item 1)
Yeo 7-network modular ordering of Glasser cortical and (Free Surfer aseg) regions : Yeo_hcp.txt (see INFO ON DATA USAGE item 1)

Figure 1D (and 2C,3C) - chord diagram : Chord_diag_BBI.R
Figure 3A - correlation matrix : ImmBeh_CorrMat_BBI.R


############################################################# INFORMATION ON DATA USAGE ##############################################################

Generation of data and structure of data shared is briefly outlined below :

1. FUNCTIONAL CONNECTIVITY MATRICES
rs-fMRI data was preprocessed using multi-echo independent component analysis (ME-ICA) in AFNI. Images were then regionally parcellated using a 180 bilateral cortical surface–based atlas by Glasser et al. (2016) and 8 bilateral non–cortical regions per FreeSurfer, resulting in a 376 x 244 regional timeseries. Timeseries were then bandpass filtered at wavelet scales 2 and 3 corresponding to 0.02–0.1Hz. The FC between each regional pair was estimated by Pearson’s correlation coeffcient (r) between pairwise wavelet coeffcients and then averaged, resulting in a 376 x 376 symmetric FC matrix. FC matrix were then Fisher r-to-z transformed. Additional nuisance variables i.e. root mean squared framewise displacement (FDrms), MRI scan site and age were regressed out edge–wise from the FC matrices. FC matrices per subject are accessible via array in files below, stored in native R format (.rds). These are indexed according to participant ID in sociodemographic data frame.
    
    * Healthy controls FC matrices available @ HCbiodep_FCmats.rds (array size 376 x 376 x 46)
    
    * Low CRP depression cases FC matrices available @ loCRPbiodep_FCmats.rds (array size 376 x 376 x 50) 
    
    * High CRP depression cases FC matrices available @ hiCRPbiodep_FCmats.rds (array size 376 x 376 x 33)  
    
    * Rows and columns of FC matrices are ordered according to FCmatsROIorder_glasser.txt (376 x 1; L/R 16 subcortical regions, Left - 180 cortical regions, Right - 180 cortical regions.)
    
    * Yeo 7 (+1) functional modules are ordered - VIS, SMOT, DA, VA, LIMB, FP, DMN, (an extra SUBCORTICAL module for aseg)
    


2. SOCIODEMOGRAPHIC INFORMATION AND CRP CONCENTRATION
Sociodemographic information including age, sex, BMI, ethnicity and CRP concentrations (in mg/L and log-transformed base 10) for all participants per group are accessible via data frame files below, stored in native R format (.rds). 
    
    * Healthy controls sociodemographic variables available @ HCbiodep_sociodemo.rds (46 x 16)
    
    * Low CRP depression cases sociodemographic variables available @ loCRPbiodep_sociodemo.rds (50 x 16)
    
    * High CRP depression cases sociodemographic variables available @ hiCRPbiodep_sociodemo.rds (33 x 16)
 

3. BEHAVIORAL INSTRUMENTS
Total scores for behavioral instruments i.e. HAM-D 17 items, BDI-II, SHAPS, PSS, CFS, STAI-S, STAI-T, CTQ, LEQ score and LEQ rating for all participants (N=129) are accessible via single data frame, stored in native R format.
    
    * All participants behavioral data available @ ALLbiodep_behdat.rds (129 x 13).
  
