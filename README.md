#Install on your local machine:

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
apt update
apt install -y build-essential
apt install -y esl-erlang elixir
apt install -y nodejs npm
apt install -y postgresql postgresql-client libpq-dev


#CREATE APP
$ mix phx.new hangman --no-ecto
$ cd hangman
$ mix phx.server


#IN ASSETS
$ rm static/images/phoenix.png
$ rm css/phoenix.css
$ npm install --save milligram
$ npm install --save-dev @babel/preset-env @babel/preset-react
$ npm install --save react react-dom
$ npm install --save lodash jquery # common libraries

Add react preset to babel in webpack config:

 module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react'],
            plugins: ['@babel/plugin-proposal-class-properties']
          },
        }
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      }
    ]
  },




IN CSS
# remove @import "./phoenix.css"
@import "~milligram/dist/milligram";
