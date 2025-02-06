import pm4py
import pandas as pd

# Global variables 
fileName = 'running-example.csv'

if __name__ == "__main__":
# Write a csv to dataframe object
    dataframe = pd.read_csv(fileName, sep=';')
    dataframe = pm4py.format_dataframe(dataframe, case_id='case_id', activity_key='activity', timestamp_key='timestamp')

# Write an event log to xes and read xes into a dataframe object
    #pm4py.write_xes(event_log, 'job1.xes')
    #dataframe = pm4py.read_xes('job1.xes')  

#Get data from dataframe
            #DataFrame: case_id: str = constants.CASE_CONCEPT_NAME, activity_key: str = xes_constants.DEFAULT_NAME_KEY, timestamp_key: str = xes_constants.DEFAULT_TIMESTAMP_KEY,
                #start_timestamp_key: str = xes_constants.DEFAULT_START_TIMESTAMP_KEY, timest_format: str | None = None
    start_activities = pm4py.get_start_activities(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    end_activities = pm4py.get_end_activities(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    act_pos = pm4py.get_activity_position_summary(dataframe, 'change a ', activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    case_durations = pm4py.get_all_case_durations(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
            ###case duration is a list var (case_duration[#])
    event_attributes = pm4py.get_event_attributes(dataframe)
    activities = pm4py.get_event_attribute_values(dataframe, 'concept:name', case_id_key='case:concept:name')
    trace_attributes = pm4py.get_trace_attributes(dataframe)
    duration = pm4py.get_case_duration(dataframe, '1', activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    cycle_time = pm4py.get_cycle_time(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    rework = pm4py.get_rework_cases_per_activity(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    case_arr_avg = pm4py.get_case_arrival_average(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    msd_wit = pm4py.get_minimum_self_distance_witnesses(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    msd = pm4py.get_minimum_self_distances(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    variants = pm4py.get_variants(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')

#Create event log from dataframe
    event_log = pm4py.convert_to_event_log(dataframe)

#get dfg, start activities and end activities from event log
    dfg, start_activities, end_activities = pm4py.discover_dfg(event_log)

#Get petri net (pn), initial marking (im), and final marking (fm) from event log.
#alpha
    pn, im, fm = pm4py.discover_petri_net_alpha(event_log)
#inductive
    pn_i, im_i, fm_i = pm4py.discover_petri_net_inductive(event_log)

#discover heuristic_net (map) from event log
    map = pm4py.discover_heuristics_net(event_log)

#Create process tree from dataframe
    process_tree = pm4py.discover_process_tree_inductive(dataframe)

#Create BPMN from process tree
    bpmn_model = pm4py.convert_to_bpmn(process_tree)

#filter and unfiltered bpmn
    bpmn_unfiltered = pm4py.discover_bpmn_inductive(event_log)
    bpmn_filtered = pm4py.discover_bpmn_inductive(event_log, 0.8)

#Conformance
    aligned_traces = pm4py.conformance_diagnostics_alignments(dataframe, pn, im, fm)
    replayTraces = pm4py.conformance_diagnostics_token_based_replay(event_log, pn, im, fm) 

#Fitness   
    fitness_alignemnt = pm4py.fitness_alignments(dataframe, pn, im, fm)
    tokenBaseTrace = pm4py.fitness_token_based_replay(dataframe, pn, im, fm)

#extract features
    features_df = pm4py.extract_features_dataframe(dataframe, activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')

#Save files PNGs
    pm4py.vis.save_vis_alignments(dataframe, aligned_traces, 'alignments.png')
    pm4py.vis.save_vis_process_tree(process_tree, 'process tree.png', 'white')
    pm4py.vis.save_vis_bpmn(bpmn_model, 'bpmn model.png', 'white')
    pm4py.vis.save_vis_dfg(dfg, start_activities, end_activities, 'dfg.png', 'white')
    pm4py.vis.save_vis_case_duration_graph(dataframe, 'case duration graph.png', activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    pm4py.vis.save_vis_events_distribution_graph(dataframe, 'events distrobution graph.png', activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    pm4py.vis.save_vis_events_per_time_graph(dataframe, 'events per time graph.png', activity_key='concept:name', case_id_key='case:concept:name', timestamp_key='time:timestamp')
    pm4py.vis.save_vis_heuristics_net(map, 'heuristic net.png', 'white')
    pm4py.vis.save_vis_petri_net(pn, im, fm, 'petrinet.png', 'white')
    pm4py.vis.save_vis_petri_net(pn_i, im_i, fm_i, 'petrinet_i.png', 'white')
    pm4py.vis.save_vis_performance_dfg(dfg, start_activities, end_activities, 'perfmormance dfg.png', aggregation_measure='mean')
    
#Save text files
    pm4py.write_bpmn(bpmn_model, 'bpmn.bpmn')
    pm4py.write_dfg(dfg, start_activities, end_activities, 'dfg')
    pm4py.write_pnml(pn, im, fm, 'pnml.pnml')
    pm4py.write_ptml(process_tree, 'ptml.ptml')
 
 #printing  
    print("Start Activities: " + str(start_activities))
    print("End Activities: " + str(end_activities))
    print("Activity Positions: " + str(act_pos))
    print("Case Durations: " + str(case_durations))
    print("Activities: " + str(activities))
    print("Trace Attributes: " + str(trace_attributes))
    print("Duration: " + str(duration))
    #print(cycle_time)
    #print(rework)
    #print(case_arr_avg)
    #print(msd_wit)
    #print(msd)
    print("Variants List: " + str(variants))

#view models, images, etc.
    #pm4py.view_bpmn(bpmn_model)
    #pm4py.view_process_tree(process_tree)
    #pm4py.view_dfg(dfg, start_activities, end_activities)
    #pm4py.view_heuristics_net(map)
    #pm4py.view_bpmn(bpmn_unfiltered)
    #pm4py.view_bpmn(bpmn_filtered)
    #pm4py.view_petri_net(pn, im, fm)
    #pm4py.view_alignments(dataframe, aligned_traces, format='png')
        
#printing vars
    #print(aligned_traces)
    #print(tokenBaseTrace)
    #print(features_df)