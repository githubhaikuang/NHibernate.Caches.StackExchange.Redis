module NuGet
  def self.os
    @os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      when /solaris|bsd/
        :unix
      else
        raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
      end
    )
  end

  def self.exec(parameters)

    command = File.join(File.dirname(__FILE__),"NuGet.exe")
    if self.os == :windows
      system "#{command} #{parameters}"
    else
      system "mono --runtime=v4.0.30319 #{command} #{parameters} "
    end
  end

  def self.xunit_path
    cmds = Dir.glob(File.join(File.dirname(__FILE__),"..","packages","xunit.runners.*","tools","xunit.console.clr4.exe"))
    if cmds.any?
        command = cmds.first
    else
      raise "Could not find xunit runner!"
    end
  end

end
