# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
MAX_SEEDS = 10

# Заполнение SEO для каждой сущности: ent
def fill_seo(ent)
  ent.map do |e|
    print '.'
    {
      title: FFaker::Lorem.sentence,
      description: FFaker::Lorem.paragraphs.to_s.gsub(/["\[\]]/,'').gsub('.,', '.'),
      keywords: FFaker::Lorem.words,
      seoable_id: e.id,
      seoable_type: e.class.to_s
    }
  end
end

User.destroy_all
Post.destroy_all
Comment.destroy_all
Mark.destroy_all

# Добавляем пользователей
print 'Добавляем пользователей'

hash_users = (2*MAX_SEEDS).times.map do
  print '.'
  {
    name: FFaker::Internet.user_name[0..15],
    email: FFaker::Internet.safe_email
  }
end

hash_users.first(10).each { |user| user[:creator] = true }
hash_users.first(5).each { |user| user[:moderator] = true }

users = User.create! hash_users

puts

# users.each { |user| p user }

# Добавляем посты
print 'Добавляем посты'

creators = User.where(creator: true)

hash_posts = (3*MAX_SEEDS).times.map do
  print '.'
  {
    title: FFaker::Lorem.sentence,
    body: FFaker::Lorem.paragraphs.to_s.gsub(/["\[\]]/,'').gsub('.,', '.'),
    user: creators.sample
  }
end

posts = Post.create! hash_posts

puts

# Добавляем комментарии
print 'Добавляем комментарии'

hash_comments = (25*MAX_SEEDS).times.map do
  print '.'
  commentable =((rand(2) == 1) ? posts : users).sample
  {
    body: FFaker::Lorem.paragraph,
    user: users.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end

comments = Comment.create! hash_comments

puts

# Добавляем оценки
print 'Добавляем оценки'

hash_marks = []

(50*MAX_SEEDS).times do
  print '.'
  post_user = { post: posts.sample, user: users.sample }
  hash_marks << post_user unless hash_marks.include?(post_user)
end

hash_marks.each { |mark| mark[:mark] = rand(Mark::MIN_MARK..Mark::MAX_MARK) }

Mark.create! hash_marks

puts

# Добавляем записи SEO
print 'Добавляем записи SEO'

Seo.create! fill_seo(users)
Seo.create! fill_seo(posts)
# Seo.create! fill_seo(comments)

puts
