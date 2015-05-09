#User
User.create(name: "Brendan Miranda", email: "me@bm.com", password: "1234")
User.create(name: "Alex Taber", email: "me@at.com", password: "1234")
User.create(name: "Dora Pantaleon", email: "me@dp.com", password: "1234")
User.create(name: "Ace Burgess", email: "me@ab.com", password: "1234")

#Surveys
Survey.create(title:"All about you Survey", picture_url: "http://www.mekreview.com/wp-content/uploads/2013/10/you-de.png" , user_id:1)
Survey.create(title:"TV Survey", picture_url:"http://wp.production.patheos.com/blogs/adrianwarnock/files/2013/10/TV-shutterstock_23301313.jpg" , user_id:3)

#TV Survey
Question.create(question: "What is the last thing you watched on TV?", survey_id: 2)
Choice.create(question_id: 1, choice: "comedy" )
Choice.create(question_id: 1, choice: "drama" )
Choice.create(question_id: 1, choice: "horror" )
Choice.create(question_id: 1, choice: "other" )

Question.create(question: "Did you dream last night?", survey_id: 2)
yes = Choice.create(question_id: 2, choice: "yes" )
no = Choice.create(question_id: 2, choice: "no" )

Question.create(question: "When did you last laugh?", survey_id: 2)
Choice.create(question_id: 3, choice: "few days" )
Choice.create(question_id: 3, choice: "few weeks" )
Choice.create(question_id: 3, choice: "few months" )
Choice.create(question_id: 3, choice: "too long" )

Question.create(question: "If you could live anywhere, where would you live?", survey_id: 2)
Choice.create(question_id: 4, choice: "Europe" )
Choice.create(question_id: 4, choice: "USA" )
Choice.create(question_id: 4, choice: "Asia" )
Choice.create(question_id: 4, choice: "Africa" )
Choice.create(question_id: 4, choice: "Other" )

#You Survey
Question.create(question: "Whats your favorite food", survey_id: 1)
Choice.create(question_id: 5, choice: "Mexican" )
Choice.create(question_id: 5, choice: "American" )
Choice.create(question_id: 5, choice: "French" )
Choice.create(question_id: 5, choice: "Chinese" )
Choice.create(question_id: 5, choice: "Other" )

Question.create(question:"If you became a multimillionaire overnight, what would you buy?", survey_id: 1)
Choice.create(question_id: 6, choice: "Mansion" )
Choice.create(question_id: 6, choice: "Robots" )
Choice.create(question_id: 6, choice: "The Government" )
Choice.create(question_id: 6, choice: "An Island" )
Choice.create(question_id: 6, choice: "Other" )


Question.create(question: "If you could change one thing about the world, regardless of guilt or politics, what would you do?", survey_id: 1)
Choice.create(question_id: 7, choice: "The Economy" )
Choice.create(question_id: 7, choice: "Enforce world peace" )
Choice.create(question_id: 7, choice: "Demand everyone own a dog" )
Choice.create(question_id: 7, choice: "Free internet for all" )


Question.create(question: "Type of music you like most?", survey_id: 1)
Choice.create(question_id: 8, choice: "Rock" )
Choice.create(question_id: 8, choice: "Folk" )
Choice.create(question_id: 8, choice: "Reggaeton" )
Choice.create(question_id: 8, choice: "Hip Hop" )
Choice.create(question_id: 8, choice: "Country" )
Choice.create(question_id: 8, choice: "Rap" )
