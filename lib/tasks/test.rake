namespace :test do
  desc "Заполнение базы случайно-сгенерированными тестовыми данными"
  task data: :environment do
    MAX_SEED = 5
    users = []
    posts = []
    # comments = []

    # создаем MAX_SEED пользователей
    print 'Добавляем пользователей'
    MAX_SEED.times do |i|
      users << User.create(name: "User#{i+1}", email: "user#{i+1}@test.ru")
      print '.'
    end
    puts
    # p users

    # для каждого пользователя создаем случайно от 1 до MAX_SEED постов
    print 'Добавляем посты'
    users.each do |user|
      seed = rand(1..MAX_SEED)
      seed.times do |i|
        post = Post.new
        post.user = user
        post.title =  "title by user:#{user.id}:#{i+1}"
        post.body = "post body by user:#{user.id}:#{i+1}"
        post.save
        posts << post
        print '.'
      end
    end
    puts
    # p posts

    # для каждого поста создаем случайно от MAX_SEED до MAX_SEED**2 комментариев случайных пользователей
    print 'Добавляем комментарии'
    posts.each do |post|
      seed = rand(MAX_SEED..MAX_SEED**2)
      seed.times do |i|
        user = users[rand(MAX_SEED)]
        comment = Comment.new
        comment.post = post
        comment.user = user
        comment.body = "comment body for post:#{post.id}:#{i+1} by user:#{user.id}"
        comment.save
        # comments << comment
        print '.'
      end
    end
    puts
    # p comments

  end

end
