class ParseResult {
  TreeNode node = null;
  Error error = null;
  
  
  ParseResult success(TreeNode node) {
    this.node = node;
    return this;
  }
  
  ParseResult failure(Error error) {
    this.error = error;
    return this;
  }
  
  
  
}
