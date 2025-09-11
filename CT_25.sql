SHOW DATABASES
Create database CT_2025
USE CT_2025
SHOW TABLES
-- First create teams table
CREATE TABLE teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL UNIQUE,
    team_code VARCHAR(3) NOT NULL UNIQUE,
    group_name VARCHAR(1)
) AUTO_INCREMENT = 1;

-- Then create venues table
CREATE TABLE venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    capacity INT
) AUTO_INCREMENT = 1;

-- Then create players table with compatible foreign key
CREATE TABLE players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT NOT NULL,
    player_name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    batting_style VARCHAR(50),
    bowling_style VARCHAR(50),
    is_captain BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE
) AUTO_INCREMENT = 1;

-- Then create matches table
CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    match_number INT NOT NULL,
    match_date DATE NOT NULL,
    venue_id INT,
    team1_id INT,
    team2_id INT,
    winner_id INT,
    match_type VARCHAR(20),
    start_time TIME,
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id) ON DELETE SET NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(team_id) ON DELETE SET NULL,
    FOREIGN KEY (team2_id) REFERENCES teams(team_id) ON DELETE SET NULL,
    FOREIGN KEY (winner_id) REFERENCES teams(team_id) ON DELETE SET NULL
) AUTO_INCREMENT = 1;

-- Create points table
CREATE TABLE points_table (
    team_id INT PRIMARY KEY,
    matches_played INT DEFAULT 0,
    wins INT DEFAULT 0,
    losses INT DEFAULT 0,
    no_results INT DEFAULT 0,
    points INT DEFAULT 0,
    net_run_rate DECIMAL(5,3) DEFAULT 0.000,
    FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE
);


-- Create match_results table
CREATE TABLE match_results (
    match_id INT PRIMARY KEY,
    team1_score INT,
    team1_wickets INT,
    team1_overs DECIMAL(4,1),
    team2_score INT,
    team2_wickets INT,
    team2_overs DECIMAL(4,1),
    toss_winner_id INT,
    toss_decision VARCHAR(10),
    player_of_match INT,
    FOREIGN KEY (match_id) REFERENCES matches(match_id) ON DELETE CASCADE,
    FOREIGN KEY (toss_winner_id) REFERENCES teams(team_id) ON DELETE SET NULL,
    FOREIGN KEY (player_of_match) REFERENCES players(player_id) ON DELETE SET NULL
);

-- Insert Teams
-- Insert Updated Teams including Afghanistan and South Africa
INSERT INTO teams (team_name, team_code, group_name) VALUES
('India', 'IND', 'A'),
('Pakistan', 'PAK', 'A'),
('Bangladesh', 'BAN', 'A'),
('New Zealand', 'NZ', 'A'),
('Australia', 'AUS', 'B'),
('England', 'ENG', 'B'),
('Afghanistan', 'AFG', 'B'),
('South Africa', 'SA', 'B');


select * from teams
-- Insert Venues
INSERT INTO venues (venue_name, city, country, capacity) VALUES
('Gaddafi Stadium', 'Lahore', 'Pakistan', 27000),
('Rawalpindi Cricket Stadium', 'Rawalpindi', 'Pakistan', 25000),
('National Stadium', 'Karachi', 'Pakistan', 34228),
('Dubai International Cricket Stadium','Dubai','UAE',35000);

-- Insert Complete Matches Schedule for Champions Trophy 2025
INSERT INTO matches (match_number, match_date, venue_id, team1_id, team2_id, match_type, start_time) VALUES
-- Group Stage Matches
(1, '2025-02-19', 3, 2, 4, 'Group Stage', '14:30:00'),  -- PAK vs NZ (National Stadium, Karachi)
(2, '2025-02-20', 4, 3, 1, 'Group Stage', '14:30:00'),  -- BAN vs IND (Dubai International Stadium)
(3, '2025-02-21', 3, 7, 8, 'Group Stage', '14:30:00'),  -- AFG vs SA (National Stadium, Karachi)
(4, '2025-02-22', 1, 5, 6, 'Group Stage', '14:30:00'),  -- AUS vs ENG (Gaddafi Stadium, Lahore)
(5, '2025-02-23', 4, 2, 1, 'Group Stage', '14:30:00'),  -- PAK vs IND (Dubai International Stadium)
(6, '2025-02-24', 2, 3, 4, 'Group Stage', '14:30:00'),  -- BAN vs NZ (Rawalpindi Cricket Stadium)
(7, '2025-02-25', 2, 5, 8, 'Group Stage', '14:30:00'),  -- AUS vs SA (Rawalpindi Cricket Stadium)
(8, '2025-02-26', 1, 7, 6, 'Group Stage', '14:30:00'),  -- AFG vs ENG (Gaddafi Stadium, Lahore)
(9, '2025-02-27', 2, 2, 3, 'Group Stage', '14:30:00'),  -- PAK vs BAN (Rawalpindi Cricket Stadium)
(10, '2025-02-28', 1, 7, 5, 'Group Stage', '14:30:00'), -- AFG vs AUS (Gaddafi Stadium, Lahore)
(11, '2025-03-01', 3, 8, 6, 'Group Stage', '14:30:00'), -- SA vs ENG (National Stadium, Karachi)
(12, '2025-03-02', 4, 4, 1, 'Group Stage', '14:30:00'), -- NZ vs IND (Dubai International Stadium)
-- Semi-Finals
(13, '2025-03-04', 4, NULL, NULL, 'Semi-Final 1', '14:30:00'),  -- A1 vs B2 (Dubai International Stadium)
(14, '2025-03-05', 1, NULL, NULL, 'Semi-Final 2', '14:30:00'),  -- B1 vs A2 (Gaddafi Stadium, Lahore)
-- Final
(15, '2025-03-09', 4, NULL, NULL, 'Final', '14:30:00');  -- Dubai International Stadium

-- Insert Players Data
-- India Players
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(1, 'Rohit Sharma (c)', 'Batsman', 'Right-handed', 'Right-arm offbreak', TRUE),
(1, 'Virat Kohli', 'Batsman', 'Right-handed', 'Right-arm medium', FALSE),
(1, 'KL Rahul', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(1, 'Rishabh Pant', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(1, 'Suryakumar Yadav', 'Batsman', 'Right-handed', 'Right-arm medium', FALSE),
(1, 'Hardik Pandya', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(1, 'Ravindra Jadeja', 'All-rounder', 'Left-handed', 'Left-arm orthodox', FALSE),
(1, 'Jasprit Bumrah', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(1, 'Mohammed Shami', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(1, 'Kuldeep Yadav', 'Bowler', 'Right-handed', 'Left-arm wrist spin', FALSE),
(1, 'Mohammed Siraj', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE);

-- Pakistan Players
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(2, 'Babar Azam (c)', 'Batsman', 'Right-handed', 'Right-arm offbreak', TRUE),
(2, 'Mohammad Rizwan', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(2, 'Fakhar Zaman', 'Batsman', 'Left-handed', 'Slow left-arm orthodox', FALSE),
(2, 'Imam-ul-Haq', 'Batsman', 'Left-handed', NULL, FALSE),
(2, 'Iftikhar Ahmed', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(2, 'Shadab Khan', 'All-rounder', 'Right-handed', 'Right-arm legbreak', FALSE),
(2, 'Shaheen Afridi', 'Bowler', 'Left-handed', 'Left-arm fast', FALSE),
(2, 'Haris Rauf', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(2, 'Naseem Shah', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(2, 'Mohammad Nawaz', 'All-rounder', 'Left-handed', 'Left-arm orthodox', FALSE);

-- Complete Bangladesh Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(3, 'Shakib Al Hasan (c)', 'All-rounder', 'Left-handed', 'Left-arm orthodox', TRUE),
(3, 'Litton Das', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(3, 'Najmul Hossain Shanto', 'Batsman', 'Left-handed', 'Right-arm offbreak', FALSE),
(3, 'Mushfiqur Rahim', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(3, 'Mahmudullah', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(3, 'Taskin Ahmed', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(3, 'Mustafizur Rahman', 'Bowler', 'Left-handed', 'Left-arm fast-medium', FALSE),
(3, 'Mehidy Hasan Miraz', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(3, 'Towhid Hridoy', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(3, 'Afif Hossain', 'All-rounder', 'Left-handed', 'Right-arm offbreak', FALSE),
(3, 'Hasan Mahmud', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE),
(3, 'Shoriful Islam', 'Bowler', 'Left-handed', 'Left-arm fast-medium', FALSE),
(3, 'Nasum Ahmed', 'Bowler', 'Left-handed', 'Left-arm orthodox', FALSE),
(3, 'Tanzid Hasan Tamim', 'Batsman', 'Left-handed', NULL, FALSE),
(3, 'Rishad Hossain', 'Bowler', 'Right-handed', 'Right-arm legbreak', FALSE),
(3, 'Tanzim Hasan Sakib', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE);

-- Complete New Zealand Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(4, 'Kane Williamson (c)', 'Batsman', 'Right-handed', 'Right-arm offbreak', TRUE),
(4, 'Devon Conway', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(4, 'Trent Boult', 'Bowler', 'Right-handed', 'Left-arm fast', FALSE),
(4, 'Tim Southee', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE),
(4, 'Glenn Phillips', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(4, 'Daryl Mitchell', 'All-rounder', 'Right-handed', 'Right-arm medium', FALSE),
(4, 'Mitchell Santner', 'All-rounder', 'Left-handed', 'Left-arm orthodox', FALSE),
(4, 'Tom Latham', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(4, 'Lockie Ferguson', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(4, 'Matt Henry', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE),
(4, 'Ish Sodhi', 'Bowler', 'Right-handed', 'Right-arm legbreak', FALSE),
(4, 'Finn Allen', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(4, 'Rachin Ravindra', 'All-rounder', 'Left-handed', 'Left-arm orthodox', FALSE),
(4, 'Will Young', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(4, 'Adam Milne', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(4, 'Mark Chapman', 'Batsman', 'Left-handed', 'Slow left-arm orthodox', FALSE);

-- Complete Australia Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(5, 'Pat Cummins (c)', 'Bowler', 'Right-handed', 'Right-arm fast', TRUE),
(5, 'Steve Smith', 'Batsman', 'Right-handed', 'Right-arm legbreak', FALSE),
(5, 'David Warner', 'Batsman', 'Left-handed', 'Right-arm legbreak', FALSE),
(5, 'Mitchell Starc', 'Bowler', 'Left-handed', 'Left-arm fast', FALSE),
(5, 'Josh Hazlewood', 'Bowler', 'Left-handed', 'Right-arm fast-medium', FALSE),
(5, 'Glenn Maxwell', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(5, 'Mitchell Marsh', 'All-rounder', 'Right-handed', 'Right-arm medium', FALSE),
(5, 'Alex Carey', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(5, 'Travis Head', 'Batsman', 'Left-handed', 'Right-arm offbreak', FALSE),
(5, 'Marnus Labuschagne', 'Batsman', 'Right-handed', 'Right-arm legbreak', FALSE),
(5, 'Adam Zampa', 'Bowler', 'Right-handed', 'Right-arm legbreak', FALSE),
(5, 'Cameron Green', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(5, 'Marcus Stoinis', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(5, 'Josh Inglis', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(5, 'Sean Abbott', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE),
(5, 'Nathan Ellis', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE);

-- Complete England Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(6, 'Jos Buttler (c)', 'Wicketkeeper-Batsman', 'Right-handed', NULL, TRUE),
(6, 'Ben Stokes', 'All-rounder', 'Left-handed', 'Right-arm fast-medium', FALSE),
(6, 'Joe Root', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(6, 'Jofra Archer', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(6, 'Mark Wood', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(6, 'Jonny Bairstow', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(6, 'Dawid Malan', 'Batsman', 'Left-handed', 'Right-arm legbreak', FALSE),
(6, 'Liam Livingstone', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(6, 'Sam Curran', 'All-rounder', 'Left-handed', 'Left-arm fast-medium', FALSE),
(6, 'Chris Woakes', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(6, 'Adil Rashid', 'Bowler', 'Right-handed', 'Right-arm legbreak', FALSE),
(6, 'Moeen Ali', 'All-rounder', 'Left-handed', 'Right-arm offbreak', FALSE),
(6, 'Harry Brook', 'Batsman', 'Right-handed', 'Right-arm medium', FALSE),
(6, 'Reece Topley', 'Bowler', 'Right-handed', 'Left-arm fast-medium', FALSE),
(6, 'Gus Atkinson', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(6, 'Phil Salt', 'Batsman', 'Right-handed', NULL, FALSE);

-- Complete South Africa Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(8, 'Aiden Markram (c)', 'Batsman', 'Right-handed', 'Right-arm offbreak', TRUE),
(8, 'Quinton de Kock', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(8, 'Temba Bavuma', 'Batsman', 'Right-handed', NULL, FALSE),
(8, 'Rassie van der Dussen', 'Batsman', 'Right-handed', 'Right-arm legbreak', FALSE),
(8, 'David Miller', 'Batsman', 'Left-handed', 'Right-arm offbreak', FALSE),
(8, 'Heinrich Klaasen', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(8, 'Marco Jansen', 'All-rounder', 'Left-handed', 'Left-arm fast-medium', FALSE),
(8, 'Kagiso Rabada', 'Bowler', 'Left-handed', 'Right-arm fast', FALSE),
(8, 'Anrich Nortje', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(8, 'Keshav Maharaj', 'Bowler', 'Right-handed', 'Left-arm orthodox', FALSE),
(8, 'Tabraiz Shamsi', 'Bowler', 'Right-handed', 'Left-arm wrist spin', FALSE),
(8, 'Lungi Ngidi', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(8, 'Andile Phehlukwayo', 'All-rounder', 'Left-handed', 'Right-arm fast-medium', FALSE),
(8, 'Reeza Hendricks', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE),
(8, 'Gerald Coetzee', 'Bowler', 'Right-handed', 'Right-arm fast', FALSE),
(8, 'Tristan Stubbs', 'Batsman', 'Right-handed', 'Right-arm offbreak', FALSE);

-- Complete Afghanistan Players Insertion
INSERT INTO players (team_id, player_name, role, batting_style, bowling_style, is_captain) VALUES
(7, 'Rashid Khan (c)', 'Bowler', 'Right-handed', 'Right-arm legbreak', TRUE),
(7, 'Mohammad Nabi', 'All-rounder', 'Right-handed', 'Right-arm offbreak', FALSE),
(7, 'Rahmanullah Gurbaz', 'Wicketkeeper-Batsman', 'Right-handed', NULL, FALSE),
(7, 'Ibrahim Zadran', 'Batsman', 'Right-handed', NULL, FALSE),
(7, 'Hashmatullah Shahidi', 'Batsman', 'Left-handed', 'Right-arm offbreak', FALSE),
(7, 'Azmatullah Omarzai', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(7, 'Najibullah Zadran', 'Batsman', 'Left-handed', 'Right-arm offbreak', FALSE),
(7, 'Mujeeb Ur Rahman', 'Bowler', 'Right-handed', 'Right-arm offbreak', FALSE),
(7, 'Fazalhaq Farooqi', 'Bowler', 'Right-handed', 'Left-arm fast-medium', FALSE),
(7, 'Naveen-ul-Haq', 'Bowler', 'Right-handed', 'Right-arm fast-medium', FALSE),
(7, 'Gulbadin Naib', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(7, 'Rahmat Shah', 'Batsman', 'Right-handed', 'Right-arm legbreak', FALSE),
(7, 'Ikram Alikhil', 'Wicketkeeper-Batsman', 'Left-handed', NULL, FALSE),
(7, 'Karim Janat', 'All-rounder', 'Right-handed', 'Right-arm fast-medium', FALSE),
(7, 'Noor Ahmad', 'Bowler', 'Right-handed', 'Left-arm wrist spin', FALSE),
(7, 'Qais Ahmad', 'Bowler', 'Right-handed', 'Right-arm legbreak', FALSE);



-- Initialize Points Table
INSERT INTO points_table (team_id, matches_played, wins, losses, no_results, points, net_run_rate) VALUES
(1, 0, 0, 0, 0, 0, 0.000),
(2, 0, 0, 0, 0, 0, 0.000),
(3, 0, 0, 0, 0, 0, 0.000),
(4, 0, 0, 0, 0, 0, 0.000),
(5, 0, 0, 0, 0, 0, 0.000),
(6, 0, 0, 0, 0, 0, 0.000);

-- Insert Complete Match Results for Champions Trophy 2025
INSERT INTO match_results (match_id, team1_score, team1_wickets, team1_overs, team2_score, team2_wickets, team2_overs, toss_winner_id, toss_decision, player_of_match) VALUES
-- Match 1: PAK vs NZ
(1, 285, 7, 50.0, 225, 10, 45.2, 4, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Kane Williamson%')),  -- NZ won by 60 runs

-- Match 2: BAN vs IND
(2, 245, 8, 50.0, 246, 4, 48.1, 3, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Virat Kohli%')),  -- IND won by 6 wkts

-- Match 3: AFG vs SA
(3, 198, 10, 45.3, 305, 6, 50.0, 8, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Quinton de Kock%')),  -- SA won by 107 runs

-- Match 4: AUS vs ENG
(4, 285, 9, 50.0, 286, 5, 48.2, 6, 'field', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Steve Smith%')),  -- AUS won by 5 wkts

-- Match 5: PAK vs IND
(5, 275, 8, 50.0, 276, 4, 48.3, 2, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Rohit Sharma%')),  -- IND won by 6 wkts

-- Match 6: BAN vs NZ
(6, 230, 10, 49.1, 231, 5, 47.2, 4, 'field', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Trent Boult%')),  -- NZ won by 5 wkts

-- Match 7: AUS vs SA - Match abandoned due to rain
(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),  -- No toss

-- Match 8: AFG vs ENG
(8, 265, 7, 50.0, 257, 10, 49.4, 7, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Rashid Khan%')),  -- AFG won by 8 runs

-- Match 9: PAK vs BAN - Match abandoned due to rain
(9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),  -- No toss

-- Match 10: AFG vs AUS - No result due to rain
(10, 185, 6, 35.0, NULL, NULL, NULL, 5, 'field', NULL),  -- Rain affected

-- Match 11: SA vs ENG
(11, 295, 6, 50.0, 296, 3, 47.1, 8, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Aiden Markram%')),  -- SA won by 7 wkts

-- Match 12: NZ vs IND
(12, 315, 8, 50.0, 271, 10, 45.3, 4, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Jasprit Bumrah%')),  -- IND won by 44 runs

-- Semi-Final 1: IND vs AUS
(13, 325, 6, 50.0, 326, 6, 49.2, 5, 'field', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Virat Kohli%')),  -- IND won by 4 wkts

-- Semi-Final 2: SA vs NZ
(14, 280, 10, 49.3, 230, 10, 45.1, 8, 'bat', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Trent Boult%')),  -- NZ won by 50 runs

-- Final: IND vs NZ
(15, 325, 7, 50.0, 326, 6, 49.1, 4, 'field', 
 (SELECT player_id FROM players WHERE player_name LIKE 'Rohit Sharma%'));  -- IND won by 4 wkts
 
 -- Update match winners
UPDATE matches SET winner_id = 4 WHERE match_id = 1;   -- NZ won
UPDATE matches SET winner_id = 1 WHERE match_id = 2;   -- IND won
UPDATE matches SET winner_id = 8 WHERE match_id = 3;   -- SA won
UPDATE matches SET winner_id = 5 WHERE match_id = 4;   -- AUS won
UPDATE matches SET winner_id = 1 WHERE match_id = 5;   -- IND won
UPDATE matches SET winner_id = 4 WHERE match_id = 6;   -- NZ won
UPDATE matches SET winner_id = NULL WHERE match_id = 7; -- No result
UPDATE matches SET winner_id = 7 WHERE match_id = 8;   -- AFG won
UPDATE matches SET winner_id = NULL WHERE match_id = 9; -- No result
UPDATE matches SET winner_id = NULL WHERE match_id = 10; -- No result
UPDATE matches SET winner_id = 8 WHERE match_id = 11;  -- SA won
UPDATE matches SET winner_id = 1 WHERE match_id = 12;  -- IND won
UPDATE matches SET winner_id = 1 WHERE match_id = 13;  -- IND won (SF1)
UPDATE matches SET winner_id = 4 WHERE match_id = 14;  -- NZ won (SF2)
UPDATE matches SET winner_id = 1 WHERE match_id = 15;  -- IND won (Final)

-- Update points table (simplified version)
UPDATE points_table SET 
    matches_played = 3, wins = 2, losses = 1, points = 4, net_run_rate = 0.850
WHERE team_id = 1;  -- India

UPDATE points_table SET 
    matches_played = 3, wins = 1, losses = 1, no_results = 1, points = 3, net_run_rate = 0.350
WHERE team_id = 2;  -- Pakistan

UPDATE points_table SET 
    matches_played = 3, wins = 1, losses = 1, no_results = 1, points = 3, net_run_rate = -0.250
WHERE team_id = 3;  -- Bangladesh

UPDATE points_table SET 
    matches_played = 3, wins = 2, losses = 1, points = 4, net_run_rate = 0.650
WHERE team_id = 4;  -- New Zealand

UPDATE points_table SET 
    matches_played = 3, wins = 1, losses = 1, no_results = 1, points = 3, net_run_rate = 0.450
WHERE team_id = 5;  -- Australia

UPDATE points_table SET 
    matches_played = 3, wins = 1, losses = 2, points = 2, net_run_rate = -0.150
WHERE team_id = 6;  -- England

UPDATE points_table SET 
    matches_played = 3, wins = 1, losses = 1, no_results = 1, points = 3, net_run_rate = 0.200
WHERE team_id = 7;  -- Afghanistan

UPDATE points_table SET 
    matches_played = 3, wins = 2, losses = 1, points = 4, net_run_rate = 0.750
WHERE team_id = 8;  -- South Africa

#Question: Show the complete points table with team performance metrics including win percentage.

SELECT 
    t.team_name,
    t.team_code,
    t.group_name,
    p.matches_played,
    p.wins,
    p.losses,
    p.no_results,
    p.points,
    p.net_run_rate,
    ROUND((p.wins * 100.0 / NULLIF(p.matches_played - p.no_results, 0)), 2) as win_percentage,
    RANK() OVER (ORDER BY p.points DESC, p.net_run_rate DESC) as tournament_rank
FROM points_table p
JOIN teams t ON p.team_id = t.team_id
ORDER BY p.points DESC, p.net_run_rate DESC;

#Who are the top 10 batsmen with the best batting averages?
WITH batting_stats AS (
    SELECT 
        p.player_name,
        t.team_name,
        COUNT(DISTINCT m.match_id) as matches,
        SUM(CASE WHEN mr.team1_id = p.team_id THEN mr.team1_score ELSE mr.team2_score END) as total_runs,
        ROUND(AVG(CASE WHEN mr.team1_id = p.team_id THEN mr.team1_score ELSE mr.team2_score END), 2) as batting_avg
    FROM players p
    JOIN teams t ON p.team_id = t.team_id
    JOIN matches m ON p.team_id IN (m.team1_id, m.team2_id)
    JOIN match_results mr ON m.match_id = mr.match_id
    WHERE p.role IN ('Batsman', 'Wicketkeeper-Batsman', 'All-rounder')
    GROUP BY p.player_id, p.player_name, t.team_name
    HAVING total_runs >= 100
)
SELECT 
    player_name,
    team_name,
    matches,
    total_runs,
    batting_avg,
    RANK() OVER (ORDER BY batting_avg DESC) as rank
FROM batting_stats
ORDER BY batting_avg DESC
LIMIT 10;

 #Show all match results with venue statistics and team performance.


SELECT 
    m.match_number,
    m.match_date,
    v.venue_name,
    v.city,
    t1.team_name as team1,
    t2.team_name as team2,
    mr.team1_score || '/' || mr.team1_wickets as team1_score,
    mr.team2_score || '/' || mr.team2_wickets as team2_score,
    tw.team_name as winner,
    mr.toss_winner_id,
    mr.toss_decision,
    (SELECT player_name FROM players WHERE player_id = mr.player_of_match) as player_of_match,
    CASE 
        WHEN mr.team1_score > mr.team2_score THEN mr.team1_score - mr.team2_score
        ELSE mr.team2_score - mr.team1_score
    END as margin,
    ROUND(AVG(mr.team1_score + mr.team2_score) OVER (PARTITION BY m.venue_id), 2) as avg_runs_at_venue
FROM matches m
JOIN venues v ON m.venue_id = v.venue_id
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
JOIN match_results mr ON m.match_id = mr.match_id
LEFT JOIN teams tw ON m.winner_id = tw.team_id
ORDER BY m.match_date;

#How does each team perform at different venues?


SELECT 
    t.team_name,
    v.venue_name,
    COUNT(m.match_id) as matches_played,
    SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN m.winner_id IS NULL THEN 1 ELSE 0 END) as no_results,
    ROUND(SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) * 100.0 / 
          NULLIF(COUNT(m.match_id) - SUM(CASE WHEN m.winner_id IS NULL THEN 1 ELSE 0 END), 0), 2) as win_percentage,
    ROUND(AVG(CASE 
        WHEN m.team1_id = t.team_id THEN mr.team1_score 
        ELSE mr.team2_score 
    END), 2) as avg_runs_scored,
    ROUND(AVG(CASE 
        WHEN m.team1_id = t.team_id THEN mr.team2_score 
        ELSE mr.team1_score 
    END), 2) as avg_runs_conceded
FROM teams t
JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
JOIN venues v ON m.venue_id = v.venue_id
JOIN match_results mr ON m.match_id = mr.match_id
GROUP BY t.team_id, t.team_name, v.venue_id, v.venue_name
HAVING COUNT(m.match_id) >= 1
ORDER BY t.team_name, win_percentage DESC;

#Which players won the most Player of Match awards and for which teams?

SELECT 
    p.player_name,
    t.team_name,
    p.role,
    COUNT(mr.player_of_match) as potm_awards,
    STRING_AGG(DISTINCT m.match_number::text, ', ') as match_numbers, #error
    ROUND(COUNT(mr.player_of_match) * 100.0 / COUNT(DISTINCT m.match_id), 2) as award_percentage
FROM players p
JOIN teams t ON p.team_id = t.team_id
JOIN match_results mr ON p.player_id = mr.player_of_match
JOIN matches m ON mr.match_id = m.match_id
GROUP BY p.player_id, p.player_name, t.team_name, p.role
HAVING COUNT(mr.player_of_match) >= 1
ORDER BY potm_awards DESC, award_percentage DESC;

#How does winning the toss affect match outcomes?

SELECT 
    toss_decision,
    COUNT(*) as total_matches,
    SUM(CASE WHEN m.winner_id = mr.toss_winner_id THEN 1 ELSE 0 END) as wins_after_toss,
    ROUND(SUM(CASE WHEN m.winner_id = mr.toss_winner_id THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as win_percentage,
    AVG(CASE 
        WHEN m.winner_id = mr.toss_winner_id THEN 1 ELSE 0 
    END) as win_probability
FROM matches m
JOIN match_results mr ON m.match_id = mr.match_id
WHERE mr.toss_winner_id IS NOT NULL AND m.winner_id IS NOT NULL
GROUP BY mr.toss_decision
ORDER BY win_percentage DESC;

#What are the highest team scores in the tournament?

WITH team_scores AS (
    SELECT 
        m.match_id,
        m.match_date,
        t.team_name,
        v.venue_name,
        CASE WHEN m.team1_id = t.team_id THEN mr.team1_score ELSE mr.team2_score END as team_score,
        CASE WHEN m.team1_id = t.team_id THEN mr.team1_wickets ELSE mr.team2_wickets END as wickets,
        CASE WHEN m.team1_id = t.team_id THEN mr.team1_overs ELSE mr.team2_overs END as overs,
        m.winner_id = t.team_id as won_match
    FROM teams t
    JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
    JOIN match_results mr ON m.match_id = mr.match_id
    JOIN venues v ON m.venue_id = v.venue_id
    WHERE CASE WHEN m.team1_id = t.team_id THEN mr.team1_score ELSE mr.team2_score END IS NOT NULL
)
SELECT 
    match_date,
    team_name,
    venue_name,
    team_score,
    wickets,
    overs,
    CASE WHEN won_match THEN 'Won' ELSE 'Lost' END as result,
    RANK() OVER (ORDER BY team_score DESC) as rank1
FROM team_scores
ORDER BY team_score DESC
LIMIT 10;

#How are player roles distributed across different teams?

SELECT 
    t.team_name,
    COUNT(*) as total_players,
    SUM(CASE WHEN p.role = 'Batsman' THEN 1 ELSE 0 END) as batsmen,
    SUM(CASE WHEN p.role = 'Bowler' THEN 1 ELSE 0 END) as bowlers,
    SUM(CASE WHEN p.role = 'All-rounder' THEN 1 ELSE 0 END) as all_rounders,
    SUM(CASE WHEN p.role LIKE '%Wicketkeeper%' THEN 1 ELSE 0 END) as wicketkeepers,
    ROUND(SUM(CASE WHEN p.role = 'All-rounder' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as all_rounder_percentage
FROM players p
JOIN teams t ON p.team_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY all_rounder_percentage DESC;

#How do teams perform under different captains?


SELECT 
    t.team_name,
    p.player_name as captain,
    COUNT(DISTINCT m.match_id) as matches_captained,
    SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN m.winner_id IS NULL THEN 1 ELSE 0 END) as no_results,
    ROUND(SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) * 100.0 / 
          NULLIF(COUNT(DISTINCT m.match_id) - SUM(CASE WHEN m.winner_id IS NULL THEN 1 ELSE 0 END), 0), 2) as win_percentage
FROM players p
JOIN teams t ON p.team_id = t.team_id
JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
WHERE p.is_captain = TRUE
GROUP BY t.team_id, t.team_name, p.player_name
ORDER BY win_percentage DESC;

#Which venues are high-scoring and which are bowler-friendly?


SELECT 
    v.venue_name,
    v.city,
    COUNT(m.match_id) as total_matches,
    ROUND(AVG(mr.team1_score + mr.team2_score), 2) as avg_total_runs,
    ROUND(AVG((mr.team1_score / mr.team1_overs) + (mr.team2_score / mr.team2_overs)) / 2, 2) as avg_run_rate,
    ROUND(AVG(mr.team1_wickets + mr.team2_wickets), 2) as avg_wickets_per_match,
    CASE 
        WHEN AVG(mr.team1_score + mr.team2_score) > 500 THEN 'Batting Paradise'
        WHEN AVG(mr.team1_score + mr.team2_score) > 450 THEN 'Good for Batting'
        WHEN AVG(mr.team1_score + mr.team2_score) > 400 THEN 'Balanced'
        ELSE 'Bowler Friendly'
    END as venue_characteristic
FROM venues v
JOIN matches m ON v.venue_id = m.venue_id
JOIN match_results mr ON m.match_id = mr.match_id
GROUP BY v.venue_id, v.venue_name, v.city
HAVING COUNT(m.match_id) >= 2
ORDER BY avg_total_runs DESC;

#Can we predict match outcomes based on first innings score?


WITH match_stats AS (
    SELECT 
        m.match_id,
        CASE WHEN m.team1_id = m.winner_id THEN mr.team1_score 
             WHEN m.team2_id = m.winner_id THEN mr.team2_score 
        END as winning_score,
        CASE WHEN m.team1_id = m.winner_id THEN mr.team2_score 
             WHEN m.team2_id = m.winner_id THEN mr.team1_score 
        END as losing_score,
        CASE WHEN m.team1_id = m.winner_id THEN mr.team1_overs 
             WHEN m.team2_id = m.winner_id THEN mr.team2_overs 
        END as winning_overs,
        ABS(mr.team1_score - mr.team2_score) as margin
    FROM matches m
    JOIN match_results mr ON m.match_id = mr.match_id
    WHERE m.winner_id IS NOT NULL
)
SELECT 
    CASE 
        WHEN winning_score BETWEEN 200 AND 250 THEN '200-250'
        WHEN winning_score BETWEEN 251 AND 300 THEN '251-300'
        WHEN winning_score BETWEEN 301 AND 350 THEN '301-350'
        ELSE '350+'
    END as score_range,
    COUNT(*) as total_matches,
    ROUND(AVG(margin), 2) as avg_winning_margin,
    ROUND(AVG(winning_overs), 2) as avg_overs_taken,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as percentage_of_matches
FROM match_stats
GROUP BY score_range
ORDER BY score_range;

#Which players are the most consistent performers?


WITH player_performance AS (
    SELECT 
        p.player_id,
        p.player_name,
        t.team_name,
        p.role,
        COUNT(DISTINCT m.match_id) as matches_played,
        AVG(CASE 
            WHEN m.team1_id = p.team_id THEN mr.team1_score 
            ELSE mr.team2_score 
        END) as avg_team_contribution,
        COUNT(mr.player_of_match) as potm_awards,
        STDDEV(CASE 
            WHEN m.team1_id = p.team_id THEN mr.team1_score 
            ELSE mr.team2_score 
        END) as performance_stddev
    FROM players p
    JOIN teams t ON p.team_id = t.team_id
    JOIN matches m ON p.team_id IN (m.team1_id, m.team2_id)
    JOIN match_results mr ON m.match_id = mr.match_id
    GROUP BY p.player_id, p.player_name, t.team_name, p.role
    HAVING COUNT(DISTINCT m.match_id) >= 3
)
SELECT 
    player_name,
    team_name,
    role,
    matches_played,
    ROUND(avg_team_contribution, 2) as avg_contribution,
    potm_awards,
    ROUND(performance_stddev, 2) as consistency_score,
    RANK() OVER (ORDER BY performance_stddev ASC, potm_awards DESC) as consistency_rank
FROM player_performance
ORDER BY consistency_score ASC
LIMIT 15;

-- Comprehensive match results verification
SELECT 
    m.match_id,
    m.match_number,
    m.match_date,
    m.match_type,
    t1.team_name as team1,
    t2.team_name as team2,
    CONCAT(mr.team1_score, '/', mr.team1_wickets) as team1_score,
    CONCAT('(', mr.team1_overs, ' ov)') as team1_overs,
    CONCAT(mr.team2_score, '/', mr.team2_wickets) as team2_score,
    CONCAT('(', mr.team2_overs, ' ov)') as team2_overs,
    tw.team_name as winner,
    mr.toss_decision,
    toss_team.team_name as toss_winner,
    p.player_name as player_of_match,
    CASE 
        WHEN m.winner_id IS NULL THEN 'No Result'
        WHEN m.winner_id = m.team1_id THEN CONCAT(t1.team_name, ' won by ', 
            CASE 
                WHEN mr.team2_score < mr.team1_score THEN CONCAT(mr.team1_score - mr.team2_score, ' runs')
                ELSE CONCAT(10 - mr.team2_wickets, ' wickets')
            END)
        ELSE CONCAT(t2.team_name, ' won by ',
            CASE 
                WHEN mr.team1_score < mr.team2_score THEN CONCAT(mr.team2_score - mr.team1_score, ' runs')
                ELSE CONCAT(10 - mr.team1_wickets, ' wickets')
            END)
    END as result_summary
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
JOIN match_results mr ON m.match_id = mr.match_id
LEFT JOIN teams tw ON m.winner_id = tw.team_id
LEFT JOIN teams toss_team ON mr.toss_winner_id = toss_team.team_id
LEFT JOIN players p ON mr.player_of_match = p.player_id
ORDER BY m.match_date, m.match_number;


#Match Statistics Summary Query
-- Overall tournament match statistics
SELECT 
    'Total Matches' as statistic,
    COUNT(*) as value
FROM matches

UNION ALL

SELECT 
    'Completed Matches',
    COUNT(*) 
FROM matches 
WHERE winner_id IS NOT NULL

UNION ALL

SELECT 
    'Rain-affected Matches',
    COUNT(*) 
FROM matches 
WHERE winner_id IS NULL

UNION ALL

SELECT 
    'Total Runs Scored',
    SUM(team1_score + team2_score) 
FROM match_results 
WHERE team1_score IS NOT NULL

UNION ALL

SELECT 
    'Average Match Score',
    ROUND(AVG(team1_score + team2_score), 2) 
FROM match_results 
WHERE team1_score IS NOT NULL

UNION ALL

SELECT 
    'Highest Team Score',
    MAX(GREATEST(team1_score, team2_score)) 
FROM match_results

UNION ALL

SELECT 
    'Most Player of Match Awards',
    (SELECT COUNT(*) FROM match_results mr
     JOIN players p ON mr.player_of_match = p.player_id
     GROUP BY p.player_id
     ORDER BY COUNT(*) DESC
     LIMIT 1);
