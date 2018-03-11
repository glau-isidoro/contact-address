require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "#create" do
    post '/users', params: { name: "zé", cep: "03531000" }
    assert_response 200
    assert_equal 'application/json', @response.content_type
    assert_includes @response.body, "\"street\":\"Avenida Pasteur\""
  end
  
  test "#show" do
    user = User.create(name: 'maria', email: 'ma@email.com')
    user.create_address(cep: '03531-000', street: 'Avenida Pasteur', city: 'São Paulo')
    get "/users/#{user.id}"
    assert_response 200
    assert_equal 'application/json', @response.content_type
    assert_includes @response.body, "\"street\":\"Avenida Pasteur\""
  end
  
  test '#update' do
    user = User.create(name: 'joana', email: 'jo@email.com')
    user.create_address(cep: '03531-000', street: 'Avenida Pasteur', city: 'São Paulo')
    put "/users/#{user.id}", params: { cep: "04265060"}
    assert_response 200
    assert_equal 'application/json', @response.content_type
    assert_includes @response.body, "\"street\":\"Rua Mont\'Alverne\""
  end
  
  test "#destroy" do
    user = User.create(name: 'manuel', email: 'nuel@email.com')
    user.create_address(cep: '03531-000', street: 'Avenida Pasteur', city: 'São Paulo')
    delete "/users/#{user.id}"
    assert_response 200
    assert_nil User.find_by(name: 'manuel')
  end
end
