-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Finds all events that occured on July 28, 2020 on Chamberlin St.
SELECT description
FROM crime_scene_reports
WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND (street = "Chamberlin Street");


-- get info about interviews that mention "courthouse"
SELECT name, id, transcript
FROM interviews
WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND transcript LIKE "%courthouse%";

-- Info from courthouse logs, 10 minutes after theft:
SELECT id, activity, license_plate
FROM courthouse_security_logs
WHERE (activity = "exit")
AND (hour = 10)
AND (minute > 15)
AND (minute < 25)
AND (year = 2020)
AND (month = 7)
AND (day = 28);

-- info from ATM transactions based on interview info
SELECT id, account_number, transaction_type, amount
FROM atm_transactions
WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND (atm_location = "Fifer Street");


-- finds phone calls less than a minute duration on Jul7 28,2020
SELECT id, caller, receiver
FROM phone_calls
WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND (duration < 60);


--finds caller's info
SELECT id, name, passport_number, license_plate FROM people
WHERE phone_number
IN (SELECT caller FROM phone_calls WHERE (year = 2020) AND (month = 7) AND (day = 28) AND (duration < 60))
AND license_plate
IN (SELECT license_plate
FROM courthouse_security_logs
WHERE (activity = "exit")
AND (hour = 10)
AND (minute > 15)
AND (minute < 25)
AND (year = 2020)
AND (month = 7)
AND (day = 28));


-- finds flight_id and seat number of suspects based on passport number
SELECT flight_id, seat, passport_number
FROM passengers
WHERE passport_number IN (

SELECT passport_number FROM people
WHERE phone_number IN
(SELECT caller FROM phone_calls WHERE (year = 2020) AND (month = 7) AND (day = 28) AND (duration < 60))
AND license_plate IN (SELECT license_plate
FROM courthouse_security_logs
WHERE (activity = "exit")
AND (hour = 10)
AND (minute > 15)
AND (minute < 25)
AND (year = 2020)
AND (month = 7)
AND (day = 28))

);

-- finds info on who went to ATM
SELECT name FROM people
WHERE id IN(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number
FROM atm_transactions
WHERE (year = 2020) AND (month = 7) AND (day = 28) AND (atm_location = "Fifer Street")));


-- Ernest and Russell both made a phone call less than a minute duration on Jul7 28,2020
-- and were at the ATM at Fifer Street


--finds destination and origin of flight id of Ernest- on flight 36
SELECT destination_airport_id FROM flights WHERE id = 36;

-- returns 4 as destination_id

-- Finds Ernest destination
SELECT city FROM airports WHERE id = 4;



--finds recievers info
SELECT id, name, passport_number, license_plate
FROM people
WHERE phone_number IN
(SELECT receiver FROM phone_calls WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND (duration < 60));