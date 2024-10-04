
# Tay LE Phuong Link Tracking Test

Prepare Database
```
rails db:prepare
```

Run the WEB with full cache & Job
```
bin/dev
```

For admin Basic Authen
```
username: admin
password: password
# can modifined by passing ENV: ADMIN_USERNAME, ADMIN_PASSWORD
```

## Click Tracking Feature

* in the LinkClicks#create action
    * write thought cache make it faster and not put presure on the main Database
    * Then use a job run every minute to in search all the data from cache to the main Database
    * PROS:
        * fast to write
        * batch insearch with just 1 squery
    * CONS:
        * it will not reflect data on the Admin Dashboard soon
* In Javascript:
    * use `turbo:load` event add click event listenner => the right way with rails, not use `DOMContentLoaded`, like normal html
    * use keep_alive=true true minimize the request on client make it same with sendBeacon()
    * provide `X-CSRF-Token` Header for protect_from_forgery
    * use `this.getAttribute("href") to make the different between the interal and exteral url

## Dashboard

* project with Basic Authentication since do not have authentication feature
* cache for frequently accessed statistics exprire every 5 minutes
* Turbo-Stream for the search action make the page only replace the statistics content

# Ruby on Rails Assignment: Implement Link Click Tracking

## Overview

Your task is to implement a feature in this Rails 8 application that tracks every link click, both to internal pages and external websites.
This data should be stored in a database table called `link_clicks` without significantly impacting the application's performance.

## Requirements

### Core Features

1. Track clicks on all links within the application
2. Store click data in the `link_clicks` table
3. Capture relevant details about each click
4. Implement the feature with minimal performance impact

### Technical Requirements

1. Use Ruby on Rails 8 (this application is already set up with Rails 8)
2. Use SQLite as the database for simplicity (you can switch to PostgreSQL if needed)
3. Use solid_queue for background jobs
4. Create a migration for the `link_clicks` table
5. Implement a mechanism to track clicks without blocking the user's navigation
6. Use a background job for storing click data
7. Implement a JavaScript solution to capture click events
8. Create a basic admin interface to view click statistics
9. Write model and integration tests using Rails' default testing framework (Minitest)

## Detailed Requirements

### Data Model

Create a migration for the `link_clicks` table with the following fields:
- `id` (primary key)
- `url` (string, the full URL of the clicked link)
- `anchor_text` (string, the text content of the clicked link)
- `referrer` (string, the page URL where the click originated)
- `user_agent` (string, the user's browser information)
- `ip_address` (string, the user's IP address)
- `created_at` (timestamp)

Ensure appropriate indexes are added for efficient querying.

### Backend Implementation

1. Create a `LinkClick` model with appropriate validations and associations
2. Implement a background job using solid_queue to handle the storing of click data asynchronously
3. Create a controller action to receive click data from the frontend
4. Implement basic analytics methods on the `LinkClick` model (e.g., most clicked links, click counts by day)

### Frontend Implementation

1. Develop a JavaScript solution to capture click events on all links (`<a>` tags) within the application
2. For each click, collect relevant data (URL, anchor text, referrer) and send it to the backend
3. Ensure the data is sent asynchronously without delaying the user's navigation
4. Handle both internal and external links appropriately

### Admin Interface

1. Create a basic admin interface to view click statistics
2. Use Tailwind CSS for styling the admin interface
3. Implement a simple dashboard showing aggregated statistics (e.g., total clicks, most clicked links)
4. Optionally, add a date range selector to filter click data by date

### Performance Considerations

1. Implement a rate limiting mechanism to prevent abuse
2. Optionally, consider using batch inserts for click data if high volume is expected
3. Implement appropriate database indexes for efficient querying
4. Use caching for frequently accessed statistics in the admin interface

### Testing

Write tests using Rails' default testing framework (Minitest) to cover:
- `LinkClick` model methods
- Click tracking functionality (integration tests)
- Background job functionality

## Evaluation Criteria

Your submission will be evaluated based on:

1. Correctness of the implementation
2. Performance considerations and optimizations
3. Code quality and organization
4. Proper use of Rails conventions and best practices
5. Effectiveness of the JavaScript solution
7. Test coverage and quality

## Submission Guidelines

1. Clone this repository and work on your solution locally in a separate branch
2. Once you're done, push your changes to your own GitHub repository
3. Include a README.md with:
   - Explanation of your implementation approach
   - Any assumptions or trade-offs made
   - Ideas for future improvements or scaling considerations
4. Ensure that the application can be set up and run locally with minimal effort

## Time Limit

You have a maximum of 5 hours to complete this assignment. Focus on implementing the core functionality efficiently and demonstrating your full-stack Rails development skills.

Good luck!
