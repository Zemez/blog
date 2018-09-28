namespace :test do
  desc "Заполнение базы случайно-сгенерированными тестовыми данными"
  task data: :environment do
    MAX_SEED = 5
    users = []
    posts = []
    # comments = []
    # marks = []

    # создаем MAX_SEED пользователей
    print 'Добавляем пользователей'
    MAX_SEED.times do |i|
      heap =  SecureRandom.hex(4)
      user = User.find_by name: "User#{heap}"
      user = User.create(name: "User#{heap}", email: "user#{heap}@test.ru") if user.nil?
      # user = User.find_by name: "User#{i+1}"
      # user = User.create(name: "User#{i+1}", email: "user#{i+1}@test.ru") if user.nil?
      users << user unless user.nil?
      print '.'
    end
    puts
    # p users

    # для каждого пользователя создаем случайно от 1 до MAX_SEED постов
    print 'Добавляем посты'
    users.each do |user|
      seed = rand(1..MAX_SEED)
      seed.times do |i|
        heap =  SecureRandom.hex(4)
        post = Post.find_by user: user, title: "title by user:#{'%04d'%user.id}:#{heap}"
        # post = Post.find_by user: user, title: "title by user:#{user.id}:#{i+1}"
        if post == nil
          post = Post.new
          post.user = user
          post.title =  "title by user:#{'%04d'%user.id}:#{heap}"
          post.body = "post body by user:#{'%04d'%user.id}:#{heap}"
          post.save
        end
        posts << post unless post.nil?
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
        heap =  SecureRandom.hex(4)
        user = users[rand(MAX_SEED)]
        comment = Comment.new
        comment.post = post
        comment.user = user
        comment.body = "comment body for post:#{'%04d'%post.id}:user:#{'%04d'%user.id}:#{heap}"
        comment.save
        # comments << comment unless comment == nil
        print '.'
      end
    end
    puts
    # p comments

    # для каждого поста проставляем случайные оценки от каждого пользователя
    print 'Добавляем оценки'
    posts.each do |post|
      users.each do |user|
        mark = Mark.find_by post: post, user: user
        mark = Mark.create(post: post, user: user, mark: rand(Mark::MIN_MARK..Mark::MAX_MARK)) if mark.nil?
        # marks << mark unless mark == nil
        print '.'
      end
    end
    puts
    # p marks

  end

end
