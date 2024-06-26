EEG-ERP-precog
# Classification models for event-related potentials of electroencephalogram

This project makes a comprehensive comparison of several classification models. The classification object is an event. The event consists of brain activity measurements. The user receives a visual or audio stimulus. After the onset of the trigger, the EEG electrodes measure the event-related potentials. So, each event produces a two-way matrix. Its rows correspond to the electrodes, and columns correspond to time samples. The dataset is a pair design and target vector. The design matrix is three-way (event, electrode, time). Elements of the target are classes of events.

The precognitive classification means that the most informative part of the signal is expected to be in the earliest stages of the event-related potential.

## Text files with computational experiment results
These texts test various hypotheses and models on the EEG ERP data. They are sorted by date, weekly.
1. [EEG DGD space-time literature and code, June 12](text/EEG_DGD_model_review_Jun12.pdf)
1. [EEG Feature search through all electrodes, May 30](text/EEG_Feature_search_through_all_electrodes_May30.pdf)
2. [EEG expert-engineered features, May 23](text/EEG_expert-engineered_features_May23.pdf)
3. [EEG expert features for GP classification, May 17](text/EEG_expert_features_for_GP_classification_May17.pdf)
4. [EEG exploring the time-window feature, May 9](text/EEG_exploring_the_time-window_feature_May9.pdf)
5. [EEG user behavior analysis, May 2](text/EEG_user_behavior_analysis_May2.pdf)
6. [EEG exhaustive model comparison, Apr 26](text/EEG_exhaustive_model_comparison_Apr26.pdf)
7. [EEG ERP classification and class balance, Apr 19](text/EEG_ERP_class_balance_Apr19.pdf)
8. [EEG computational experiment plan, Apr 12](text/EEG_computational_experiment_plan_Apr12.pdf)
10. [EEG ERP precog a-priori list of possible models, Apr 4](text/EEG_project_research_a-proiri_plan_Apr4.pdf)

## Python computational experiments
Notebooks with the sourse code of computational experiments listed above.
1. [Expert-engineered feature search over all electrodes, May 30](experiment/EEG_over_all_electrodes_May30.ipynb)
2. [Plot AUC of reduced number of classifiers, May 23](experiment/EEG_expert_features_S3_May23.ipynb)
3. [Exhaustive model comparison, Apr 30](experiment/EEG_three_classifiers_reported_Apr30.ipynb)
4. [Genetic algorithm for feature selection](experiment/Genetic_Genetic_feature_selection_debug.ipynb) and [demo](experiment/Genetic_feature_selection_demo.ipynb)
5. [Function to plot spatial signal structure on the BioSemo 128 cap](experiment/plot_biosemi128.ipynb)
## Matlab collection and visualization
Scripts to load recorded raw or preprocessed  EEG files, sorted by ''step_'' prefix
1. [Collect data from Neuropype .mat](matlab/step1_collect_from_neurop.m)
2. [Collect and segment data from Verbem raw time](matlab/step1_collect_from_raw.m)
3. [Collect segmented data from prepared flat data](matlab/step1_collect_from_umn.m)
4. [Convert former target data to new target format](matlab/step1_convert_raw_to_neurop.m)
5. [Three-line script shows to problem of user's second  response](matlab/step2_show_2nd_responses.m)
6. [Plot average response time for all users, first responses](matlab/step2a_plot_time_to_response.m)
7. [Short script to smooth source matrix](matlab/step2b_smooth_data.m)
8. [Analysis of number of changes in user's responses](matlab/step2c_table_time_to_2nd_responses.m)
9. [Count users' responses for class balance](matlab/step3_count_responces.m)
10. [Plot a histogram for class balances](matlab/step3_histogram_to_classify.m)
11. [Split data by labels for two-class classification](matlab/step3_split_to_classify.m)
12. [Generate LaTeX script for time series plot](matlab/step4_LaTeX_8elec_2clas.m)
13. [Make a video to plot time series for sequential comparison](matlab/step4_YouTube_8elec_2clas.m)
14. [Temporary file to plot electrode tile series](matlab/step4a_plot_rec_elecs.m)
15. [ Analysis of users' correct and incorrect responses](matlab/step4b_user_behaviour_analysis.m)
16. [Temporary plot file](matlab/step4c_plot_smooth_raw_1elec.m)
17. [Plot AUCs for tree models, selected and all users](matlab/step5a_plot_sorted_user_auc.m)
18. [The experiment on the optimal time to find ERP segment ](matlab/step5b_plot_timesegment_auc.m)
19. [Plot original Biosemi cap coordinates in 3d and stereographic projection](matlab/step6_plot_electrode_hat.m)
20. [Temporary plot Biosemi cap given electrodes' flat coordinates](matlab/step6_plot_Biosemi_cap.m)

## Not included 
Any data files.

##  EEG and ECoG signal decoding

The brain signals decoding models give a decent quality of limb movement classification in 2023. The base model is described in the [HTNet](https://github.com/BruntonUWBio/HTNet_generalized_decoding) by Brunton 2021, and it's precedent [EEGNet](https://github.com/vadim-vic/arl-eegmodels). The plan of the works for this overview is the following:
* search for the newest updates of HTNet and EEGNet
* develop these models towards the heterogenous multi-modal data like [Deliberate's](https://www.deliberate.ai/)
* move the problem statement from classification to decoding, assuming the phase space both in the source and the target spaces
* develop the [State-Space Models D4](https://github.com/MrRezaeiUofT/Deep_Direct_Discriminative_Decoder-D4-) by  Yousefi and Rezaei 2022 to 
  1) use the Bayesian approach and, preferably, diffusion probabilistic models with normalizing flows
  2) use Neural ODE networks with continuous layers to boost the approximation quality in the framework of SSM [Hippo](https://github.com/HazyResearch/state-spaces) 2022 [paper](https://arxiv.org/abs/2206.12037)
  3) since the usage of Riemannian spaces and [PyRiemann](https://github.com/pyRiemann/pyRiemann) models by Barachant 2022 have great success in the EEG signal processing, consider works on the brain functional groups 

## Multi-modal heterogeneous data
The brain data comprises three main sources:
1) the stimuli that the patient perceives, some video, and audio manifestations,
2) the patient's brain signals, the EEG, and ECoG signals,
3) the patient's body reaction, the eye and limb movement.
These three sources are gathered in a common timeline and joined by the following causal relationship.

![Patient data causal relationship](casuality_in_data.png)

