#
# Copyright 2013 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

module Actions
  module Katello
    module Repository
      class Sync < Actions::EntryAction

        include Helpers::RemoteAction
        include Helpers::Presenter

        input_format do
          param :id, Integer
        end

        def plan(repo)
          action_subject(repo)
          plan_action(Pulp::Repository::Sync, pulp_id: repo.pulp_id)
        end

        def finalize
          repo = ::Katello::Repository.find(input[:repository][:id])
          repo.index_content
        end

        def humanized_name
          _("Synchronize")
        end

        def presenter
          Helpers::Presenter::Delegated.new(self, Pulp::Repository::Sync)
        end
      end
    end
  end
end
