class BookmarkRepository {
  // In-memory storage for bookmarked article IDs
  static final Set<String> _bookmarkedIds = {};

  static bool isBookmarked(String articleId) {
    return _bookmarkedIds.contains(articleId);
  }

  static void toggleBookmark(String articleId) {
    if (_bookmarkedIds.contains(articleId)) {
      _bookmarkedIds.remove(articleId);
    } else {
      _bookmarkedIds.add(articleId);
    }
  }

  static Set<String> getBookmarkedIds() {
    return Set.from(_bookmarkedIds);
  }
}
