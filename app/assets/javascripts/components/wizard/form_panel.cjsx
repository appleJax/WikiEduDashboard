React         = require 'react'
Panel         = require './panel'
TextInput     = require '../common/text_input'
CourseActions = require '../../actions/course_actions'
ServerActions = require '../../actions/server_actions'

FormPanel = React.createClass(
  displayName: 'FormPanel'
  updateDetails: (value_key, value) ->
    to_pass = @props.course
    to_pass[value_key] = value
    CourseActions.updateCourse to_pass, true
  render: ->
    timeline_start_props =
      minDate: moment(@props.course.start)
      maxDate: moment(@props.course.timeline_end).subtract(Math.max(1, @props.weeks), 'week')
    timeline_end_props =
      minDate: moment(@props.course.timeline_start).add(Math.max(1, @props.weeks), 'week')
      maxDate: moment(@props.course.end)
    raw_options = (
      <div className='wizard__form'>
        <div className='column'>
          <TextInput
            onChange={@updateDetails}
            value={@props.course.timeline_start}
            value_key='timeline_start'
            editable=true
            type='date'
            id='assignment_start_wizard'
            label='Assignment Start'
            placeholder='Assignment Start'
            date_props={timeline_start_props}
          />
          <TextInput
            onChange={@updateDetails}
            value={@props.course.timeline_end}
            value_key='timeline_end'
            editable=true
            type='date'
            id='assignment_end_wizard'
            label='Assignment End'
            placeholder='Assignment End'
            date_props={timeline_end_props}
          />
        </div>
      </div>
    )

    <Panel {...@props} raw_options={raw_options} />
)

module.exports = FormPanel