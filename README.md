# Scouting Reports

This is my implementation of a simple scouting report. I kept the scope focused and included a dashboard for viewing reports, a show page to view a specific report, and a form to create a new report. When inside a report, I did add the ability to edit information and save the report.

The project was built using
Rails 8.0.5
Ruby 3.3.8

## Setup

To clone the repository:
```bash
git clone https://github.com/Jeffmwright/JeffWrightApplicantProject.git
```

Then, install dependencies:

```bash
bundle install
```

Set up the database and load sample data - I created some sample reports to go along with the project:

```bash
bin/rails db:setup
```

Start the server:

```bash
bin/rails s
```

Open:

```text
http://localhost:3000
```

## Where I would take the project from here:
The next steps I see for this project would be to:
- Redesign the view report; it currently feels flat, but I tried not to go overboard with this project and focus on functionality
- Add search functionality to quickly find a specific report
- Add pagination to main dashboard. My solution currently works fine for small data, but with a large number of pages, the dashboard would be overwhelmed
- Add report exporting to a pdf to allow for easier sharing of scouting reports.
- Integrate Tailwind CSS to employ more modern UI such as the ones available at DaisyUI.

## AI Usage
For this project, I worked in Cursor, which has AI integrated into the platform. I used AI for small code suggestions thorugh their tab to complete feature, and help with boilerplate creation, such as creating some initial styles in the style sheet to quickly align items where I wanted them. I also had it auto populate some test data instead of writing a few reports by hand. 
I felt this usage was a good balance of boosting my productivity while maintaing the integrity of the assignments purpose to gauge how I handle a small project from start to finish. The design and major functionality was created by me.