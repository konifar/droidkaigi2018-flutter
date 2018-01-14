class Link {
  Link(this.type, this.url);

  final LinkType type;
  final String url;

  static twitter(String url) {
    return new Link(LinkType.twitter, url);
  }

  static linkedin(String url) {
    return new Link(LinkType.linkedIn, url);
  }

  static blog(String url) {
    return new Link(LinkType.blog, url);
  }

  static companyWebSite(String url) {
    return new Link(LinkType.companyWebSite, url);
  }

  static other(String url) {
    return new Link(LinkType.other, url);
  }
}

enum LinkType { twitter, linkedIn, blog, companyWebSite, other }
