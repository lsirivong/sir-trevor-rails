module SirTrevorRails
  class BlockArray < Array

    def self.from_json(str, parent = nil)
      blocks = MultiJson.load(str, symbolize_keys: true)

      new build_blocks(blocks, parent)
    end

    def self.from_hash(hash, parent = nil)
      blocks = (hash || Hash.new).symbolize_keys

      new build_blocks(blocks, parent)
    end

    def has_block_of_type?(type)
      klass = Block.block_class(type)
      any? { |b| b.is_a? klass }
    end

    def first_block_of_type(type)
      klass = Block.block_class(type)
      detect { |b| b.is_a? klass }
    end

    private

    def self.build_blocks(block_hashes, parent = nil)
      block_hashes = block_hashes[:data] if block_hashes.is_a?(Hash)
      block_hashes.map! { |block_obj| SirTrevorRails::Block.from_hash(block_obj, parent) }
    end
  end
end
