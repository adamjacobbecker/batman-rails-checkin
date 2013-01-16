class UserListSerializer < UserSerializer
  has_one :latest_checkin
end
