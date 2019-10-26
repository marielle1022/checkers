import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

//TODO: figure this out
  //TODO: ANYTIME ANYTHING is done, send it to backupagent
class Chat extends Component {
  constructor(props) {
    super(props)
    this.channel = props.channel;
    this.state = {
    };

    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => {console.log("Unable to join", resp); });

        console.log("after join")
        this.channel.on("update", this.got_view.bind(this));
    }

    got_view(view) {
        console.log("new view", view);
        this.setState(view.game);
    }


    handleClick() {
        console.log("Shout!")
        this.channel.push("message", { move: ev })
        .receive("ok", this.got_view.bind(this));
    }


    render() {

        return (
            <div className="chat">
            </div>

        );
    }
}
