
require 'rest-more'
require 'tempfile'
require 'thread'

access_token = 'AAACEdEose0cBACQnZC42ccaJ1gvldTFWYAZBnUVwAEZAiGMV0WeYXuG7G56Sh1q1Ef7HFPxS7ucZCZBE2etZBDob02kspivL5d2BwjDJBWSPK905HjSQ5N'

facebook = RC::Facebook.new(:access_token => access_token,
                            :log_method => method(:puts),
                            :timeout => 60, :cache => {})

mutex = Mutex.new

def download url
  tmp = Tempfile.new(['image', File.extname(url)])
  Thread.new{
    system('curl', '-o', tmp.path, url)
    yield(`identify -format %wx%h #{tmp.path}`.strip.split('x'), tmp)
  }
end

w, h, t, tt = {}, {}, {}, {}
feed   = facebook.get('me/feed')
events = facebook.get('me/events')

facebook.get('me/photos') do |me|
  mutex.synchronize do
    tt['me'] = download(me['data'].first['picture']) do |(ww, hh), tmp|
      mutex.synchronize{ w['me'], h['me'], t['me'] = ww, hh, tmp }
    end
  end
end
facebook.get('me/friends') do |fr|
  fr['data'].take(2).each.with_index do |f, idx|
    fid = 'me' # f['id']
    facebook.get("#{fid}/photos") do |fp|
      mutex.synchronize do
        tt[idx] = download(fp['data'].first['picture']) do |(ww, hh), tmp|
          mutex.synchronize{ w[idx], h[idx], t[idx] = ww, hh, tmp }
        end
      end
    end
  end
end

facebook.post('me/feed', :message => "#{feed}#{events}")

facebook.wait
tt.values.each(&:join)
p w
p h
p t
