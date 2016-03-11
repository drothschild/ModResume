var Objective = React.createClass({
  propTypes: {
    description: React.PropTypes.node
  },
  getInitialState: function(){
    return {
      description: this.props.description
    }
  },

  render: function() {
    return (
      <div>
        <div>Description: {this.state.description}</div>
      </div>
    );
  }
});
