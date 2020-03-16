#!/usr/bin/env ruby
#
commits = `git log --oneline origin/master --first-parent -n 45 --format="%H"`.split

# TODO: bisec instead.
commits.each_slice(15) do |batch|
  threads = batch.map { |commit|
    Thread.new {
      status = "success"
      puts "#{commit}: #{status}"

      if status == "success"
        commit
      else
        nil
      end
    }
  }

  threads.each do |thread|
    if thread.join && commit = thread.value
      puts commit
      return
    end
  end
end
