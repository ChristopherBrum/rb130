=begin
Write a program that can calculate the Hamming distance between two DNA strands

A mutation is simply a mistake that occurs during the creation or copying of a
nucleic acid, in particular DNA. Because nucleic acids are vital to cellular
functions, mutations tend to cause a ripple effect throughout the cell.
Although mutations are technically mistakes, a very rare mutation may equip
the cell with a beneficial attribute. In fact, the macro effects of evolution
are attributable by the accumulated result of beneficial microscopic mutations
over many generations.

The simplest and most common type of nucleic acid mutation is a point mutation,
which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands taken
from different genomes with a common ancestor, we get a measure of the minimum
number of point mutations that could have occurred on the evolutionary path
between the two strands.

This is called the Hamming distance.

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^
The Hamming distance between these two DNA strands is 7.

The Hamming distance is only defined for sequences of equal length.
If you have two sequences of unequal length, you should compute the Hamming
distance over the shorter length.

Explicit
- the hamming distance is the number of differences between two DNA strands
of equal length
- if the strands are not of equal length compare the strands up to the length
of the shorter strand
-

Implicit
- Instances of the DNATest class will require a string argument at instantiation

- we will be testing the instance methods #hamming_distance
  - it will take on string 1 argument
  - if the argument is an empty string, return 0
  - return number of difs between the DNATest objects strand and given strand

DS
- string input
- integer output

Algo(s)
- #hamming_distance will take a string argument
  - determine which strand is shortere and initialize shorter strand to
  base_strand and longer to aux_strand
  - split strand into array of characters and iterate with index
    - if current character doesn't match character at the current index of
      given strand
      - save to new array
    - return size of array

=end

class DNA
  def initialize(dna_strand)
    @dna_strand = dna_strand
  end

  def hamming_distance(strand)
    counter = 0
    hamming_distance = 0

    until end_of_strand?(strand, counter)
      hamming_distance += 1 if dna_strand[counter] != strand[counter]
      counter += 1
    end

    hamming_distance
  end

  private

  attr_reader :dna_strand

  def end_of_strand?(strand, counter)
    dna_strand[counter].nil? || strand[counter].nil?
  end
end
