package us.codecraft.webmagic;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Request对象封装了待抓取的url信息。<br/>
 * 在PageProcessor中，Request对象可以通过{@link us.codecraft.webmagic.Page#getRequest()} 获取。<br/>
 * <br/>
 * Request对象包含一个extra属性，可以写入一些必须的上下文，这个特性在某些场合会有用。<br/>
 * <pre>
 *      Example:
 *          抓取<a href="${link}">${linktext}</a>时，希望提取链接link，并保存linktext的信息。
 *      在上一个页面：
 *      public void process(Page page){
 *          Request request = new Request(link,linktext);
 *          page.addTargetRequest(request)
 *      }
 *      在下一个页面：
 *      public void process(Page page){
 *          String linktext =  (String)page.getRequest().getExtra()[0];
 *      }
 * </pre>
 *
 * @author code4crafter@gmail.com <br>
 *         Date: 13-4-21
 *         Time: 上午11:37
 */
public class Request implements Serializable {

    private static final long serialVersionUID = 2062192774891352043L;

    private String url;

    /**
     * 额外参数，可以保存一些需要的上下文信息
     */
    private Map<String, Object> extras;

    private double priority;

    public Request() {
    }

    /**
     * 构建一个request对象
     *
     * @param url 必须参数，待抓取的url
     */
    public Request(String url) {
        this.url = url;
    }

    public double getPriority() {
        return priority;
    }

    /**
     * 设置优先级，用于URL队列排序<br>
     * 需扩展Scheduler<br>
     * 目前还没有对应支持优先级的Scheduler实现 =。= <br>
     * @param priority 优先级，越大则越靠前
     * @return this
     */
    public Request setPriority(double priority) {
        this.priority = priority;
        return this;
    }

    public Object getExtra(String key) {
        if (extras == null) {
            return null;
        }
        return extras.get(key);
    }

    public Request putExtra(String key, Object value) {
        if (extras == null) {
            extras = new HashMap<String, Object>();
        }
        extras.put(key, value);
        return this;
    }

    /**
     * 获取待抓取的url
     *
     * @return url 待抓取的url
     */
    public String getUrl() {
        return url;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Request request = (Request) o;

        if (!url.equals(request.url)) return false;

        return true;
    }

    public Map<String, Object> getExtras() {
        return extras;
    }

    @Override
    public int hashCode() {
        return url.hashCode();
    }

    public void setExtras(Map<String, Object> extras) {
        this.extras = extras;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Request{" +
                "url='" + url + '\'' +
                ", extras=" + extras +
                ", priority=" + priority +
                '}';
    }
}
