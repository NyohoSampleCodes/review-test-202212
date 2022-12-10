# -*- coding: utf-8 -*-

module ReVIEW
  module Book
    class Base
    end
  end

  module LATEXBuilderOverride
    def texequation(lines, id = nil, caption = '')
      puts 'ここからtexequation。'

      captionstr = nil

      if id
        puts macro('begin', 'reviewequationblock')
        captionstr = if get_chap.nil?
                       macro('reviewequationcaption', "#{I18n.t('equation')}#{I18n.t('format_number_header_without_chapter', [@chapter.equation(id).number])}#{I18n.t('caption_prefix')}#{compile_inline(caption)}")
                     else
                       macro('reviewequationcaption', "#{I18n.t('equation')}#{I18n.t('format_number_header', [get_chap, @chapter.equation(id).number])}#{I18n.t('caption_prefix')}#{compile_inline(caption)}")
                     end
      end

      if caption_top?('equation') && captionstr
        puts captionstr
      end

      puts macro('begin', 'equation*')
      lines.each do |line|
        puts line
      end
      puts macro('end', 'equation*')

      if !caption_top?('equation') && captionstr
        puts captionstr
      end

      if id
        puts macro('end', 'reviewequationblock')
      end
      puts 'ここでtexequation終わり'
    end
  end

  class LATEXBuilder
    prepend LATEXBuilderOverride
  end
end
