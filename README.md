# Tables Booking

The application for tables booking management. Tech Task

## Running with Docker Compose

1. Prepare `.env` file. Copy `.env.example` to `.env`. Replace vars if needed.

2. Build images and run setup

   ```sh
   docker-compose build
   docker-compose run --rm web bundle install
   docker-compose run --rm web rails db:setup
   ```

3. Run the web and Postgres DB

   ```sh
   docker-compose up
   ```

   <dl>
       <dt><code>-d</code></dt>
       <dd>to run in detached mode</dd>
       <dt><code>--build</code></dt>
       <dd>to rebuild</dd>
   </dl>

4. Run `bundle install` to install missing gems.

   ```sh
   bundle install
   ```

5. Stop the application

   ```sh
   docker-compose down
   ```

## Debugging

Put `binding.pry` wherever you need, run your flow and attach the container to enter console for debugging session

```sh
docker attach %web_container_name%
```
