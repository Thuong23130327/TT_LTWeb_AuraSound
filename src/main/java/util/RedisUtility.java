package util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RedisUtility {
    private static final JedisPool pool = new JedisPool("172.17.0.1", 6379);

    public static Jedis getJedis() {
        return pool.getResource();
    }

    public static void saveToken(String token, String email, int seconds) {
        try (Jedis jedis = getJedis()) {
            jedis.setex("verify_token:" + token, seconds, email);
        }
    }

    public static String getEmailByToken(String token) {
        try (Jedis jedis = getJedis()) {
            return jedis.get("verify_token:" + token);
        }
    }

    public static void deleteToken(String token) {
        try (Jedis jedis = getJedis()) {
            jedis.del("verify_token:" + token);
        }
    }
}