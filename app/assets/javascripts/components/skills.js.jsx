var Skills = React.createClass({
  render: function(){
  debugger;
    var skills = this.props.skills
    var tags = this.props.tags
    var skillNodes = skills.map(function(skill, tags){
      debugger;
      return <Skill title={skill.title} tags={tags} key={skill.id} />
    });

    return(
      <div className="skills-list">
        {skillNodes}
      </div>
    )
  }
})
