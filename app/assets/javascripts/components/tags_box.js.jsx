var TagBox = React.createClass({
  getInitialState: function (){
    return {data: this.props.data};
  },
  handleTagSubmit: function(tag){
    var tags = this.state.data;
    tag.id = Date.now();
    var newTags = tags.concat([tag]);
    this.setState({data: newTags});
    $.ajax({
      url: '/tags',
      dataType: 'json',
      type: 'POST',
      data: {tag: tag},
      success: function(data){
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err){
        this.setState({data: tags})
        console.error(err.toString());
      }.bind(this)
    });
  },
  render: function(){
    return(
      <div className="tagBox">
        <TagList data={this.state.data}/>
        <TagForm onTagSubmit={this.handleTagSubmit}/>
      </div>
    )
  }
});

var TagList = React.createClass({
  render: function(){
    var tagNodes = this.props.tags.map(function(tag){
    return(
      <Tag name={tag.name} key={tag.id}>
        {tag.name}
      </Tag>
    );
  });
    return (
      <div className="tagList">
        {tagNodes}
      </div>
    );
  }
});

var TagForm = React.createClass({
  getInitialState: function (){
    return {name: ''};
  },
  handleNameChange: function(e){
    this.setState({name: e.target.value});
  },
  handleSubmit: function(e){
    e.preventDefault();
    var name = this.state.name.trim();
    if(!name){
      return;
    }
    this.props.onTagSubmit({name: name});
    this.setState({name: ''});
  },
  render: function(){
    return(
        <form className="tagForm" onSubmit={this.handleSubmit}>
          <input
            type="text"
            placeholder="Tag Name"
            value={this.state.text}
            onChange={this.handleNameChange}
          />
        <input type="submit" value="Post" />
      </form>
    );
  }
})

var Tag = React.createClass({
  render: function(){
    return(
      // <div className="tag">{this.props.children}</div>
      <a href="/taggings" className="tag">{this.props.children}</a>
    )
  }
})
