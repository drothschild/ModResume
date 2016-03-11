var Resume = React.createClass({
  propTypes: {
    targetJob: React.PropTypes.string,
    documentData: React.PropTypes.node
  },

  getInitialState: function (){
    return{
      targetJob: this.props.resume.target_job,
      documentData: this.props.resume.document_data
    }
  },

  render: function() {
    // debugger
    return (
      <div>
        <div>Target Job: {this.state.targetJob}</div>
        <div>Document Data: {this.state.documentData}</div>
      </div>
    );
  }
});
