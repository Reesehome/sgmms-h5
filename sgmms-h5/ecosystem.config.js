module.exports = {
  apps: [{
    name: 'sgmms-h5_pm2',
    script: 'build/webpack.dev.conf.js',

    // Options reference: https://pm2.io/doc/en/runtime/reference/ecosystem-file/
    args: 'one two',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],

  deploy: {
    production: {
      user: 'reese',
      host: '123.207.65.247',
      post: 80,
      ref: 'origin/master',
      repo: 'git@github.com:Reesehome/sgmms-h5.git',
      path: '/sgmms',
      'post-deploy': 'git pull && npm install && pm2 reload ecosystem.config.js --env production'
    }
  }
};
