# Overview
## Array Type Meta-Predictor Based Classification

The Array type meta-predictor based classier was develped for prediction of Harmful agents.

<p align="center">
  <img src="https://user-images.githubusercontent.com/86823471/165199292-b97e61b8-2b5f-4230-91cb-1f8204e96ef3.png"/>
</p>

#### Figure 1: Design of meta-predictor for multi-tasking and data workflow.

## Requirements:

The following necessary packages should be installed in to process, generate fingerprint, train and test your model.

1. KNIME analytics platform (> 3.5)
2. python >3.0
3. Keras
4. Tensorflow
5. Scikit Learn
6. Jupyter Notebook
7. R / R-Studio

## Procedures:
### 1. Data Structure:
- Collection of chemical data from ChEMBL (Version 24) data for five different targets (i.e. nicotinic acetylcholine receptors (nAChR), muscarinic acetylcholine receptors (mAChR), vesicular acetylcholine receptors (VAChT), acetylcholinesterase (AChE) and butyrylcholinesterase (BUChE) using ChEMBL provided SQL file.
- Negative data: We used the Decoy Finder to collect the negative data for each targets, in order to keep the balance between the active and inactive classes.
- External data: In order to evaluate the performance of classifer, we used the external dataset from Chemical Warfare Agents (CWA) and New Psychoactive Substance (NPS).

    #### Table 1: The Dataset Composition
    | Targets       |   Collected Data  | Train (Active) | Train (Inactive)| Test (Active) | Test (Inactive) | Total |
    |---------------|------------------ |----------|---------|--------|----------|--------|
    |   nAChR       |       3175        |   637   |   637   |   272  |  272     |  1818  |
    |   mAChR       |       24223       |   2431  |   2431  |   1041 |  1041    |  6944  |
    |   BuChE       |       2414        |   484   |   484   |   207  |  207     |  1382  |
    |   AChE        |       8212        |   1086  |   1086  |   464  |  464     |  3098  |
    |   VAChT       |       231         |   106   |   106   |   45   |  45      |  302   |
    |   CWA         |       95          |         |         |        |          |  95    |
    |   NPS         |       3126        |         |         |        |          |  3126  |

### 2. Feature Generation: 
- We used the CDK Descriptor Kit for calculation of different Fingerprints (i.e. ECFP0, ECFP2, ECFP4, ECFP6, FCFP0, FCFP2, FCFP4, FCFP6) with fixed bitvector length (length:1024).
    
    All the input data along with calculated features are available under the `data` folder.
### 3. Model training:
- To build classification models, we used the four machine learning methods (i.e. Random Forest, Decision Tree, Support Vector Machine, k-Nearest Neighbor)
    - We have used R for machine learning classification and a R code for one target (i.e. nAChR) has been provided under the script folder. The same code was used for learning for other targets. We build 10 models (M1-M10) for each ML classifier and for each targets. This result in `4 ML method * 5 targets * 10 models (M1-M10) = 200 models`.

#### Figure 2: The statistical performance based on AUC in external and internal validation for respective targets.
<p align="center">
  <img src="https://user-images.githubusercontent.com/86823471/165680587-b0c3f663-2ae3-4779-9f8d-d18d3cf7fc1d.png"/></p>
    
### 4. CNN training:
- To build the array-type meta-predictor based classifier, we used the CNN architecture with multiple layer of network for learning, validation and testing purposes.
    - After training, testing and validating the ML classifer for different targets, the external set as third set was used to evaluate the ML performance. The predicted values for each targets, for each ML method and for different models (M1-M10) on external sets were used as input feature matrix with different shapes (i.e. CNN, CNN-3D, CNN-3D Reshaped) for array-type meta-predictor based CNN classification.
    - The array-type meta-predictor CNN code is available under `script` folder.

#### Figure 3: The prediction performace of array-type meta predictor for three different shaped array classifiers according to data sampling (Model 01 to 04).
<p align="center">
  <img src="https://user-images.githubusercontent.com/86823471/165679710-d478a41f-4251-4565-bee7-f32d175878f1.png"/>
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/86823471/165679738-95cf9b97-6f72-45bd-a475-90b785cb454d.png"/>
</p>

#### For any queries regarding the above work, kindly contact Prof. Mi-hyun Kim (kmh0515@gachon.ac.kr).
