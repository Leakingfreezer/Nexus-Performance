DROP TABLE IF EXISTS clean_hevy;
--Copying a columns for a clean table
CREATE TABLE clean_hevy AS 
SELECT 
    start_time AS excerise_data, 
    weight_lbs,
    exercise_title AS exercise_name,
    reps
FROM hevy_raw; 

--Date column
ALTER TABLE clean_hevy ADD COLUMN date TEXT;
UPDATE clean_hevy
SET date = SUBSTR(excerise_data, 1, INSTR(excerise_data, ',') -1);

--Muscle zone leaderboard 
--INSERT INTO exercise_muscle_map (exercise_name)
--SELECT DISTINCT exercise_name
--FROM clean_hevy;

DELETE FROM exercise_muscle_map;

INSERT INTO exercise_muscle_map
(
    exercise_name,
    primary_muscle,
    secondary_muscle,
    movement_pattern,
    hyrox_relevance
)
VALUES
('Bent Over Row (Barbell)', 'back', 'lats,traps,rhomboids,rear_delts,biceps', 'horizontal_pull', 'row,sled_pull'),
('Deadlift (Barbell)', 'posterior_chain', 'glutes,hamstrings,lower_back,adductors,traps,grip,quads', 'hinge', 'sled_pull,farmer_carry'),
('Lat Pulldown (Cable)', 'lats', 'biceps,rear_delts,upper_back', 'vertical_pull', 'ski_erg,row,sled_pull'),
('Seated Cable Row - Bar Wide Grip', 'back', 'lats,traps,rhomboids,rear_delts,biceps', 'horizontal_pull', 'row,sled_pull'),
('Face Pull', 'shoulders', 'rear_delts,traps,rotator_cuff', 'horizontal_pull', 'posture,injury_prevention'),
('Back Extension (Weighted Hyperextension)', 'posterior_chain', 'glutes,hamstrings,lower_back', 'hinge', 'sled_pull'),
('Cable Crunch', 'core', 'rectus_abdominis,obliques', 'core', 'core_stability'),
('Rear Delt Reverse Fly (Machine)', 'shoulders', 'rear_delts,traps,upper_back', 'horizontal_pull', 'posture'),
('Butterfly (Pec Deck)', 'chest', 'anterior_delts', 'horizontal_push', 'general_strength'),
('Single Arm Lateral Raise', 'shoulders', 'upper_traps', 'isolation', 'general_strength'),
('Lateral Raise (Dumbbell)', 'shoulders', 'upper_traps', 'isolation', 'general_strength'),
('Triceps Rope Pushdown', 'triceps', 'forearms', 'isolation', 'general_strength'),
('Romanian Deadlift (Barbell)', 'posterior_chain', 'glutes,hamstrings,lower_back,grip', 'hinge', 'sled_pull,farmer_carry'),
('Hip Thrust (Barbell)', 'glutes', 'hamstrings,core', 'hinge', 'sled_push,lunges'),
('Bulgarian Split Squat', 'quads', 'glutes,adductors,hamstrings,core', 'lunge', 'lunges,sled_push'),
('Leg Press (Machine)', 'quads', 'glutes,hamstrings', 'squat', 'sled_push,wall_balls'),
('EZ Bar Biceps Curl', 'biceps', 'forearms,brachialis', 'isolation', 'grip_endurance'),
('Squat (Smith Machine)', 'quads', 'glutes,adductors,lower_back,core', 'squat', 'sled_push,wall_balls'),
('Lying Leg Curl (Machine)', 'hamstrings', 'calves', 'isolation', 'running,lunges'),
('Hip Adduction (Machine)', 'adductors', 'glutes,core', 'isolation', 'running,lunges'),
('Leg Extension (Machine)', 'quads', 'rectus_femoris', 'isolation', 'sled_push,wall_balls'),
('Seated Overhead Press (Dumbbell)', 'shoulders', 'triceps,upper_chest', 'vertical_push', 'wall_balls'),
('Bench Press (Barbell)', 'chest', 'triceps,shoulders', 'horizontal_push', 'general_strength'),
('Bicep Curl (Barbell)', 'biceps', 'forearms,brachialis', 'isolation', 'grip_endurance'),
('Hip Abduction (Machine)', 'glutes', 'glute_medius,core', 'isolation', 'running,lunges'),
('Leg Raise Parallel Bars', 'core', 'hip_flexors', 'core', 'core_stability'),
('Lat Pulldown - Close Grip', 'lats', 'biceps,rear_delts,upper_back', 'vertical_pull', 'ski_erg,row'),
('Seated Cable Row - V Grip', 'back', 'lats,traps,rhomboids,biceps', 'horizontal_pull', 'row,sled_pull'),
('Shoulder Press (Dumbbell)', 'shoulders', 'triceps,upper_chest', 'vertical_push', 'wall_balls'),
('Treadmill', 'cardio', 'calves,hamstrings,glutes', 'cardio', 'running'),
('Single Arm Seated Lat Row', 'back', 'lats,biceps,core', 'horizontal_pull', 'row,sled_pull'),
('Bicep Curl (Dumbbell)', 'biceps', 'forearms,brachialis', 'isolation', 'grip_endurance'),
('Hammer Curl (Dumbbell)', 'biceps', 'forearms,brachialis', 'isolation', 'grip_endurance'),
('Dumbbell Step Up', 'quads', 'glutes,hamstrings,core', 'lunge', 'lunges,sled_push'),
('Reverse Grip Lat Pulldown', 'lats', 'biceps,upper_back', 'vertical_pull', 'ski_erg,row'),
('Romanian Deadlift (Dumbbell)', 'posterior_chain', 'glutes,hamstrings,lower_back,grip', 'hinge', 'sled_pull,farmer_carry'),
('Single Arm Cable Row', 'back', 'lats,biceps,core', 'horizontal_pull', 'row,sled_pull'),
('Side Bend', 'core', 'obliques', 'core', 'core_stability'),
('Cross Body Hammer Curl', 'biceps', 'forearms,brachialis', 'isolation', 'grip_endurance');

--Adding a column
ALTER TABLE exercise_muscle_map
ADD COLUMN body_region TEXT;

--Using update method, setting the value of the body_region dependant on the primary muscle, so if/else statement
UPDATE exercise_muscle_map
SET body_region = 

CASE
--This is how you would do it individually
    --WHEN primary_muscle = 'quads' THEN 'legs' 
    --WHEN primary_muscle = 'hamstrings' THEN 'legs'
    --WHEN primary_muscle = 'glutes' THEN 'glutes

    WHEN primary_muscle IN ('quads', 'hamstrings', 'calves', 'adductors', 'posterior_chain') THEN 'legs'
    WHEN primary_muscle IN('back', 'lats', 'upper_back', 'lower_back') THEN 'back'
    WHEN primary_muscle IN('biceps', 'triceps', 'grip') THEN 'arms'
    WHEN primary_muscle IN('glutes') THEN 'glutes'
    WHEN primary_muscle IN('chest') THEN 'chest'
    WHEN primary_muscle IN('shoulders') THEN 'shoulders'
    WHEN primary_muscle IN('core') THEN 'core'
    WHEN primary_muscle IN ('cardio') THEN 'cardio'
    ELSE 'unknown'
END;

--Normalization 
--Creating a table for analystics
CREATE TABLE exercise_summary (
    date text, 
    exercise_name text, 
    weight REAL, 
    reps INTEGER,
    volume REAL,
    primary_muscle text,
    secondary_muscle text, 
    movement_pattern text, 
    hyrox_relevance text, 
    body_region text
);

--DROP TABLE IF EXISTS exercise_summary;

CREATE TABLE exercise_summary AS
SELECT
    h.date,
    h.exercise_name,
    h.weight_lbs,
    h.reps,
    m.primary_muscle,
    m.secondary_muscle,
    m.movement_pattern,
    m.hyrox_relevance,
    m.body_region
FROM clean_hevy h
JOIN exercise_muscle_map m 
    ON h.exercise_name = m.exercise_name

--Creating Athlete fingerprint
--Create a general outline and fill in information from different charts to create maps of each data type for analytics
CREATE TABLE athlete_profile (
    profile_type text,
    category text, 
    total_sets INTEGER, 
    total_reps INTEGER, 
    total_volume REAL, 
    training_day_week INTEGER, 
    last_trained_date text
);

--Leaderboard outline/structure
-- Insert values into these columns
INSERT INTO athlete_profile (
    profile_type,
    category, 
    total_sets, 
    total_reps, 
    total_volume, 
    training_day_week, 
    last_trained_date

    'exercise' AS profile_type --Labels every row in profile_type as exercise, data type
    exercise_name AS category 
    COUNT(*) AS total_sets 
)