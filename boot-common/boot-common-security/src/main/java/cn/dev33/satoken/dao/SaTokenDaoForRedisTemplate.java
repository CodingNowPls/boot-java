package cn.dev33.satoken.dao;

import cn.dev33.satoken.dao.auto.SaTokenDaoByObjectFollowString;
import cn.dev33.satoken.util.SaFoxUtil;
import com.boot.common.core.enums.EnumCacheType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
@Component
@ConditionalOnProperty(name = "boot.cacheType", havingValue = EnumCacheType.CACHE_TYPE_REDIS)
public class SaTokenDaoForRedisTemplate implements SaTokenDaoByObjectFollowString, SaTokenDao {
    public StringRedisTemplate stringRedisTemplate;
    public boolean isInit;

    public SaTokenDaoForRedisTemplate() {
    }

    @Autowired
    public void init(RedisConnectionFactory connectionFactory) {
        if (!this.isInit) {
            StringRedisTemplate stringTemplate = new StringRedisTemplate();
            stringTemplate.setConnectionFactory(connectionFactory);
            stringTemplate.afterPropertiesSet();
            this.stringRedisTemplate = stringTemplate;
            this.initMore(connectionFactory);
            this.isInit = true;
        }
    }

    protected void initMore(RedisConnectionFactory connectionFactory) {
    }

    public String get(String key) {
        return this.stringRedisTemplate.opsForValue().get(key);
    }

    public void set(String key, String value, long timeout) {
        if (timeout != 0L && timeout > -2L) {
            if (timeout == -1L) {
                this.stringRedisTemplate.opsForValue().set(key, value);
            } else {
                this.stringRedisTemplate.opsForValue().set(key, value, timeout, TimeUnit.SECONDS);
            }

        }
    }

    public void update(String key, String value) {
        long expireMs = this.stringRedisTemplate.getExpire(key, TimeUnit.MILLISECONDS);
        if (expireMs != -2L) {
            if (expireMs == -1L) {
                this.stringRedisTemplate.opsForValue().set(key, value);
            } else {
                this.stringRedisTemplate.opsForValue().set(key, value, expireMs, TimeUnit.MILLISECONDS);
            }

        }
    }

    public void delete(String key) {
        this.stringRedisTemplate.delete(key);
    }

    public long getTimeout(String key) {
        return this.stringRedisTemplate.getExpire(key);
    }

    public void updateTimeout(String key, long timeout) {
        if (timeout == -1L) {
            long expire = this.getTimeout(key);
            if (expire != -1L) {
                this.set(key, this.get(key), timeout);
            }

        } else {
            this.stringRedisTemplate.expire(key, timeout, TimeUnit.SECONDS);
        }
    }

    public List<String> searchData(String prefix, String keyword, int start, int size, boolean sortType) {
        Set<String> keys = this.stringRedisTemplate.keys(prefix + "*" + keyword + "*");
        List<String> list = new ArrayList(keys);
        return SaFoxUtil.searchList(list, start, size, sortType);
    }
}