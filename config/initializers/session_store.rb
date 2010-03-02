# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wirealameda_session',
  :secret      => '9387bc2fe9dc8ca1ff3e1c17bdf786f0447c47b088c6b6edc53ac833e710250e1be4caaf18fe93ffa37a825534c8ce051f023be2305773ad76775c316addc96b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
