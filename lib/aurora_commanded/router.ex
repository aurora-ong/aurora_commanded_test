defmodule AuroraCommanded.Router do
  use Commanded.Commands.Router

  dispatch CreateUO, to: CreateUOHandler, aggregate: UO, identity: :uo_id
  dispatch CreateUO2, to: UOTreeAgreggate, identity: :uo_id

  dispatch RegisterPerson, to: Person, identity: :person_id
  # dispatch StartMembership, to: Start, identity: :membership_id
  dispatch StartMembership, to: StartMembershipHandler, aggregate: UO, identity: :uo_id

  dispatch CreateProject, to: CreateProjectHandler, aggregate: Project, identity: :project_id
  dispatch CreateTask, to: CreateTaskHandler, aggregate: Project, identity: :project_id
end
