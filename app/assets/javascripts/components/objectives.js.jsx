var Objectives = React.createClass({

  render: function() {
    var objectiveNodes = this.props.objectives.map(function(objective){
      return <Objective description={objective.description} key={objective.id} />
    });
    return (
      <div className= "objectives-list">
        {objectiveNodes}
        </div>
      )
  }
});
