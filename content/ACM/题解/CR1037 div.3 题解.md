### CR1037 题解

## A

**题意** :

输入一个数$n$,找到最小的和它有共同数字的数 $k$  

**思路:**

显然$k$就是这个数$n$的所有位数的最小的那一位

```cpp
void solve()
{
    int n;
    cin >> n;
    string s = to_string(n);
    sort(all(s));
    cout << s[0] << endl;
}
```

---

## B

**题意**:

给定一个包含$n$个元素的数组$A$和一个数$k$ ,$A$中的每个元素由 $0,1$ 构成,需要我们寻找$k$数量的连续$0$串且每个串之间需要有一个元素相隔

**思路:**

直接模拟即可

```cpp
void solve()
{
    int n, k;
    cin >> n >> k;
    vint v(n);
    for (auto &&i : v) {
        cin >> i;
    }
    int cnt = 0;
    int now = 0;
    for (size_t i = 0; i < n; i++)
    {
        if(v[i] == 0)now++;
        if(v[i] == 1)now = 0;
        if(now == k){
            i++;
            cnt++;
            now = 0;
        }
    }
    cout << cnt << endl;
}
```

---

## C

**题意:**

给定两个数 $n,k$ 和一个有 $n$ 个元素的数组 $A$ ,有一个从$0$开始的每秒加$1$的水位,数组$A$中的元素$a_i$表示第$i$座塔的高度,你初始在$a_k$ 高度的塔上,你可以花费 $|a_j - a_i|$ 的时间从第$i$座塔移动到第$j$座塔,当水位完全超过你所在塔的高度的时候便会失败

你需要判断能否到达最高的塔而不失败

**思路:**

我们考虑**贪心**,因为水位上涨速度与我们移动速度是一致的,故只要从我们目前所在高度的 $a_i$ 到最高位置 $a_{max}$ 之间从小到大两两的距离差都小于初始高度$a_i$ 我们就可以到达最高的塔

```cpp
void solve()
{
    int n, k;
    cin >> n >> k;
    vint v(n);
    for (auto &&i : v) {
        cin >> i;
    }
    int under = v[k - 1];
    // 贪心:一开始所在位置就是我们能跨越的最大位置,而且我们只需要看比一开始大的
    ranges::sort(v);
    vint res;
    for (size_t i = 0; i < n; i++) {
        if (v[i] >= under) {
            res.emplace_back(v[i]);
        }
    }
    vint diff(n,0);
    for (size_t i = 0; i + 1 < res.size(); i++) {
        diff[i] = res[i + 1] - res[i];
    }
    cout << (ranges::max(diff) > under ? "NO" : "YES") << endl;
}
```

---

#### D

**题意:**

给定 $n$ 个赌场,其有三个参数 $l,r,real$ ,再给定初始金币 $k$ ,规定持有金币数量$p$每个赌场只能允许$p \in [l,r]$ 进入并且会将 $p$ 变为 $real$ ,并且每个赌场只能进入一次

我们需要知道我们在参加任意次赌场后获得的最大金币数量为多少

**思路:**

由于我们需要最大的金币数量,所以我们每一次游玩后都想要金币尽可能上涨,这里我们考虑使用 **大堆顶** 即优先队列来筛选,其存放数据为$\{r,real\}$ 

具体做法是

- 先将所有赌场的*进入门槛 $l$* 从小到大排序
- 然后进行循环,首先令 $now = k$
  - 对当前金币$now$ ,将$l \le now$ 的放入大堆顶,这样存放进入的数据中会按照$real$的大小排序
  - 对堆里的数据,先排除 $r < now$ 的
  - 如果堆空了或者堆顶的$real \le now$ 的话说明已经没有比 $now$ 还大的元素了,那么我们就退出循环
  - 否则就将 $now$ 赋值为堆顶的$real$ 代表这一轮找到了最大的$real_i$ 然后重复循环 

```cpp
struct st
{
    int l, r, re;
};

void solve()
{
    int n,k;
    cin >> n >> k;
    vector<st> v(n);
    for (size_t i = 0; i < n; i++)
    {
        auto &&[l, r, t] = v[i];
        cin >> l >> r >> t;
    }
    ranges::sort(v, [](st a, st b) { return a.l < b.l; });
    priority_queue<pii> pq;
    int now = k;
    int idx = 0;
    while (1)
    {
        while (idx < n && v[idx].l <= now)
        {
            pq.emplace(v[idx].re, v[idx].r);
            idx++;
        }
        // 排除 r < now的
        while (!pq.empty() && pq.top().second < now)
        {
            pq.pop();
        }
        // 如果空或者没有比x大的,那么就退出
        if (pq.empty() || pq.top().first <= now) {
            break;
        }
        // 提升now
        now = pq.top().first;
        pq.pop();
    }
    cout << now << endl;
}
```

---

