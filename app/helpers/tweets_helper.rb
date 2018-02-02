module TweetsHelper
    def get_tagged(tweet)
        message_arr = @tweet.message.split

        message_arr.each_with_index do |word, index|
            if word[0] =='#'
                tag = Tag.find_or_create_by(phrase: word)
                tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)
                message_arr[index] = "<a href= '/tag_tweets?id=#{tag.id}'>#{word}</a>"
            end
        end

    @tweet.update(message: message_arr.join(' '))
    end
end
