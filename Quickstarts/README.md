# Quickstart

You can get up and running on Alchemy quickly by installing one of the quickstart projects.

## Installation

The Alchemy CLI can help you get started with one of the [Quickstart](Quickstarts/) templates. It is installable with [Mint](https://github.com/yonaskolb/Mint).

```shell
mint install alchemy-swift/cli@main
```

```shell
alchemy new MyNewProject
```

You'll be guided through picking a new project template, either `Backend` or `Fullstack`.

## Templates

There are two template projects for quickly getting up and running on Alchemy.

### Backend

A package that's an executable Alchemy server. Out of the box it contains some contrived endpoints that might be used in a "Todo" app backend.

It demonstrates:
- Connecting to a database
- Database schema migrations
- Rune ORM models
- Querying the database with Rune and the built in Query Builder
- Eager loading and relationships
- Routing
- Dynamic path parameters
- Using `TokenAuthMiddleware` to automatically authorize incoming requests
- Loading a `.env` file 
- Scheduling recurring jobs
- Type safe HTML with Plot
- Serving static files

It provides the following endpoints

**Unauthorized**:

- `POST /signup` create a new user
- `POST /login` login an existing user

**Requires Token Auth (via `Authorization: Bearer <token>` header)**:

- `GET /user` gets the existing user
- `GET /user/tag` gets all the user's tags, to be used when creating todos
- `POST /user/tag` creates a new tag for todos
- `POST /logout` logs out the existing user, invalidating their auth token
- `GET /todo` gets all the user's todos
- `POST /todo` creates a todo, with tags
- `DELETE /todo/:todoID` gets the user's todos
- `PATCH /todo/:todoID` marks a todo as complete

#### Running It

Getting up and running is simple.

1. Change the variables in `.env` to your database info.
2. Run migrations to add tables to your database via either `swift run Backend migrate` or running in Xcode with the `migrate` argument.
3. Run the `Backend` executable, either in Xcode or with `swift run`. By default, it serves on `localhost:8888`.

**Important Note** if you are running from Xcode, you need to change your scheme's working directory so that the server can see the `.env` and static files in `Public`:

click current scheme -> `Edit Scheme` -> `Run` on left bar -> `Options` on top bar -> `Working Directory: Use custom working directory` -> set to the `Backend` project's root path, like `/Users/josh/src/MyAlchemyProject`.

### Fullstack

This project is a single Xcode project that contains three targets; an iOS app, the `Backend` package from above, and a `Shared` library providing shared code for them.

The `Shared` library contains type safe API definitions of the endpoints mentioned above using `Papyrus`. The `Backend` serves them and the iOS app is simple todo app built with these endpoints.

It demonstrates:
- Everything in `Backend`
- Providing Papyrus endpoints on the backend
- Requesting Papyrus endpoints on iOS
- Enforcing type safety by sharing Papyrus endpoints between client and server

#### Running It

If you've worked with Xcode projects before, getting it running is just what you'd expect.

1. Open the Xcode project. Packages will take a bit to load.
2. Follow the `Running It` steps from `Backend` above.
3. Run `Backend` either by CLI or Xcode.
4. Run the `iOS` scheme in Xcode. Note that you can simultaneously run both `Backend` and `iOS` in Xcode. You can switch between the outputs of each program by selecting the program name above the console output at the bottom.
