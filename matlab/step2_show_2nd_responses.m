% See the raw data to discover the second user responses
% Hypothesis: user was allowed to chance its opinion
ev = ecnt_af.event;
idx = find(ev>-1);
ev_marked =ev(idx)'; 
% CONCLUSION
% See ev_marked 
% for joint usage of events and (multiple) responces 
