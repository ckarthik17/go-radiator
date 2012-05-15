require_relative 'lib/spec_helper'

describe "Pipeline" do
  context "current stage" do
    it "should return the first stage because it's building" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "building", ""
      stage2 = Stage.new '2', "success", ""
      stage3 = Stage.new '3', "failure", ""
      stage4 = Stage.new '4', "success", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.stages << stage3
      pipeline1.stages << stage4
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '1'
    end

    it "should return the current building stage" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "building", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '2'
    end

    it "should return the current building stage after failure" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "building", ""
      stage3 = Stage.new '3', "failure", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.stages << stage3
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '2'
    end

    it "should return failure if no stages are building" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "failure", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '2'
    end

    it "should return first failure if more than one" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "failure", ""
      stage2 = Stage.new '2', "failure", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '1'
    end

    it "should return last Successful stage if all completed" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "success", ""
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '2'
    end

    it "should return latest Successful stage if all completed" do
      pipeline1 = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", "2011-12-06T18:28:16"
      stage2 = Stage.new '2', "clear", "2011-12-05T18:30:19"
      pipeline1.stages << stage1
      pipeline1.stages << stage2
      pipeline1.set_current_stage

      pipeline1.current_stage.first.name.should == '1'
    end
  end

  context "percentage complete" do

    it "should return the correct percentage complete on stage 1" do
      pipeline = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "building", ""
      stage2 = Stage.new '2', "success", ""
      stage3 = Stage.new '3', "success", ""
      pipeline.stages << stage1
      pipeline.stages << stage2
      pipeline.stages << stage3
      pipeline.set_current_stage

      pipeline.percentage_complete.should == 33.33
      pipeline.progress_css.should == 'progress-warning progress-striped active'
    end

    it "should return the correct percentage complete on failure at stage 1" do
      pipeline = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "failure", ""
      stage2 = Stage.new '2', "success", ""
      stage3 = Stage.new '3', "success", ""
      pipeline.stages << stage1
      pipeline.stages << stage2
      pipeline.stages << stage3
      pipeline.set_current_stage

      pipeline.percentage_complete.should == 33.33
      pipeline.progress_css == 'progress-danger'
    end

    it "should return the correct percentage complete on failure at stage 2" do
      pipeline = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "failure", ""
      stage3 = Stage.new '3', "success", ""
      pipeline.stages << stage1
      pipeline.stages << stage2
      pipeline.stages << stage3
      pipeline.set_current_stage

      pipeline.percentage_complete.should == 66.67
      pipeline.progress_css == 'progress-danger'
    end

    it "should return the correct percentage complete for even number" do
      pipeline = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "failure", ""
      stage3 = Stage.new '3', "success", ""
      stage4 = Stage.new '4', "success", ""
      pipeline.stages << stage1
      pipeline.stages << stage2
      pipeline.stages << stage3
      pipeline.stages << stage4
      pipeline.set_current_stage

      pipeline.percentage_complete.should == 50
      pipeline.progress_css == 'progress-danger'
    end

    it "should return the correct percentage complete on all successful" do
      pipeline = Pipeline.new 'pipeline', '2', '2011-11-11T11:00:00'
      stage1 = Stage.new '1', "success", ""
      stage2 = Stage.new '2', "success", ""
      stage3 = Stage.new '3', "success", ""
      pipeline.stages << stage1
      pipeline.stages << stage2
      pipeline.stages << stage3
      pipeline.set_current_stage

      pipeline.percentage_complete.should == 100
      pipeline.progress_css == 'progress-success'
    end

  end

end