module Actions
  module Katello
    module Repository
      class CloneFileContent < Actions::Base
        def plan(source_repo, target_repo)
          sequence do
            plan_action(Pulp::Repository::CopyFiles,
                        source_pulp_id: source_repo.pulp_id,
                        target_pulp_id: target_repo.pulp_id)
            plan_action(Katello::Repository::MetadataGenerate, target_repo)
          end
        end
      end
    end
  end
end
