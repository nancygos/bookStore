class RedisCache
  def self.redis
    @redis ||= Redis.new(url: ENV['REDIS_URL'])
  end

  def self.setnx(key, value)
    redis.setnx(key, value)
  end

  def self.get(key)
    redis.get(key)
  end

  def self.del(key)
    redis.del(key)
  end

  def self.expire(key, seconds)
    redis.expire(key, seconds)
  end
end