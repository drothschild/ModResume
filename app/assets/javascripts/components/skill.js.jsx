var Skill = React.createClass({
  propTypes:{
    title: React.PropTypes.string
  },
  getInitialState: function(){
    return{
      title: this.props.title
    }
  },
  render: function(){
    debugger;
    return (
      <div>Title: {this.props.title}</div>
    );
  }
});
