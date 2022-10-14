-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign
WHERE outcome = 'live'
GROUP BY cf_id
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT backers.cf_id, 
	COUNT(backers.backer_id) as "backers_count"
FROM backers as backers
INNER JOIN campaign as campaign
ON campaign.cf_id = backers.cf_id
WHERE campaign.outcome = 'live'
GROUP BY backers.cf_id
ORDER BY backers_count DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT contacts.first_name,
	contacts.last_name,
	contacts.email,
	ROUND(campaign.goal - campaign.pledged,2) as "Remaining Goal Amount"
FROM campaign as campaign
INNER JOIN contacts as contacts
ON contacts.contact_id = campaign.contact_id
WHERE campaign.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT backers.email,
	backers.first_name,
	backers.last_name,
	backers.cf_id,
	campaign.company_name,
	campaign.description,
	campaign.end_date,
	ROUND(campaign.goal - campaign.pledged, 2) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as backers
LEFT JOIN campaign as campaign
ON campaign.cf_id = backers.cf_id
WHERE campaign.outcome = 'live'
ORDER BY backers.last_name;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;
