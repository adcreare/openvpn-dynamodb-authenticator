lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
    s.name           = 'openvpn-dynamodb-authenticator'
    s.version        = '0.0.1'
    s.platform       = Gem::Platform::RUBY
    s.authors        = ['David Taberner']
    s.email          = ['David.Taberner@reckon.com', 'David@commscentral.net']
    s.homepage       = 'https://github.com/Reckon-Limited/onus'
    s.summary        = %q{ Openvpn authentication script }
    s.description    = %q{ Openvpn authentication script that takes user credentials from dynamodb and
                        verifies them as matching the stored password in dynamodb
                        Leverages unix sha512 $6 style passwords to ensure easy migration
                        From existing login databases in /etc/shadow over to a central login database }
    s.files          = Dir.glob("{bin,lib}/**/*")
    s.executables    = ['ovpn-auth']
    s.bindir         = 'bin'
    s.add_dependency('unix-crypt', '~> 1.0')
    s.add_dependency('aws-sdk','~> 2.0')
    s.add_development_dependency('rake', '~> 0')
end
