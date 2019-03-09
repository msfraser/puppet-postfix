# postfix use case for nullmailer
class postfix::nullmailer (
  $relayhost,
) {
  class { 'postfix': }
  postfix::maincf::param { 'relayhost':
    value => $relayhost,
  }
}
