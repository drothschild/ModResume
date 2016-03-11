var Skills = React.createClass({
  render: function(){
    var skillNodes = this.props.skills.map(function(skill){
      return <Skill title={skill.title} key={skill.id} />
    });
    return(
      <div className="skills-list">
        {skillNodes}
      </div>
    )
  }
})
