--Copying a columns for a clean table
CREATE TABLE clean_hevy AS 
SELECT 
    start_time AS excerise_data, 
    weight_lbs,
    exercise_title AS exercise_name,
    reps
FROM hevy_raw; 

