use actix_web::{middleware, web, App, HttpResponse, HttpServer, Responder};
use env_logger;
use serde::Deserialize;
use std::io;

#[derive(Deserialize)]
struct WebhookEvent {
    // Define the fields you expect from GitHub
}

async fn handle_webhook(webhook_data: web::Json<WebhookEvent>) -> impl Responder {
    // Process the webhook data
    HttpResponse::Ok().body("Webhook received")
}

#[actix_web::main]
async fn main() -> io::Result<()> {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default()) // Use the Logger middleware
            .route("/webhook", web::post().to(handle_webhook))
    })
    .bind(("0.0.0.0", 8000))?
    .run()
    .await
}
