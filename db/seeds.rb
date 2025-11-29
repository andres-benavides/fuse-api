# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require 'open-uri'
require 'json'

puts "Cleaning DB..."
Ticket.delete_all
UserStory.delete_all
Project.delete_all
User.delete_all
Company.delete_all

puts "Creating companies..."
c1 = Company.create!(name: "Tech Corp", nit: "11111111-1", phone: "3001234567", address: "Calle 1 # 2-3", email: "info@techcorp.com")
c2 = Company.create!(name: "Ecommerce SA", nit: "22222222-2", phone: "3009876543", address: "Calle 4 # 5-6", email: "contacto@ecommerce.com")
c3 = Company.create!(name: "Finanzas Ltda", nit: "33333333-3", phone: "3012345678", address: "Carrera 7 # 8-9", email: "hello@finanzas.com")

puts "Creating users..."
u1 = User.create!(name: "Usuario Tech", email: "user1@demo.com", password: "password", password_confirmation: "password", company: c1)
u2 = User.create!(name: "Usuario Ecommerce", email: "user2@demo.com", password: "password", password_confirmation: "password", company: c2)
u3 = User.create!(name: "Usuario Finanzas", email: "user3@demo.com", password: "password", password_confirmation: "password", company: c3)

puts "Creating projects..."
p1 = c1.projects.create!(name: "Proyecto Plataforma Interna", description: "Plataforma interna de gestión.")
p2 = c2.projects.create!(name: "Ecommerce Web", description: "Tienda en línea para ventas.")
p3 = c2.projects.create!(name: "Ecommerce App", description: "App móvil para ventas.")


def create_project_data(project, user)
  3.times do |i|
    us = project.user_stories.create!(
      title: "Historia #{i + 1} - #{project.name}",
      description: "Descripción de la historia #{i + 1} del proyecto #{project.name}"
    )

    2.times do |j|
      us.tickets.create!(
        title: "Ticket En Proceso #{j + 1} - #{us.title}",
        description: "Trabajo en progreso",
        comments: "Comentario #{j + 1}",
        status: :in_process,
        user: user
      )
    end

    2.times do |j|
      us.tickets.create!(
        title: "Ticket Finalizado #{j + 1} - #{us.title}",
        description: "Trabajo finalizado",
        comments: "Comentario #{j + 1}",
        status: :finished,
        user: user
      )
    end

    us.tickets.create!(
      title: "Ticket Activo - #{us.title}",
      description: "Pendiente por iniciar",
      comments: "Aún sin iniciar",
      status: :active,
      user: user
    )
  end
end

puts "Creating stories & tickets..."
create_project_data(p1, u1)
create_project_data(p2, u2)
create_project_data(p3, u2)

puts "Done!"