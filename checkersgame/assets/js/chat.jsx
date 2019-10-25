import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

//TODO: figure this out
// export default function chat_init(root, channel) {
//     console.log("sindei" );
//     console.log(channel)
//   ReactDOM.render(<GameBoard channel={channel}/>, root);
// }

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
        console.log("Clicked!")

        this.channel.push("click", { move: ev })
        .receive("ok", this.got_view.bind(this));
    }


    render() {

        return (

        );
    }
}
