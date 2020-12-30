## Models

Model information

### Students
---
  Attributes

    - first_name
    - last_name
    - time_zone
    - mentors, through: mentorship
    - allocated_calls

### Mentors
---
  Attributes

    - first_name
    - last_name
    - time_zone
    - students, through: mentorships
    - allocated_calls
    - calendar_id

  Methods

    - schedule_call(student, datetime):
      - should clear cache before allocate call
      - schedule the call

    - #slots(by_date: date):
      - returns the slots available for a given date

    - #check_availabilty(datetime): 
      - validate if date is available

    - #avaiblity:
      - merge of allocated_calls and calendar.agenda
      - probably needs to be cached

    - #refresh_availiablity
      - remove allocated calls not longer in mentor calendar
      - clears cache
      - nth: should trigger some kind to notification for user

### Mentorships
---
Attributes

      - student
      - mentor

### AllocatedCalls
---
  Attributes

    - mentor
    - student
    - date_time
    - description


## External Libraries/API

  - [CareerFound CalendarAPI](https://cfcalendar.docs.apiary.io/)


## Contributing

If you want to contribute download the repositorie and follow the next steps, all requests should be done trought a PR, pushing directly to `main` is not allowed.

### Build using docker
`docker-compose build`

### Starting up
`docker-compose up -d`

### How to prepare your database
`docker-compose exec cf bundle exec rake db:setup`

### Running specs
`docker-compose bundle exec rspec`

### Style
  - Codeclimate [rubocop]

### CI/CD
  - TODO