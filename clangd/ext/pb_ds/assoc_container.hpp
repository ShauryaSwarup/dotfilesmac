#pragma once
#include <set>
#include <unordered_map>

namespace __gnu_pbds {

template <typename Key, typename Mapped = void,
          typename Cmp_Fn = std::less<Key>, typename Tag = void,
          typename Node_Update = void>
class tree {
  std::set<Key> s;

public:
  using iterator = typename std::set<Key>::iterator;

  void insert(const Key &x) { s.insert(x); }
  void erase(const Key &x) { s.erase(x); }
  iterator find(const Key &x) { return s.find(x); }

  int order_of_key(const Key &x) {
    return std::distance(s.begin(), s.lower_bound(x));
  }

  iterator find_by_order(int k) {
    auto it = s.begin();
    std::advance(it, k);
    return it;
  }
};

struct null_type {};

template <typename Key, typename Mapped>
using gp_hash_table = std::unordered_map<Key, Mapped>;

} // namespace __gnu_pbds
