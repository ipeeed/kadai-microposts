module UsersHelper #helperとは、viewないに複雑なコーディングをしてしまうと読みづらい上にちょっとしたことでデザイン崩れにつながることから、その一部を肩代わりするもの。
                   #パーシャルのようなものだと考えられるが、ではなぜパーシャルを/views内に作らない？ -> パーシャルはrenderしなければならないから？
  def gravatar_url(user, options ={ size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?=#{size}"
  end

end
