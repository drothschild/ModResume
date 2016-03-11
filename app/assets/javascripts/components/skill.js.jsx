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
    return (
      <div>Title: {this.state.title} <a href="/tags">Tag</a></div>
    );
  }
});
