require 'oauth/signature/hmac/sha1'
require 'oauth/signature/plaintext'
require 'oauth/request_proxy/action_controller_request'

class OAuth::InvalidRequest < Exception; end
class OAuth::AccessTokenRequired < Exception; end
class OAuth::RequestTokenRequired < Exception; end
