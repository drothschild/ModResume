var placeholder = document.createElement("li");
placeholder.className = "placeholder";

var List2 = React.createClass({
  getInitialState: function() {
    return {data: this.props.data};
  },


  dragStart: function(e){
    this.dragged = e.currentTarget;
    e.dataTransfer.effectAllowed-'move';
    e.dataTransfer.setData("text/html", e.currentTarget);

  },
  dragEnd: function(e){
    this.dragged.style.display ="block";
    this.dragged.parentNode.removeChild(placeholder);

    var data = this.state.data;
    var from = Number(this.dragged.dataset.id)
    var to = Number(this.over.dataset.id)
    if (from < to) to--;
    data.splice(to, 0, data.splice(from, 1)[0]);
    this.setState({data: data});
    // if(this.nodePlacement == "after") to ++;
  },

  dragOver: function(e){
    e.preventDefault();
    this.dragged.style.display = "none";
    if(e.target.className == "placholder") return;
    this.over = e.target;
    e.target.parentNode.insertBefore(placeholder, e.target);

    var relY = e.clientY - this.over.offsetTop;
    var height = this.over.offsetHeight / 2;
    var parent = e.target.parentNode;
    // if(relY > height){
    //   this.nodePlacement="after";
    //   parent.insertBefore(placeholder, e.target.nextElementSibling);
    // }
    // else if(relY < height){
    //   this.nodePlacement = "before"
    //   parent.insertBefore(placeholder, e.target);
    // }
  },
  render: function() {
    return <ul onDragOver={this.dragOver}>
      {this.state.data.map(function(item, i) {
        return (<li
                  data-id={i}
                  key={i}
                  draggable="true"
                  onDragEnd={this.dragEnd}
                  onDragStart={this.dragStart}
                >
                  {item}
                </li>
                )
      }, this)}
    </ul>
  }
});


