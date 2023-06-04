EEG-ERP-precog
# Classification models for event-related potentials of electroencephalogram

This project makes a comprehensive comparison of several classification models. The classification object is an event. The event consists of brain activity measurements. The user receives a visual or audio stimulus. After the onset of the trigger, the EEG electrodes measure the event-related potentials. So, each event produces a two-way matrix. Its rows correspond to the electrodes, and columns correspond to time samples. The dataset is a pair design and target vector. The design matrix is three-way (event, electrode, time). Elements of the target are classes of events.

The precognitive classification means that the most informative part of the signal is expected to be in the earliest stages of the event-related potential.


## Text files with computational experiment results


## Python computational experiments
These texts test various hypotheses and models on the EEG ERP data. They are sorted by date, weekly.
- [Feature search through all electrodes](text/EEG Feature search through all electrodes, May 30)
- [Recognition Old-New words all models, all users, Apr 26](text/)
- [ERP classification accuracy for various tasks, Apr 19](text/)
- [Four class experiment and  classification accuracy for various tasks, Apr 12](text/)
- [ERP precog project with an a-priori description of possible models, Apr 4](text/)

## Matlab collection and visualization
Scripts to load recorded raw or preprocessed  EEG files, sorted by '''step_''' prefix
- [Collect data from Neuropype .mat](matlab/step1_collect_from_neurop.m)
- [Collect and segment data from Verbem raw time](matlab/step1_collect_from_raw.m)
- [Collect segmented data from prepared flat data](matlab/step1_collect_from_umn.m)
- [Convert former target data to new target format](matlab/step1_convert_raw_to_neurop.m)
- [Three-line script shows to problem of user's second  response](matlab/step2_show_2nd_responses.m)
- [Plot average response time for all users, first responses](matlab/step2a_plot_time_to_response.m)
- [Short script to smooth source matrix](matlab/step2b_smooth_data.m)
- [Analysis of number of changes in user's responses](matlab/step2c_table_time_to_2nd_responses.m)
- [Count users' responses for class balance](matlab/step3_count_responces.m)
- [Plot a histogram for class balances](matlab/step3_histogram_to_classify.m)
- [Split data by labels for two-class classification](matlab/step3_split_to_classify.m)
- [Generate LaTeX script for time series plot](matlab/step4_LaTeX_8elec_2clas.m)
- [Make a video to plot time series for sequential comparison](matlab/step4_YouTube_8elec_2clas.m)
- [Temporary file to plot electrode tile series](matlab/step4a_plot_rec_elecs.m)
- [ Analysis of users' correct and incorrect responses](matlab/step4b_user_behaviour_analysis.m)
- [Temporary plot file](matlab/step4c_plot_smooth_raw_1elec.m)
- [Plot AUCs for tree models, selected and all users](matlab/step5a_plot_sorted_user_auc.m)
- [The experiment on the optimal time to find ERP segment ](matlab/step5b_plot_timesegment_auc.m)
- [Plot original Biosemi cap coordinates in 3d and stereographic projection](matlab/step6_plot_electrode_hat.m)
- [Temporary plot Biosemi cap given electrodes' flat coordinates](matlab/step6_plot_Biosemi_cap.m)

## Not included 
- Any data files.