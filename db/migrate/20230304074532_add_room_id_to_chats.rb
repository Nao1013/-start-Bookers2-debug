class AddRoomIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :room_id, :integer
  end
end
