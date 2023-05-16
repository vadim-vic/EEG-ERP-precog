# EEG-ERP-precog
Classification models for event-related potentials of electroencephalogram

This project makes a comprehensive comparison of several classification models. The classification object is an event. The event consists of brain activirty mearurements. The user, a subject to measurement recaives a visual or audio stimulus. After the onset of the stumulus, the EEG electrodes measures the event-relates potentials. So, each event produces a two-way matrix. Its rows correspond to the electrodes and colums correspont to time-samples. The dataset is a pair desgn and target vector. The design matrix is three-way (event, electrode, time). Elements of the target are classes of events.

The precognitive claccsivication means that the most informative part of the signal is expected to be in the earliest stages of the evene-related potential.
