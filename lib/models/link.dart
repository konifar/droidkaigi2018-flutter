class Link {
  Link(this.type, this.url);

  final LinkType type;
  final String url;

  static _fromType(String linkType, String url) {
    switch (linkType) {
      case "Twitter":
        return new Link(LinkType.twitter, url);
      case "Blog":
        return new Link(LinkType.blog, url);
      case "LinkedIn":
        return new Link(LinkType.linkedIn, url);
      case "Company_Website":
        return new Link(LinkType.companyWebSite, url);
      default:
        return new Link(LinkType.other, url);
    }
  }

  static fromJson(json) {
    return _fromType(json['linkType'], json['url']);
  }
}

enum LinkType { twitter, linkedIn, blog, companyWebSite, other }
