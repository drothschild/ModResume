var Resumes = React.createClass({

  render: function(){
    var resumeNodes = this.props.resumes.map(function (resume){
      return <Resume target_job={resume.target_job} document_data={resume.document_data} key={resume.id}/>
    });
    return(
      <div className="resume-list">
        { resumeNodes }
      </div>
    )
  }
});
