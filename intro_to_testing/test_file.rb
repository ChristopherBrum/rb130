=begin
- Modify the given code such that it prints the expected output
- Read the text from a simple test file that you provide
- You can use the Ruby File class to work with files
- Read the test file in the #process method and pass the text to the block
  provided in each call
- You shouldn't need additional changes beyond the #process method or the blocks
- You can have different numbers than the sample output, but you should have the
  indicated format
File::open
- open(filename, mode="r") { |file| block } -> obj
- When given a block, the block is passed the opened file as an argument
- The File object wil automatically be closed when the block terminates
- The value of the block is returned by the ::open method
- file = File.open("filename.txt") => opens file and creates a file object
  - does not retrieve contents of file
Reading the file:
- read the whole file all at once : file_data = file.read
- for multi-line files you can split the file_data, or use readlines
  plus the chomp method to remove new_line characters:
  - file_data = file.readlines.map(&:chomp)
- close the file when done to free up memory and system resources
  - file.close
- OR, use File::read:
  - file_data = File.read("user.txt").split
- Process the file one line at a time using File::foreach
  - File.foreach(filename) { |line| # does something }
- paragraphs are separated by an empty line
- each line ends with a newline character
- a single space separates all the words
=end

class TextAnalyzer
  def process(file_name)
    file = File.open(file_name, 'r+')
    if block_given?
      yield(file.read) 
    end
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process('test_file.txt') { |text| puts "#{text.split(/\n\n/).length} paragraph" } # 3 paragraph
analyzer.process('test_file.txt') { |text| puts "#{text.split(/\n\n/).length} lines" } # 15 lines
analyzer.process('test_file.txt') { |text| puts "#{text.split(' ').length} words" } # 126 words