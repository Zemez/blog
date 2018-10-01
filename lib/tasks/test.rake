namespace :test do
  desc "Заполнение базы случайно-сгенерированными тестовыми данными"
  task data: :environment do
    MAX_SEEDS = 5
    users = []
    posts = []

    # создаем MAX_SEED пользователей
    print 'Добавляем пользователей'
    MAX_SEEDS.times do |i|
      user_name = FFaker::Internet.user_name
      user = User.find_by name: user_name
      user = User.create(name: user_name, email: "#{user_name}@test.ru") if user.blank?
      users << user if user.valid?
      print '.'
    end
    puts

    # для каждого пользователя создаем случайно от 1 до MAX_SEEDS постов
    print 'Добавляем посты'
    users.each do |user|
      seed = rand(1..MAX_SEEDS)
      seed.times do |i|
        post_title = FFaker::CheesyLingo.title
        post = Post.find_by title: post_title
        if post.blank?
          post = Post.new
          post.user = user
          post.title = post_title
          post.body = FFaker::CheesyLingo.paragraph
          post.save
        end
        posts << post if post.valid?
        print '.'
      end
    end
    puts

    # для каждого поста создаем случайно от MAX_SEEDS до MAX_SEEDS**2 комментариев случайных пользователей
    print 'Добавляем комментарии'
    posts.each do |post|
      seed = rand(MAX_SEEDS..MAX_SEEDS**2)
      seed.times do |i|
        user = users[rand(users.size)]
        comment = Comment.new
        comment.post = post
        comment.user = user
        comment.body = FFaker::CheesyLingo.sentence
        comment.save
        print '.'
      end
    end
    puts

    # для каждого поста проставляем случайные оценки от каждого пользователя
    print 'Добавляем оценки'
    posts.each do |post|
      users.each do |user|
        mark = Mark.find_by post: post, user: user
        mark = Mark.create(post: post, user: user, mark: rand(Mark::MIN_MARK..Mark::MAX_MARK)) if mark.nil?
        print '.'
      end
    end
    puts

  end

end
