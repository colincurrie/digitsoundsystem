def create_comment(index, user, options)
  comment = Comment.create(options.merge(user: user, content: LOREM.shuffle.first))
  target = options[:story] || options[:photo] || options[:mixtape] || options[:tune] || options[:event] || options[:video]
  comment.created_at = target.created_at + (index*60*60) # one comment every hour
  comment.updated_at = comment.created_at
  comment.save
end
