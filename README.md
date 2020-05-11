# Email sinatra

This is a project in sinatra that send emails through an endpoint

# Requeriments

* Ruby 2.6.5

# Configuration

Is important that you create a environment file as `.env` in your project before build it, and add the next variables:

```
# .env
USERNAME="your_email@example.com"
PASSWORD="write_your_pass_here"
```

# How to run with docker?

To build and run the image you can run the `start.sh` file in your terminal

```
$ sh start.sh
```

To stop the image

```
$ sh stop.sh
```

# Endpoints

## Send email

You can send an email through the next endpoint

## Send email through the API
```
POST http://localhost:8083/send_email

Parameters:
{
  "subject": "My subject"
  "message": "my message",
  "email": "receiver@example.com",
}
```

