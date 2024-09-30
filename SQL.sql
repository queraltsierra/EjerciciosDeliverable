DROP TABLE IF EXISTS match_player, match, player;

CREATE TABLE player (
    player_id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50)
);

CREATE TABLE match (
    match_id SERIAL PRIMARY KEY,
    match_finish_time TIMESTAMP,
    duration INTEGER,
    winner_id INT REFERENCES player(player_id)
);

CREATE TABLE match_player (
    player_id INT REFERENCES player(player_id),
    match_id INT REFERENCES match(match_id),
    PRIMARY KEY (player_id, match_id)
);

-- Insert players
INSERT INTO player (username, password) VALUES ('player1', 'pass1'), ('player2', 'pass2'), ('player3', 'pass3');

-- Insert matches
INSERT INTO match (match_finish_time, duration, winner_id) VALUES
('2024-09-25 10:00:00', 60, 1),
('2024-09-25 12:00:00', 90, 2);

-- Insert player-match associations
INSERT INTO match_player (player_id, match_id) VALUES
(1, 1),
(2, 1),
(1, 2),
(3, 2);
