OmniAuth.config.test_mode = true
omniauth_hash = { 'provider' => 'facebook',
                  'uid' => '12345',
                  'info' => {
                    'name' => 'user',
                    'email' => 'user@example.com'
                  }
}

OmniAuth.config.add_mock(:facebook, omniauth_hash)
