module.exports = {
  public: true,
  host: undefined,
  port: 9000,
  bind: undefined,
  reverseProxy: false,
  maxHistory: 10000,
  defaults: {
    name: "Your Nick",
    host: "irc",
    port: 6667,
    password: "",
    tls: false,
    rejectUnauthorized: true,
    nick: "thelounge%%",
    username: "thelounge",
    realname: "The Lounge User",
    join: "#lounge"
  },
  lockNetwork: true,
  prefetch: true,
  prefetchStorage: true,
  prefetchMaxImageSize: 2048,
  fileUpload: {
    enable: true,
    maxFileSize: 10240,
    baseUrl: null,
    baseUrlPath: "/uploads/"
  },
  displayNetwork: false,
  theme: "thelounge-theme-cg",
  prefetchSafeLink: true,
  identd: {
    enable: false,
    port: 113
  },
  oidentd: null,
  ldap: {
    enable: false,
    url: "ldaps://example.com",
    baseDN: "ou=accounts,dc=example,dc=com",
    primaryKey: "uid",
    tlsOptions: {}
  }
};