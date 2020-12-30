# CF/Api
[![Maintainability](https://api.codeclimate.com/v1/badges/70a047e4db8776c58351/maintainability)](https://codeclimate.com/github/gessgallardo/cf/maintainability)

project for CF test.



## API::School::V1

documentation: hhttps://documenter.getpostman.com/view/13898358/TVt18QJi
postman: https://www.getpostman.com/collections/6a8fe5404917e5b58e5c

I decide to separate the api models from the rails models in order to be able to 
have a domain driven approach, which allow us to quickly change between versions
without having to much legacy/dependency as different parts of the sytem be morphed to work with different versions.



### Api::School::V1::Mentor

  Serializer for API Mentors

  Methods

    - build(mentor, calendar_client, time_zone)
      - builder pattern for api v1 mentors

    - #filter_slots_by_date(date: date)
      - returns the slots available for a given date

    - #slot_present?(datetime):
      - validate if date is available

    - #refresh_slots!
      - remove allocated calls not longer in mentor calendar
      - nth: clears cache
      - nth: should trigger some kind to notification for user

### Api::School::V1::CalendarSlot

  Serializer for CalendarSlots


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