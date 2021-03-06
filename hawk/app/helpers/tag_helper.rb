#======================================================================
#                        HA Web Konsole (Hawk)
# --------------------------------------------------------------------
#            A web-based GUI for managing and monitoring the
#          Pacemaker High-Availability cluster resource manager
#
# Copyright (c) 2009-2015 SUSE LLC, All Rights Reserved.
#
# Author: Tim Serong <tserong@suse.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it would be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# Further, this software is distributed without any warranty that it is
# free of the rightful claim of any third person regarding infringement
# or the like.  Any license provided herein, whether implied or
# otherwise, applies only to this software file.  Patent licenses, if
# any, provided herein do not apply to combinations of this program with
# other software, or any other product whatsoever.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
#
#======================================================================

module TagHelper
  def navbar_item(text, icon)
    text_icon(
      content_tag(
        :span,
        text,
        class: "hidden-xs"
      ),
      icon
    )
  end

  def text_icon(text, icon, options = {})
    [
      text,
      icon_tag(icon, options)
    ].join("\n").html_safe
  end

  def icon_text(icon, text, options = {})
    [
      icon_tag(icon, options),
      text
    ].join("\n").html_safe
  end

  def icon_tag(icon, options = {})
    defaults = {
      class: "fa fa-#{icon} #{options.delete(:class)}".strip
    }

    content_tag(:i, "", defaults.merge(options))
  end

  def jsviews_for(name, &block)
    content = capture do
      yield
    end

    [
      "{^{for #{name}}}",
      content,
      "{{/for}}"
    ].join("\n").html_safe
  end

  def tag_refs_list
    options = @cib.resources.map(&:id).sort do |a, b|
      a.natcmp(b, true)
    end
  end
end
