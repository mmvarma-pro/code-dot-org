require 'test_helper'

class UserPreferencesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test 'updates section_order for the current user' do
    section_order = ['1', '2', '3']

    patch :update, params: {section_order: section_order}

    assert_response :success

    preference = UserPreference.find_by(user_id: @user.id)
    assert_equal section_order, preference.section_order
  end

  test 'updates console_font_size for the current user' do
    console_font_size = {'pythonlab' => 'medium'}

    patch :update, params: {console_font_size: console_font_size}

    assert_response :success

    preference = UserPreference.find_by(user_id: @user.id)
    assert_equal console_font_size, preference.console_font_size
  end

  test 'updates editor_font_size for the current user' do
    editor_font_size = {'weblab2' => 'large'}

    patch :update, params: {editor_font_size: editor_font_size}

    assert_response :success

    preference = UserPreference.find_by(user_id: @user.id)
    assert_equal editor_font_size, preference.editor_font_size
  end

  test 'updates existing preference for section_order without creating a new record' do
    initial_order = ['3', '2', '1']
    preference = UserPreference.create!(user_id: @user.id, section_order: initial_order)

    new_order = ['1', '2', '3']

    assert_no_difference 'UserPreference.count' do
      patch :update, params: {section_order: new_order}
    end

    assert_response :success

    preference.reload
    assert_equal new_order, preference.section_order
  end

  test 'updates existing preference for editor_font_size without creating a new record and merges successfully' do
    initial_editor_font_size = {
      'pythonlab'=> 'small'
    }
    preference = UserPreference.create!(user_id: @user.id, editor_font_size: initial_editor_font_size)

    new_editor_font_size = {
      'weblab2'=> 'medium'
    }
    merged_editor_font_size = {
      'pythonlab'=> 'small',
      'weblab2'=> 'medium'
    }

    assert_no_difference 'UserPreference.count' do
      patch :update, params: {editor_font_size: new_editor_font_size}
    end

    assert_response :success

    preference.reload
    assert_equal merged_editor_font_size, preference.editor_font_size
  end

  test 'ignores non-permitted parameters' do
    section_order = ['1', '2', '3']

    patch :update, params: {
      section_order: section_order,
      unpermitted_param: 'should be ignored'
    }

    assert_response :success

    preference = UserPreference.find_by(user_id: @user.id)
    assert_equal section_order, preference.section_order
    assert_nil preference.attributes['unpermitted_param']
  end
end
