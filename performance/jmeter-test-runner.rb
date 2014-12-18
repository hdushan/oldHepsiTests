require 'fileutils'
require "net/http"
require 'nokogiri'

module JmeterTestRunner
  class Test

    attr_reader :jmeter_path
    
    def initialize(jmeter_test_plan, jmeter_test_result, jmeter_test_result_format, jmeter_html_test_result, jmeter_version='2.12')
      @jmeter_test_plan = jmeter_test_plan
      @jmeter_test_result = jmeter_test_result
      @jmeter_test_result_format = jmeter_test_result_format
      @jmeter_binary_url = "http://ftp.itu.edu.tr/Mirror/Apache//jmeter/binaries/apache-jmeter-#{jmeter_version}.tgz"
      @jmeter_standard_plugin = "JMeterPlugins-Standard-1.2.0.zip"
      @jmeter_standard_plugin_url = "http://jmeter-plugins.org/downloads/file/" + @jmeter_standard_plugin
      @jmeter_extras_plugin = "JMeterPlugins-Extras-1.2.0.zip"
      @jmeter_extras_plugin_url = "http://jmeter-plugins.org/downloads/file/" + @jmeter_extras_plugin
      @jmeter_workspace = ENV['HOME']
      @jmeter_install_folder = "apache-jmeter-#{jmeter_version}"
      @jmeter_executable_file = "jmeter"
      @jmeter_standard_plugin_file = "#{@jmeter_workspace}/#{@jmeter_install_folder}/lib/ext/JMeterPlugins-Standard.jar"
      @jmeter_extras_plugin_file = "#{@jmeter_workspace}/#{@jmeter_install_folder}/lib/ext/JMeterPlugins-Extras.jar"
      @jmeter_path = "#{@jmeter_workspace}/#{@jmeter_install_folder}/bin"
      @jmeter_command = "#{@jmeter_path}/#{@jmeter_executable_file}"
      @jmeter_xslt_template_file = "#{@jmeter_workspace}/#{@jmeter_install_folder}/extras/jmeter-results-detail-report_21.xsl"
      @jmeter_html_output_file = jmeter_html_test_result
    end
    
    def start
      begin
        remove_old_benchmark_results(@jmeter_test_result, @jmeter_html_output_file)
        install_jmeter unless is_jmeter_installed?
        install_jmeter_standard_plugin unless is_jmeter_standard_plugin_installed?
        install_jmeter_extras_plugin unless is_jmeter_extras_plugin_installed?
        execute_jmeter_test(@jmeter_test_plan, @jmeter_test_result, @jmeter_test_result_format)
        create_html_output(@jmeter_html_output_file)  
      rescue => exception
        puts exception.message
        puts exception.backtrace
      end
    end
    
    def remove_old_benchmark_results(jmeter_test_result_file, jmeter_html_output_file)
      puts "\nClearing old JMeter test result file ...\n"
      FileUtils.rm_f(jmeter_test_result_file)
      FileUtils.rm_f(jmeter_html_output_file)
    end
    
    def is_jmeter_installed?
      puts "\nChecking for presence of jmeter executable file #{@jmeter_command}\n"
      return File.file? "#{@jmeter_command}"
    end
    
    def is_jmeter_standard_plugin_installed?
      puts "\nChecking for presence of jmeter standard plugin #{@jmeter_standard_plugin_file}\n"
      return File.file? "#{@jmeter_standard_plugin_file}"
    end
    
    def is_jmeter_extras_plugin_installed?
      puts "\nChecking for presence of jmeter extras plugin #{@jmeter_extras_plugin_file}\n"
      return File.file? "#{@jmeter_extras_plugin_file}"
    end
    
    def install_jmeter
      puts "\nInstalling JMeter...\n"
      FileUtils.mkdir_p @jmeter_workspace
      Dir.chdir(@jmeter_workspace) do
          `curl #{@jmeter_binary_url} | tar zxf -`
      end
      puts "\nJMeter installed into folder #{@jmeter_workspace} ...\n"
    end
    
    def install_jmeter_standard_plugin
      puts "\nInstalling JMeter Standard plugin...\n"
      Dir.chdir(@jmeter_workspace+"/"+@jmeter_install_folder) do
          `curl -LOk #{@jmeter_standard_plugin_url}; unzip -o #{@jmeter_standard_plugin}`
      end
      puts "\nJMeter Standard plugin installed into folder #{@jmeter_workspace}/#{@jmeter_install_folder} ...\n"
    end
    
    def install_jmeter_extras_plugin
      puts "\nInstalling JMeter Extras plugin...\n"
      Dir.chdir(@jmeter_workspace+"/"+@jmeter_install_folder) do
          `curl -LOk #{@jmeter_extras_plugin_url}; unzip -o #{@jmeter_extras_plugin}`
      end
      puts "\nJMeter Extras plugin installed into folder #{@jmeter_workspace}/#{@jmeter_install_folder} ...\n"
    end
    
    def execute_jmeter_test(test_plan, results_file, results_format)
      puts "\nExecuting JMeter test ...\n"
      puts "\nCommand executed: #{@jmeter_command} -n -Jjmeter.save.saveservice.output_format=#{results_format} -Jjmeter.save.saveservice.assertion_results=all -t #{test_plan} -l #{results_file}\n"
      `#{@jmeter_command} -n -Jjmeter.save.saveservice.output_format=#{results_format} -Jjmeter.save.saveservice.assertion_results=all -t #{test_plan} -l #{results_file}`
      puts "\nJMeter test completed ...\n"
    end
    
    def create_html_output(output_file)
      template = Nokogiri::XSLT(File.read(@jmeter_xslt_template_file))
      document = Nokogiri::XML(File.read(@jmeter_test_result))
      transformed_document = template.transform(document)
      File.open(output_file, 'w').write(transformed_document)
    end
    
  end
end
