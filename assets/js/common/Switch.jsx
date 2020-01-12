import React from "react";
import { connect } from "react-redux";

const Switch = ({ current_scene, children }) => {
  let match = false;
  let element;

  React.Children.forEach(children, child => {
    if (!match && React.isValidElement(child)) {
      const { scene } = child.props;

      element = child;
      match = scene == current_scene;
    }
  });

  return match ? React.cloneElement(element) : <div>{current_scene}</div>;
};

const mapStateToProps = state => {
  const { scene } = state;

  return {
    current_scene: scene
  };
};

export default connect(mapStateToProps)(Switch);
